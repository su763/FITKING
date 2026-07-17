/// tracker_bloc.dart
///
/// The central BLoC connecting all use cases and the repository to the UI.
///
/// ### Event → State flow
/// ```
/// UI dispatches TrackerEvent
///   → TrackerBloc.on<Event> handler executes
///     → calls CalculateDailyMacros usecase or TrackerRepository
///       → emits appropriate TrackerState
///         → UI rebuilds from BlocBuilder
/// ```
///
/// Stream subscriptions (watchDailyLogs) are stored and cancelled in [close].
library;

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:uuid/uuid.dart';

import '../../core/errors/failures.dart';
import '../../domain/models/food_item.dart';
import '../../domain/models/meal_log.dart';
import '../../domain/repositories/tracker_repository.dart';
import '../../domain/usecases/calculate_daily_macros.dart';
import 'tracker_event.dart';
import 'tracker_state.dart';

// ── TrackerBloc ────────────────────────────────────────────────────────────────

final class TrackerBloc extends Bloc<TrackerEvent, TrackerState> {
  TrackerBloc({
    required TrackerRepository repository,
    required CalculateDailyMacros calculateDailyMacros,
  })  : _repository = repository,
        _calculateDailyMacros = calculateDailyMacros,
        super(const TrackerInitial()) {
    on<LoadDailySummary>(_onLoadDailySummary);
    on<SubscribeToDailyLogs>(_onSubscribeToDailyLogs);
    on<SearchFoodQuery>(_onSearchFoodQuery);
    on<ClearFoodSearch>(_onClearFoodSearch);
    on<AddFoodToMeal>(_onAddFoodToMeal);
    on<RemoveFoodFromMeal>(_onRemoveFoodFromMeal);
    on<UpdateMealEntryGrams>(_onUpdateMealEntryGrams);
    on<SaveCurrentMealLog>(_onSaveCurrentMealLog);
    on<DiscardMealDraft>(_onDiscardMealDraft);
    on<DeleteMealLog>(_onDeleteMealLog);
  }

  final TrackerRepository _repository;
  final CalculateDailyMacros _calculateDailyMacros;
  static const _uuid = Uuid();

  /// Active Isar watch subscription — replaced on each [SubscribeToDailyLogs].
  StreamSubscription<dynamic>? _watchSubscription;

  // ── Daily Summary ──────────────────────────────────────────────────────────

  Future<void> _onLoadDailySummary(
    LoadDailySummary event,
    Emitter<TrackerState> emit,
  ) async {
    final loaded = state is TrackerLoaded ? state as TrackerLoaded : null;
    emit(TrackerLoading(previousLoaded: loaded));

    await _fetchAndEmitDay(
      date: event.date,
      emit: emit,
      preserveDraft: loaded,
    );
  }

  Future<void> _onSubscribeToDailyLogs(
    SubscribeToDailyLogs event,
    Emitter<TrackerState> emit,
  ) async {
    await _watchSubscription?.cancel();

    // Perform an immediate load first.
    add(LoadDailySummary(event.date));

    // Then subscribe to reactive updates.
    await emit.forEach(
      _repository.watchDailyLogs(event.date),
      onData: (result) {
        return result.fold(
          (failure) => TrackerError(
            message: _mapFailure(failure),
            previousLoaded: state is TrackerLoaded
                ? state as TrackerLoaded
                : null,
          ),
          (logs) {
            if (state is! TrackerLoaded) return state;
            final current = state as TrackerLoaded;
            return current.copyWith(mealLogs: logs);
          },
        );
      },
      onError: (e, st) => TrackerError(
        message: 'Unexpected stream error: $e',
        previousLoaded:
            state is TrackerLoaded ? state as TrackerLoaded : null,
      ),
    );
  }

  // ── Food Search ────────────────────────────────────────────────────────────

