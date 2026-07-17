/// tracker_state.dart
///
/// All states that [TrackerBloc] can emit to the presentation layer.
///
/// States are immutable value objects. Widgets rebuild only when the state
/// they depend on actually changes (Equatable equality).
library;

import 'package:equatable/equatable.dart';

import '../../domain/models/food_item.dart';
import '../../domain/models/meal_log.dart';
import '../../domain/usecases/calculate_daily_macros.dart';

// ── Base ───────────────────────────────────────────────────────────────────────

sealed class TrackerState extends Equatable {
  const TrackerState();

  @override
  List<Object?> get props => [];
}

// ── Initial ────────────────────────────────────────────────────────────────────

/// The BLoC has been instantiated but no event has been processed yet.
final class TrackerInitial extends TrackerState {
  const TrackerInitial();
}

// ── Loading ────────────────────────────────────────────────────────────────────

/// A long-running operation is in progress (page-level spinner).
///
/// [previousLoaded] lets the UI keep showing stale data behind a shimmer
/// while a reload is in flight.
final class TrackerLoading extends TrackerState {
  const TrackerLoading({this.previousLoaded});

  /// Optional previous [TrackerLoaded] state for stale-while-revalidate UX.
  final TrackerLoaded? previousLoaded;

  @override
  List<Object?> get props => [previousLoaded];
}

// ── Loaded ─────────────────────────────────────────────────────────────────────

/// The dashboard data is available and ready to render.
///
/// This is the primary stable state the UI spends most of its time in.
final class TrackerLoaded extends TrackerState {
  const TrackerLoaded({
    required this.date,
    required this.summary,
    required this.mealLogs,
    this.draftEntries = const [],
    this.draftMealType = MealType.other,
    this.isSaving = false,
  });

  /// The calendar day this data belongs to.
  final DateTime date;

  /// Pre-computed daily macro summary (totals + goal progress).
  final DailyMacroSummary summary;

  /// All persisted meal logs for [date], sorted chronologically.
  final List<MealLog> mealLogs;

  /// Staged (unsaved) food entries for the meal the user is composing.
  final List<LoggedFoodEntry> draftEntries;

  /// The meal slot the draft is being assigned to.
  final MealType draftMealType;

  /// True while [SaveCurrentMealLog] is being persisted.
  final bool isSaving;

  // ── Derived helpers ────────────────────────────────────────────────────────

  /// Aggregate macros of the current unsaved draft.
  MacroSnapshot get draftMacros => draftEntries.fold(
        MacroSnapshot.zero,
        (acc, e) => acc + e.macros,
      );

  bool get hasDraft => draftEntries.isNotEmpty;

  TrackerLoaded copyWith({
    DateTime? date,
    DailyMacroSummary? summary,
    List<MealLog>? mealLogs,
    List<LoggedFoodEntry>? draftEntries,
    MealType? draftMealType,
    bool? isSaving,
  }) {
    return TrackerLoaded(
      date: date ?? this.date,
      summary: summary ?? this.summary,
      mealLogs: mealLogs ?? this.mealLogs,
      draftEntries: draftEntries ?? this.draftEntries,
      draftMealType: draftMealType ?? this.draftMealType,
      isSaving: isSaving ?? this.isSaving,
    );
  }

  @override
  List<Object?> get props => [
        date,
        summary,
        mealLogs,
        draftEntries,
        draftMealType,
        isSaving,
      ];
}

// ── Search ─────────────────────────────────────────────────────────────────────

/// A food search has completed successfully.
///
/// Extends [TrackerLoaded] so the dashboard stays rendered behind the
/// search overlay — the user can still see their macro rings.
final class TrackerSearchSuccess extends TrackerLoaded {
  const TrackerSearchSuccess({
    required super.date,
    required super.summary,
    required super.mealLogs,
    required this.searchQuery,
    required this.searchResults,
    this.isSearching = false,
    super.draftEntries,
    super.draftMealType,
  });

  /// The query string that produced [searchResults].
  final String searchQuery;

  /// Ordered list of food items matching the query.
  final List<FoodItem> searchResults;

  /// True while a search network/cache request is in flight.
  final bool isSearching;

  bool get hasResults => searchResults.isNotEmpty;

  @override
  TrackerSearchSuccess copyWith({
    DateTime? date,
    DailyMacroSummary? summary,
    List<MealLog>? mealLogs,
    List<LoggedFoodEntry>? draftEntries,
    MealType? draftMealType,
    bool? isSaving,
    String? searchQuery,
    List<FoodItem>? searchResults,
    bool? isSearching,
  }) {
    return TrackerSearchSuccess(
      date: date ?? this.date,
      summary: summary ?? this.summary,
      mealLogs: mealLogs ?? this.mealLogs,
      draftEntries: draftEntries ?? this.draftEntries,
      draftMealType: draftMealType ?? this.draftMealType,
      searchQuery: searchQuery ?? this.searchQuery,
      searchResults: searchResults ?? this.searchResults,
      isSearching: isSearching ?? this.isSearching,
    );
  }

  @override
  List<Object?> get props => [
        ...super.props,
        searchQuery,
        searchResults,
        isSearching,
      ];
}

// ── Error ──────────────────────────────────────────────────────────────────────

/// A terminal failure occurred that the user needs to act on.
///
/// [previousLoaded] lets the UI render a recoverable error banner
/// over stale data rather than replacing the entire screen.
final class TrackerError extends TrackerState {
  const TrackerError({
    required this.message,
    this.previousLoaded,
  });

  /// User-facing error message derived from the domain [Failure].
  final String message;

  /// The last valid loaded state if available (for non-destructive errors).
  final TrackerLoaded? previousLoaded;

  bool get hasStaleData => previousLoaded != null;

  @override
  List<Object?> get props => [message, previousLoaded];
}
