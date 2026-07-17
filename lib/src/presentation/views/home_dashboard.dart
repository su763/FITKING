/// home_dashboard.dart
///
/// The primary screen of FitKing — the daily calorie and macro dashboard.
///
/// ### Layout Strategy
/// ┌────────────────────────────────────────────────────────────────────┐
/// │  MOBILE (< 900 px)            │  DESKTOP / TABLET (≥ 900 px)      │
/// │  Single scrollable column     │  Fixed left panel + scrollable     │
/// │  ┌─────────────────────────┐  │  right feed                        │
/// │  │  Date selector           │  │  ┌──────────┬───────────────────┐ │
/// │  │  CalorieRing + Legend   │  │  │ Ring +   │ Date + Meals feed │ │
/// │  │  Meal logs feed         │  │  │ Legend   │ + Search overlay  │ │
/// │  │  FAB: Add Food          │  │  │ + Goals  │                   │ │
/// │  └─────────────────────────┘  │  └──────────┴───────────────────┘ │
/// └────────────────────────────────────────────────────────────────────┘
library;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

import '../../domain/models/food_item.dart';
import '../../domain/models/meal_log.dart';
import '../components/calorie_ring.dart';
import '../components/food_search_tile.dart';
import '../state/tracker_bloc.dart';
import '../state/tracker_event.dart';
import '../state/tracker_state.dart';

// ── HomeDashboard ──────────────────────────────────────────────────────────────

class HomeDashboard extends StatefulWidget {
  const HomeDashboard({super.key});

  @override
  State<HomeDashboard> createState() => _HomeDashboardState();
}

class _HomeDashboardState extends State<HomeDashboard> {
  DateTime _selectedDate = DateTime.now();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<TrackerBloc>().add(
          SubscribeToDailyLogs(_selectedDate),
        );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onDayChanged(DateTime date) {
    setState(() => _selectedDate = date);
    context.read<TrackerBloc>().add(LoadDailySummary(date));
    _searchController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isWide = width >= 900;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: isWide
            ? _WideLayout(
                selectedDate: _selectedDate,
                searchController: _searchController,
                onDayChanged: _onDayChanged,
              )
            : _NarrowLayout(
                selectedDate: _selectedDate,
                searchController: _searchController,
                onDayChanged: _onDayChanged,
              ),
      ),
      floatingActionButton: BlocBuilder<TrackerBloc, TrackerState>(
        builder: (context, state) {
          if (state is! TrackerLoaded || isWide) {
            return const SizedBox.shrink();
          }
          return _AddFoodFab(selectedDate: _selectedDate);
        },
      ),
    );
  }
}

// ── Narrow (Mobile) Layout ─────────────────────────────────────────────────────

class _NarrowLayout extends StatelessWidget {
  const _NarrowLayout({
    required this.selectedDate,
    required this.searchController,
    required this.onDayChanged,
  });

  final DateTime selectedDate;
  final TextEditingController searchController;
  final ValueChanged<DateTime> onDayChanged;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: true,
          expandedHeight: 0,
          title: _DateNavigator(
            date: selectedDate,
            onDayChanged: onDayChanged,
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(52),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: _SearchBar(controller: searchController),
            ),
          ),
        ),
        // Macro ring section
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: _MacroRingSection(compact: true),
          ),
        ),
        // Search results OR meal log list
        BlocBuilder<TrackerBloc, TrackerState>(
          builder: (context, state) {
            if (state is TrackerSearchSuccess) {
              return _SearchResultsSliver(results: state.searchResults);
            }
            if (state is TrackerLoaded) {
              return _MealLogSliver(logs: state.mealLogs);
            }
            if (state is TrackerLoading) {
              return const SliverFillRemaining(
                child: Center(child: _LoadingShimmer()),
              );
            }
            if (state is TrackerError) {
              return SliverFillRemaining(
                child: Center(
                  child: _ErrorBanner(message: state.message),
                ),
              );
            }
            return const SliverToBoxAdapter(child: SizedBox.shrink());
          },
        ),
        const SliverPadding(padding: EdgeInsets.only(bottom: 96)),
      ],
    );
  }
}

// ── Wide (Desktop) Layout ─────────────────────────────────────────────────────