  Future<void> _onSearchFoodQuery(
    SearchFoodQuery event,
    Emitter<TrackerState> emit,
  ) async {
    if (event.query.trim().isEmpty) {
      add(const ClearFoodSearch());
      return;
    }

    final loaded = _requireLoaded(emit);
    if (loaded == null) return;

    // Emit intermediate searching state to show a spinner in the search bar.
    emit(
      TrackerSearchSuccess(
        date: loaded.date,
        summary: loaded.summary,
        mealLogs: loaded.mealLogs,
        draftEntries: loaded.draftEntries,
        draftMealType: loaded.draftMealType,
        searchQuery: event.query,
        searchResults: const [],
        isSearching: true,
      ),
    );

    final result = await _repository.searchFood(
      query: event.query,
      pageNumber: event.pageNumber,
    );

    if (isClosed) return;

    result.fold(
      (failure) => emit(
        TrackerError(
          message: _mapFailure(failure),
          previousLoaded: loaded,
        ),
      ),
      (foods) => emit(
        TrackerSearchSuccess(
          date: loaded.date,
          summary: loaded.summary,
          mealLogs: loaded.mealLogs,
          draftEntries: loaded.draftEntries,
          draftMealType: loaded.draftMealType,
          searchQuery: event.query,
          searchResults: foods,
          isSearching: false,
        ),
      ),
    );
  }

  void _onClearFoodSearch(
    ClearFoodSearch event,
    Emitter<TrackerState> emit,
  ) {
    var loaded = _requireLoaded(emit);
    if (loaded is TrackerSearchSuccess) {
      emit(
        TrackerLoaded(
          date: loaded.date,
          summary: loaded.summary,
          mealLogs: loaded.mealLogs,
          draftEntries: loaded.draftEntries,
          draftMealType: loaded.draftMealType,
        ),
      );
    }
  }

  // ── Meal Draft ─────────────────────────────────────────────────────────────

  void _onAddFoodToMeal(
    AddFoodToMeal event,
    Emitter<TrackerState> emit,
  ) {
    final loaded = _requireLoaded(emit);
    if (loaded == null) return;

    final entry = LoggedFoodEntry(
      id: _uuid.v4(),
      foodItem: event.food,
      consumedGrams: event.effectiveConsumedGrams,
    );

    final updated = List<LoggedFoodEntry>.unmodifiable(
      [...loaded.draftEntries, entry],
    );

    emit(
      loaded.copyWith(
        draftEntries: updated,
        draftMealType: event.mealType,
      ),
    );
  }

  void _onRemoveFoodFromMeal(
    RemoveFoodFromMeal event,
    Emitter<TrackerState> emit,
  ) {
    final loaded = _requireLoaded(emit);
    if (loaded == null) return;

    final updated = List<LoggedFoodEntry>.unmodifiable(
      loaded.draftEntries.where((e) => e.id != event.entryId),
    );

    emit(loaded.copyWith(draftEntries: updated));
  }

  void _onUpdateMealEntryGrams(
    UpdateMealEntryGrams event,
    Emitter<TrackerState> emit,
  ) {
    final loaded = _requireLoaded(emit);
    if (loaded == null) return;

    final updated = loaded.draftEntries.map((e) {
      return e.id == event.entryId
          ? e.copyWith(consumedGrams: event.consumedGrams)
          : e;
    }).toList(growable: false);

    emit(loaded.copyWith(draftEntries: List.unmodifiable(updated)));
  }

  Future<void> _onSaveCurrentMealLog(
    SaveCurrentMealLog event,
    Emitter<TrackerState> emit,
  ) async {
    final loaded = _requireLoaded(emit);
    if (loaded == null) return;

    if (loaded.draftEntries.isEmpty) {
      emit(
        TrackerError(
          message: 'Add at least one food item before saving.',
          previousLoaded: loaded,
        ),
      );
      return;
    }

    emit(loaded.copyWith(isSaving: true));

    final log = MealLog(
      id: _uuid.v4(),
      loggedAt: DateTime.now(),
      mealType: event.mealType,
      entries: List.unmodifiable(loaded.draftEntries),
      notes: event.notes,
    );

    final result = await _repository.saveMealLog(log);

    if (isClosed) return;

    await result.fold(
      (failure) async => emit(
        TrackerError(
          message: _mapFailure(failure),
          previousLoaded: loaded,
        ),
      ),
      (_) async {
        // Clear draft and reload the summary to reflect new totals.
        await _fetchAndEmitDay(
          date: loaded.date,
          emit: emit,
          preserveDraft: null, // draft is intentionally cleared
        );
      },
    );
  }

