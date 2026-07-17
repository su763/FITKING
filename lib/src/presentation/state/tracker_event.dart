/// tracker_event.dart
///
/// All events that the [TrackerBloc] can receive from the presentation layer.
///
/// Events are immutable value objects. Each event carries exactly the data
/// the BLoC needs to process it — no more, no less.
library;

import 'package:equatable/equatable.dart';

import '../../domain/models/food_item.dart';
import '../../domain/models/meal_log.dart';

// ── Base ──────────────────────────────────────────────────────────────────────

sealed class TrackerEvent extends Equatable {
  const TrackerEvent();

  @override
  List<Object?> get props => [];
}

// ── Daily Summary ─────────────────────────────────────────────────────────────

/// Requests the macro summary and all meal logs for [date].
///
/// Typical trigger: the user opens the dashboard or swipes to a different day.
final class LoadDailySummary extends TrackerEvent {
  const LoadDailySummary(this.date);

  /// The calendar day to load (time component is ignored).
  final DateTime date;

  @override
  List<Object?> get props => [date];
}

// ── Food Search ────────────────────────────────────────────────────────────────

/// Triggers a food search, first against the local Isar cache then the
/// remote FDC API if the cache returns no results.
///
/// Dispatched with a debounced query string from the search text field.
final class SearchFoodQuery extends TrackerEvent {
  const SearchFoodQuery(this.query, {this.pageNumber = 1});

  final String query;

  /// Pagination support — 1-indexed, defaults to the first page.
  final int pageNumber;

  @override
  List<Object?> get props => [query, pageNumber];
}

/// Clears any active food search results and returns to the loaded state.
final class ClearFoodSearch extends TrackerEvent {
  const ClearFoodSearch();
}

// ── Meal Draft ────────────────────────────────────────────────────────────────

/// Adds [food] to the in-memory draft meal, staging it for saving.
///
/// [consumedGrams] defaults to [food.servingSizeG] when not provided.
final class AddFoodToMeal extends TrackerEvent {
  const AddFoodToMeal({
    required this.food,
    double? consumedGrams,
    this.mealType = MealType.other,
  }) : consumedGrams = consumedGrams ?? -1;

  /// If no consumedGrams was provided, falls back to the food's serving size.
  double get effectiveConsumedGrams =>
      consumedGrams == -1 ? food.servingSizeG : consumedGrams;

  final FoodItem food;

  /// How many grams the user consumed; pre-filled with the standard serving.
  final double consumedGrams;

  /// Which meal slot this entry belongs to.
  final MealType mealType;

  @override
  List<Object?> get props => [food, consumedGrams, mealType];
}

/// Removes a staged entry from the draft meal by [entryId].
final class RemoveFoodFromMeal extends TrackerEvent {
  const RemoveFoodFromMeal(this.entryId);

  final String entryId;

  @override
  List<Object?> get props => [entryId];
}

/// Updates the [consumedGrams] for an existing draft entry [entryId].
final class UpdateMealEntryGrams extends TrackerEvent {
  const UpdateMealEntryGrams({
    required this.entryId,
    required this.consumedGrams,
  });

  final String entryId;
  final double consumedGrams;

  @override
  List<Object?> get props => [entryId, consumedGrams];
}

/// Persists the current in-memory draft meal to the local Isar database,
/// then re-loads the daily summary to reflect the updated totals.
final class SaveCurrentMealLog extends TrackerEvent {
  const SaveCurrentMealLog({
    required this.mealType,
    this.notes,
  });

  final MealType mealType;
  final String? notes;

  @override
  List<Object?> get props => [mealType, notes];
}

/// Discards the in-progress draft without saving.
final class DiscardMealDraft extends TrackerEvent {
  const DiscardMealDraft();
}

// ── Log Management ─────────────────────────────────────────────────────────────

/// Deletes a persisted [MealLog] by its [logId] and refreshes the summary.
final class DeleteMealLog extends TrackerEvent {
  const DeleteMealLog(this.logId);

  final String logId;

  @override
  List<Object?> get props => [logId];
}

/// Requests the [TrackerBloc] to start watching the day reactively
/// via [TrackerRepository.watchDailyLogs].
final class SubscribeToDailyLogs extends TrackerEvent {
  const SubscribeToDailyLogs(this.date);

  final DateTime date;

  @override
  List<Object?> get props => [date];
}