class _WideLayout extends StatelessWidget {
  const _WideLayout({
    required this.selectedDate,
    required this.searchController,
    required this.onDayChanged,
  });

  final DateTime selectedDate;
  final TextEditingController searchController;
  final ValueChanged<DateTime> onDayChanged;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Left Panel ─────────────────────────────────────────────────────
        Container(
          width: 320,
          height: double.infinity,
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerLow,
            border: Border(
              right: BorderSide(
                color: colorScheme.outlineVariant.withOpacity(0.4),
              ),
            ),
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                const Gap(8),
                // App title
                Row(
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            colorScheme.primary,
                            const Color(0xFF6C63FF),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(Icons.fitness_center_rounded,
                          color: Colors.white, size: 18),
                    ),
                    const Gap(10),
                    Text(
                      'FitKing',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
                const Gap(28),
                // Ring chart
                _MacroRingSection(compact: false),
                const Gap(20),
                // Goal progress bars
                _GoalProgressList(),
              ],
            ),
          ),
        ),

        // ── Right Feed ─────────────────────────────────────────────────────
        Expanded(
          child: Column(
            children: [
              // Top bar
              Container(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 12),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: colorScheme.outlineVariant.withOpacity(0.3),
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    _DateNavigator(
                      date: selectedDate,
                      onDayChanged: onDayChanged,
                    ),
                    const Spacer(),
                    const Gap(12),
                    SizedBox(
                      width: 300,
                      child: _SearchBar(controller: searchController),
                    ),
                    const Gap(12),
                    _AddFoodFab(selectedDate: selectedDate, compact: true),
                  ],
                ),
              ),
              // Feed
              Expanded(
                child: BlocBuilder<TrackerBloc, TrackerState>(
                  builder: (context, state) {
                    if (state is TrackerSearchSuccess) {
                      return _SearchResultsList(results: state.searchResults);
                    }
                    if (state is TrackerLoaded) {
                      return _MealLogList(logs: state.mealLogs);
                    }
                    if (state is TrackerLoading) {
                      return const Center(child: _LoadingShimmer());
                    }
                    if (state is TrackerError) {
                      return Center(
                        child: _ErrorBanner(message: state.message),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ── Date Navigator ─────────────────────────────────────────────────────────────

class _DateNavigator extends StatelessWidget {
  const _DateNavigator({
    required this.date,
    required this.onDayChanged,
  });

  final DateTime date;
  final ValueChanged<DateTime> onDayChanged;

  String get _label {
    final now = DateTime.now();
    if (_isSameDay(date, now)) return 'Today';
    if (_isSameDay(date, now.subtract(const Duration(days: 1)))) {
      return 'Yesterday';
    }
    return DateFormat('EEE, MMM d').format(date);
  }

  bool _isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _NavIconButton(
          icon: Icons.chevron_left_rounded,
          onTap: () => onDayChanged(date.subtract(const Duration(days: 1))),
        ),
        const Gap(4),
        GestureDetector(
          onTap: () async {
            final picked = await showDatePicker(
              context: context,
              initialDate: date,
              firstDate: DateTime(2020),
              lastDate: DateTime.now(),
            );
            if (picked != null) onDayChanged(picked);
          },
          child: Text(
            _label,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
        ),
        const Gap(4),
        _NavIconButton(
          icon: Icons.chevron_right_rounded,
          onTap: () {
            final next = date.add(const Duration(days: 1));
            if (!next.isAfter(DateTime.now())) onDayChanged(next);
          },
        ),
      ],
    );
  }
}

class _NavIconButton extends StatelessWidget {
  const _NavIconButton({required this.icon, required this.onTap});
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Icon(icon,
            color: Theme.of(context).colorScheme.onSurfaceVariant),
      ),
    );
  }
}

// ── Search Bar ─────────────────────────────────────────────────────────────────

class _SearchBar extends StatefulWidget {
  const _SearchBar({required this.controller});
  final TextEditingController controller;