  void _onDiscardMealDraft(
    DiscardMealDraft event,
    Emitter<TrackerState> emit,
  ) {
    final loaded = _requireLoaded(emit);
    if (loaded == null) return;

    emit(
      loaded.copyWith(
        draftEntries: const [],
        draftMealType: MealType.other,
      ),
    );
  }

  // ── Log management ─────────────────────────────────────────────────────────

  Future<void> _onDeleteMealLog(
    DeleteMealLog event,
    Emitter<TrackerState> emit,
  ) async {
    final loaded = _requireLoaded(emit);
    if (loaded == null) return;

    emit(TrackerLoading(previousLoaded: loaded));

    final result = await _repository.deleteMealLog(event.logId);

    if (isClosed) return;

    await result.fold(
      (failure) async => emit(
        TrackerError(
          message: _mapFailure(failure),
          previousLoaded: loaded,
        ),
      ),
      (_) async => _fetchAndEmitDay(
        date: loaded.date,
        emit: emit,
        preserveDraft: null,
      ),
    );
  }

  // ── Private helpers ────────────────────────────────────────────────────────

  /// Fetches logs + summary for [date] and emits the appropriate state.
  Future<void> _fetchAndEmitDay({
    required DateTime date,
    required Emitter<TrackerState> emit,
    required TrackerLoaded? preserveDraft,
  }) async {
    final params = DailyMacroParams(
      date: date,
      // TODO(phase-5): pull from user profile; use defaults for now.
      calorieGoal: 2000,
      proteinGoalG: 150,
      carbsGoalG: 200,
      fatGoalG: 65,
    );

    final [summaryResult, logsResult] = await Future.wait([
      _calculateDailyMacros.execute(params),
      _repository.getDailyLogs(date),
    ]);

    if (isClosed) return;

    final summaryEither =
        summaryResult as dynamic; // typed via fold below
    final logsEither = logsResult as dynamic;

    // Both must succeed to emit TrackerLoaded.
    final failure = summaryEither.isLeft()
        ? (summaryEither as dynamic).fold((f) => f, (_) => null)
        : logsEither.isLeft()
            ? (logsEither as dynamic).fold((f) => f, (_) => null)
            : null;

    if (failure != null) {
      emit(
        TrackerError(
          message: _mapFailure(failure as Failure),
          previousLoaded: preserveDraft,
        ),
      );
      return;
    }

    final summary =
        (summaryEither as dynamic).fold((_) => null, (s) => s)
            as DailyMacroSummary;
    final logs = (logsEither as dynamic).fold((_) => null, (l) => l)
        as List<MealLog>;

    emit(
      TrackerLoaded(
        date: date,
        summary: summary,
        mealLogs: logs,
        draftEntries: preserveDraft?.draftEntries ?? const [],
        draftMealType: preserveDraft?.draftMealType ?? MealType.other,
      ),
    );
  }

  /// Returns the current state cast to [TrackerLoaded], or — if not loaded —
  /// emits a [TrackerError] and returns null.
  TrackerLoaded? _requireLoaded(Emitter<TrackerState> emit) {
    if (state is TrackerLoaded) return state as TrackerLoaded;
    emit(
      const TrackerError(
        message: 'Action dispatched before data was loaded.',
      ),
    );
    return null;
  }

  /// Converts a domain [Failure] into a user-readable string.
  static String _mapFailure(Failure failure) {
    return switch (failure) {
      NoInternetFailure() =>
        'No internet connection. Your data is saved locally.',
      TimeoutFailure() => 'Request timed out. Please try again.',
      ServerFailure(:final statusCode) =>
        'Server error${statusCode != null ? " ($statusCode)" : ""}. Please try again.',
      CacheFailure() => 'Storage error. Please restart the app.',
      CacheNotFoundFailure() => 'Data not found.',
      ValidationFailure(:final message) => message,
      DeserializationFailure() =>
        'Received unexpected data from server.',
      _ => failure.message,
    };
  }

  // ── Lifecycle ──────────────────────────────────────────────────────────────

  @override
  Future<void> close() async {
    await _watchSubscription?.cancel();
    return super.close();
  }
}
