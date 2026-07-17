/// calculate_daily_macros.dart
///
/// Use case: Aggregate all macronutrient data for a given calendar day.
///
/// This is a pure domain service — it accepts data structures, applies
/// business logic, and returns a result. It has no Flutter, Hive, or
/// Dio imports. It receives its data dependency via the [TrackerRepository]
/// abstraction so tests can inject a fake.
library;

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../models/food_item.dart';
import '../models/meal_log.dart';
import '../repositories/tracker_repository.dart';
import '../../core/errors/failures.dart';

// ── Input Params ─────────────────────────────────────────────────────────────

/// Parameters required by [CalculateDailyMacros].
final class DailyMacroParams extends Equatable {
  const DailyMacroParams({
    required this.date,
    this.calorieGoal = 2000,
    this.proteinGoalG = 150,
    this.carbsGoalG = 200,
    this.fatGoalG = 65,
  })  : assert(calorieGoal > 0, 'Calorie goal must be positive'),
        assert(proteinGoalG >= 0, 'Protein goal must be non-negative'),
        assert(carbsGoalG >= 0, 'Carbs goal must be non-negative'),
        assert(fatGoalG >= 0, 'Fat goal must be non-negative');

  /// The calendar day to compute macros for (time component is ignored).
  final DateTime date;

  /// User's daily calorie target in kcal.
  final double calorieGoal;

  /// User's daily protein target in grams.
  final double proteinGoalG;

  /// User's daily carbohydrate target in grams.
  final double carbsGoalG;

  /// User's daily fat target in grams.
  final double fatGoalG;

  @override
  List<Object?> get props =>
      [date, calorieGoal, proteinGoalG, carbsGoalG, fatGoalG];
}

// ── Output ────────────────────────────────────────────────────────────────────

/// Per-meal aggregated entry used within [DailyMacroSummary.mealBreakdown].
final class MealMacroEntry extends Equatable {
  const MealMacroEntry({
    required this.mealLogId,
    required this.mealType,
    required this.macros,
  });

  final String mealLogId;
  final MealType mealType;
  final MacroSnapshot macros;

  @override
  List<Object?> get props => [mealLogId, mealType, macros];
}

/// The aggregate result returned by [CalculateDailyMacros.execute].
final class DailyMacroSummary extends Equatable {
  const DailyMacroSummary({
    required this.date,
    required this.totalMacros,
    required this.mealBreakdown,
    required this.calorieGoal,
    required this.proteinGoalG,
    required this.carbsGoalG,
    required this.fatGoalG,
  });

  /// The calendar day this summary covers.
  final DateTime date;

  /// Sum of macros across all meals logged on [date].
  final MacroSnapshot totalMacros;

  /// Per-meal breakdown, ordered by meal log time ascending.
  final List<MealMacroEntry> mealBreakdown;

  // ── Goals ─────────────────────────────────────────────────────────────────

  final double calorieGoal;
  final double proteinGoalG;
  final double carbsGoalG;
  final double fatGoalG;

  // ── Progress helpers (0.0 – 1.0+, unclipped) ─────────────────────────────

  /// Fraction of the calorie goal consumed (may exceed 1.0 if overbudget).
  double get calorieProgress =>
      calorieGoal == 0 ? 0 : totalMacros.calories / calorieGoal;

  /// Fraction of the protein goal consumed.
  double get proteinProgress =>
      proteinGoalG == 0 ? 0 : totalMacros.proteinG / proteinGoalG;

  /// Fraction of the carbs goal consumed.
  double get carbsProgress =>
      carbsGoalG == 0 ? 0 : totalMacros.carbsG / carbsGoalG;

  /// Fraction of the fat goal consumed.
  double get fatProgress =>
      fatGoalG == 0 ? 0 : totalMacros.fatG / fatGoalG;

  /// Remaining calories before goal is met (negative = over budget).
  double get remainingCalories => calorieGoal - totalMacros.calories;

  /// Whether the user is within their calorie budget.
  bool get isWithinCalorieGoal => remainingCalories >= 0;

  // ── Macro distribution (percentage of total calories) ────────────────────