  @override
  State<_SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<_SearchBar> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onTextChanged);
    super.dispose();
  }

  void _onTextChanged() {
    final query = widget.controller.text.trim();
    if (query.isEmpty) {
      context.read<TrackerBloc>().add(const ClearFoodSearch());
    } else {
      context.read<TrackerBloc>().add(SearchFoodQuery(query));
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return TextField(
      controller: widget.controller,
      decoration: InputDecoration(
        hintText: 'Search food…',
        hintStyle:
            TextStyle(color: colorScheme.onSurfaceVariant.withOpacity(0.6)),
        prefixIcon: const Icon(Icons.search_rounded, size: 20),
        suffixIcon: widget.controller.text.isNotEmpty
            ? IconButton(
                icon: const Icon(Icons.close_rounded, size: 18),
                onPressed: () {
                  widget.controller.clear();
                  context
                      .read<TrackerBloc>()
                      .add(const ClearFoodSearch());
                },
              )
            : null,
        filled: true,
        fillColor: colorScheme.surfaceContainerHighest.withOpacity(0.5),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: colorScheme.primary, width: 1.5),
        ),
      ),
    );
  }
}

// ── Macro Ring Section ─────────────────────────────────────────────────────────

class _MacroRingSection extends StatelessWidget {
  const _MacroRingSection({required this.compact});
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TrackerBloc, TrackerState>(
      builder: (context, state) {
        final summary = switch (state) {
          TrackerLoaded() => state.summary,
          TrackerLoading(:final previousLoaded?) => previousLoaded.summary,
          _ => null,
        };

        if (summary == null) {
          return SizedBox(
            height: compact ? 220 : 260,
            child:
                const Center(child: CircularProgressIndicator.adaptive()),
          );
        }

        final data = CalorieRingData(
          caloriesConsumed: summary.totalMacros.calories,
          calorieGoal: summary.calorieGoal,
          proteinConsumed: summary.totalMacros.proteinG,
          proteinGoal: summary.proteinGoalG,
          carbsConsumed: summary.totalMacros.carbsG,
          carbsGoal: summary.carbsGoalG,
          fatConsumed: summary.totalMacros.fatG,
          fatGoal: summary.fatGoalG,
        );

        return Column(
          children: [
            CalorieRingWidget(
              data: data,
              size: compact ? 200 : 240,
            ),
            const Gap(16),
            CalorieRingLegend(data: data),
          ],
        );
      },
    );
  }
}

// ── Goal Progress List ────────────────────────────────────────────────────────

class _GoalProgressList extends StatelessWidget {
  const _GoalProgressList();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TrackerBloc, TrackerState>(
      builder: (context, state) {
        if (state is! TrackerLoaded) return const SizedBox.shrink();
        final s = state.summary;
        final items = [
          ('Calories', s.calorieProgress, const Color(0xFF6C63FF)),
          ('Protein', s.proteinProgress, const Color(0xFF00C896)),
          ('Carbs', s.carbsProgress, const Color(0xFFFFB547)),
          ('Fat', s.fatProgress, const Color(0xFFFF6B6B)),
        ];

        return Column(
          children: items
              .map(
                (item) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: _ProgressRow(
                    label: item.$1,
                    progress: item.$2,
                    color: item.$3,
                  ),
                ),
              )
              .toList(),
        );
      },
    );
  }
}

class _ProgressRow extends StatelessWidget {
  const _ProgressRow({
    required this.label,
    required this.progress,
    required this.color,
  });
  final String label;
  final double progress;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      children: [
        SizedBox(
          width: 60,
          child: Text(
            label,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
          ),
        ),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress.clamp(0.0, 1.0),
              minHeight: 6,
              backgroundColor:
                  color.withOpacity(0.15),
              valueColor: AlwaysStoppedAnimation<Color>(color),
            ),
          ),
        ),
        const Gap(8),
        SizedBox(
          width: 36,
          child: Text(
            '${(progress * 100).toInt()}%',
            textAlign: TextAlign.right,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
          ),
        ),
      ],
    );
  }
}

// ── Meal Log Widgets ───────────────────────────────────────────────────────────

class _MealLogSliver extends StatelessWidget {
  const _MealLogSliver({required this.logs});
  final List<MealLog> logs;

  @override
  Widget build(BuildContext context) {
    if (logs.isEmpty) {
      return SliverFillRemaining(
        child: Center(child: _EmptyDayPlaceholder()),
      );
    }
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, i) => _MealLogCard(log: logs[i]),
        childCount: logs.length,
      ),
    );
  }
}

class _MealLogList extends StatelessWidget {
  const _MealLogList({required this.logs});
  final List<MealLog> logs;

  @override
  Widget build(BuildContext context) {
    if (logs.isEmpty) {
      return Center(child: _EmptyDayPlaceholder());
    }
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: logs.length,
      itemBuilder: (context, i) => _MealLogCard(log: logs[i]),
    );
  }
}

class _MealLogCard extends StatelessWidget {
  const _MealLogCard({required this.log});
  final MealLog log;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: colorScheme.outlineVariant.withOpacity(0.3),
        ),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          leading: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFF6C63FF).withOpacity(0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.restaurant_menu_rounded,
                color: Color(0xFF6C63FF), size: 20),
          ),
          title: Text(
            log.mealType.displayName,
            style:
                textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
          ),
          subtitle: Text(
            '${log.totalCalories.toInt()} kcal  •  '
            '${log.itemCount} item${log.itemCount == 1 ? "" : "s"}',
            style: textTheme.labelSmall
                ?.copyWith(color: colorScheme.onSurfaceVariant),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.delete_outline_rounded, size: 18),
                color: colorScheme.error,
                onPressed: () => context
                    .read<TrackerBloc>()
                    .add(DeleteMealLog(log.id)),
              ),
              const Icon(Icons.expand_more_rounded),
            ],
          ),
          children: log.entries
              .map(
                (e) => ListTile(
                  dense: true,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 20),
                  title: Text(e.foodItem.name,
                      style: textTheme.bodySmall),
                  trailing: Text(
                    '${e.macros.calories.toInt()} kcal  '
                    '· ${e.consumedGrams.toInt()}g',
                    style: textTheme.labelSmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

// ── Search Result Widgets ──────────────────────────────────────────────────────

class _SearchResultsSliver extends StatelessWidget {
  const _SearchResultsSliver({required this.results});
  final List<dynamic> results;

  @override
  Widget build(BuildContext context) {
    if (results.isEmpty) {
      return const SliverFillRemaining(
        child: Center(
          child: Text('No results found. Try a different search term.'),
        ),
      );
    }
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, i) => FoodSearchTile(
          item: results[i],
          onAdd: (food) =>
              context.read<TrackerBloc>().add(AddFoodToMeal(food: food)),
        ),
        childCount: results.length,
      ),
    );
  }
}

class _SearchResultsList extends StatelessWidget {
  const _SearchResultsList({required this.results});
  final List<dynamic> results;

  @override
  Widget build(BuildContext context) {
    if (results.isEmpty) {
      return const Center(
        child: Text('No results found. Try a different search term.'),
      );
    }
    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, i) => FoodSearchTile(
        item: results[i],
        onAdd: (food) =>
            context.read<TrackerBloc>().add(AddFoodToMeal(food: food)),
      ),
    );
  }
}

// ── FAB ────────────────────────────────────────────────────────────────────────

class _AddFoodFab extends StatelessWidget {
  const _AddFoodFab({required this.selectedDate, this.compact = false});
  final DateTime selectedDate;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    if (compact) {
      return FilledButton.icon(
        onPressed: () => _showAddSheet(context),
        icon: const Icon(Icons.add_rounded),
        label: const Text('Log Food'),
        style: FilledButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
    }
    return FloatingActionButton.extended(
      onPressed: () => _showAddSheet(context),
      icon: const Icon(Icons.add_rounded),
      label: const Text('Log Food'),
    );
  }

  void _showAddSheet(BuildContext context) {
    final bloc = context.read<TrackerBloc>();
    final state = bloc.state;
    if (state is! TrackerLoaded) return;

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => BlocProvider.value(
        value: bloc,
        child: _SaveMealSheet(
          draftEntries: state.draftEntries,
          draftMacros: state.draftMacros,
        ),
      ),
    );
  }
}

// ── Save Meal Bottom Sheet ─────────────────────────────────────────────────────