  /// Protein contribution as a percentage of total logged calories.
  double get proteinCaloriePercent {
    if (totalMacros.calories == 0) return 0;
    return (totalMacros.proteinG * 4 / totalMacros.calories) * 100;
  }

  /// Carb contribution as a percentage of total logged calories.
  double get carbsCaloriePercent {
    if (totalMacros.calories == 0) return 0;
    return (totalMacros.carbsG * 4 / totalMacros.calories) * 100;
  }

  /// Fat contribution as a percentage of total logged calories.
  double get fatCaloriePercent {
    if (totalMacros.calories == 0) return 0;
    return (totalMacros.fatG * 9 / totalMacros.calories) * 100;
  }

  /// Returns `true` when no food has been logged on [date].
  bool get isEmpty => mealBreakdown.isEmpty;

  @override
  List<Object?> get props => [
        date,
        totalMacros,
        mealBreakdown,
        calorieGoal,
        proteinGoalG,
        carbsGoalG,
        fatGoalG,
      ];

  @override
  String toString() =>
      'DailyMacroSummary(date: $date, cal: ${totalMacros.calories}/'
      '$calorieGoal, p: ${totalMacros.proteinG}g, c: ${totalMacros.carbsG}g, '
      'f: ${totalMacros.fatG}g)';
}

// ── Use Case ──────────────────────────────────────────────────────────────────

/// Computes the full macronutrient summary for a single calendar day.
///
/// ### Responsibilities
/// 1. Fetch all [MealLog]s for [DailyMacroParams.date] via [TrackerRepository].
/// 2. Aggregate individual [LoggedFoodEntry] macros into a [MacroSnapshot].
/// 3. Build a per-meal breakdown sorted chronologically.
/// 4. Calculate progress against user-defined daily goals.
/// 5. Return an immutable [DailyMacroSummary] or propagate a typed [Failure].
///
/// ### Usage
/// ```dart
/// final result = await calculateDailyMacros.execute(
///   DailyMacroParams(
///     date: DateTime.now(),
///     calorieGoal: 2200,
///     proteinGoalG: 160,
///     carbsGoalG: 220,
///     fatGoalG: 70,
///   ),
/// );
///
/// result.fold(
///   (failure) => log.e(failure.message),
///   (summary) => emitState(summary),
/// );
/// ```
final class CalculateDailyMacros {
  const CalculateDailyMacros(this._repository);

  final TrackerRepository _repository;

  /// Executes the use case with the given [params].
  Future<Either<Failure, DailyMacroSummary>> execute(
    DailyMacroParams params,
  ) async {
    // Step 1: Retrieve raw meal logs for the requested day.
    final logsResult = await _repository.getDailyLogs(params.date);

    return logsResult.fold(
      // Propagate any repository failure unchanged.
      Left.new,

      // Step 2: Fold all meal/entry data into the summary.
      (logs) => Right(_buildSummary(logs, params)),
    );
  }

  // ── Private helpers ────────────────────────────────────────────────────────

  DailyMacroSummary _buildSummary(
    List<MealLog> logs,
    DailyMacroParams params,
  ) {
    // Sort meals from earliest to latest for consistent breakdown ordering.
    final sorted = List<MealLog>.from(logs)
      ..sort((a, b) => a.loggedAt.compareTo(b.loggedAt));

    // Build per-meal entries.
    final breakdown = sorted
        .map(
          (log) => MealMacroEntry(
            mealLogId: log.id,
            mealType: log.mealType,
            macros: log.totalMacros,
          ),
        )
        .toList(growable: false);

    // Aggregate across all meals.
    final total = breakdown.fold(
      MacroSnapshot.zero,
      (acc, entry) => acc + entry.macros,
    );

    return DailyMacroSummary(
      date: DateTime(
        params.date.year,
        params.date.month,
        params.date.day,
      ),
      totalMacros: total,
      mealBreakdown: List.unmodifiable(breakdown),
      calorieGoal: params.calorieGoal,
      proteinGoalG: params.proteinGoalG,
      carbsGoalG: params.carbsGoalG,
      fatGoalG: params.fatGoalG,
    );
  }
}