class _SaveMealSheet extends StatefulWidget {
  const _SaveMealSheet({
    required this.draftEntries,
    required this.draftMacros,
  });
  final List<LoggedFoodEntry> draftEntries;
  final MacroSnapshot draftMacros;

  @override
  State<_SaveMealSheet> createState() => _SaveMealSheetState();
}

class _SaveMealSheetState extends State<_SaveMealSheet> {
  MealType _selectedType = MealType.breakfast;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return DraggableScrollableSheet(
      initialChildSize: 0.55,
      minChildSize: 0.3,
      maxChildSize: 0.9,
      builder: (_, scrollController) => Container(
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius:
              const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          children: [
            const Gap(10),
            Container(
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: colorScheme.outlineVariant,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
              child: Row(
                children: [
                  Text('Save Meal',
                      style: textTheme.titleMedium
                          ?.copyWith(fontWeight: FontWeight.w700)),
                  const Spacer(),
                  Text(
                    '${widget.draftMacros.calories.toInt()} kcal total',
                    style: textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant),
                  ),
                ],
              ),
            ),
            // Meal type selector
            SizedBox(
              height: 40,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: MealType.values
                    .map(
                      (t) => Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: ChoiceChip(
                          label: Text(t.displayName),
                          selected: _selectedType == t,
                          onSelected: (_) =>
                              setState(() => _selectedType = t),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
            const Gap(8),
            if (widget.draftEntries.isEmpty)
              Expanded(
                child: Center(
                  child: Text(
                    'Search for food and tap + to add it here.',
                    style: textTheme.bodySmall
                        ?.copyWith(color: colorScheme.onSurfaceVariant),
                  ),
                ),
              )
            else
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: widget.draftEntries.length,
                  itemBuilder: (context, i) {
                    final e = widget.draftEntries[i];
                    return ListTile(
                      title: Text(e.foodItem.name,
                          style: textTheme.bodyMedium),
                      subtitle: Text('${e.consumedGrams.toInt()}g'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '${e.macros.calories.toInt()} kcal',
                            style:
                                textTheme.labelSmall?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                          const Gap(8),
                          IconButton(
                            icon: const Icon(Icons.remove_circle_outline,
                                size: 20),
                            color: colorScheme.error,
                            onPressed: () => context
                                .read<TrackerBloc>()
                                .add(RemoveFoodFromMeal(e.id)),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        context
                            .read<TrackerBloc>()
                            .add(const DiscardMealDraft());
                        Navigator.pop(context);
                      },
                      child: const Text('Discard'),
                    ),
                  ),
                  const Gap(12),
                  Expanded(
                    flex: 2,
                    child: FilledButton(
                      onPressed: widget.draftEntries.isEmpty
                          ? null
                          : () {
                              context.read<TrackerBloc>().add(
                                    SaveCurrentMealLog(
                                        mealType: _selectedType),
                                  );
                              Navigator.pop(context);
                            },
                      child: const Text('Save Meal'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Empty State ────────────────────────────────────────────────────────────────

class _EmptyDayPlaceholder extends StatelessWidget {
  const _EmptyDayPlaceholder();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.restaurant_outlined,
            size: 56, color: colorScheme.onSurfaceVariant.withOpacity(0.4)),
        const Gap(12),
        Text(
          'Nothing logged yet',
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
        ),
        const Gap(4),
        Text(
          'Search for a food item and tap + to start tracking.',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurfaceVariant.withOpacity(0.6),
              ),
        ),
      ],
    );
  }
}

// ── Loading Shimmer ────────────────────────────────────────────────────────────

class _LoadingShimmer extends StatelessWidget {
  const _LoadingShimmer();

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircularProgressIndicator.adaptive(),
        Gap(12),
        Text('Loading your data…'),
      ],
    );
  }
}

// ── Error Banner ───────────────────────────────────────────────────────────────

class _ErrorBanner extends StatelessWidget {
  const _ErrorBanner({required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline_rounded,
              size: 48, color: colorScheme.error),
          const Gap(12),
          Text(
            message,
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: colorScheme.onSurfaceVariant),
          ),
          const Gap(16),
          FilledButton(
            onPressed: () => context
                .read<TrackerBloc>()
                .add(LoadDailySummary(DateTime.now())),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
