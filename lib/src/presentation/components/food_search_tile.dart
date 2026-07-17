/// food_search_tile.dart
///
/// Adaptive list tile for a single food search result.
///
/// On mobile (touch), the quick-add button is a large floating FAB-style icon.
/// On desktop (pointer), it reveals an inline action row on hover, giving
/// mouse users precise control without crowding small touch targets.
library;

import 'package:flutter/material.dart';

import '../../domain/models/food_item.dart';

// ── FoodSearchTile ────────────────────────────────────────────────────────────

/// Displays one [FoodItem] search result with:
///  - Name, brand, and serving size label
///  - Macro chips (kcal / P / C / F)
///  - Quick-add button (touch: full-row tap; desktop: animated hover reveal)
///
/// [onAdd] is called immediately with the item's default serving size.
/// [onTap] (optional) opens a gram-override bottom sheet in the parent.
class FoodSearchTile extends StatefulWidget {
  const FoodSearchTile({
    super.key,
    required this.item,
    required this.onAdd,
    this.onTap,
    this.isAdded = false,
  });

  final FoodItem item;

  /// Called when the user confirms a quick-add at the default serving.
  final ValueChanged<FoodItem> onAdd;

  /// Called when the user taps the tile body (gram-override sheet).
  final ValueChanged<FoodItem>? onTap;

  /// Shows a checkmark instead of the add button when already added.
  final bool isAdded;

  @override
  State<FoodSearchTile> createState() => _FoodSearchTileState();
}

class _FoodSearchTileState extends State<FoodSearchTile>
    with SingleTickerProviderStateMixin {
  bool _hovered = false;
  late AnimationController _hoverController;
  late Animation<double> _hoverFade;

  @override
  void initState() {
    super.initState();
    _hoverController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 180),
    );
    _hoverFade = CurvedAnimation(
      parent: _hoverController,
      curve: Curves.easeOut,
    );
  }

  @override
  void dispose() {
    _hoverController.dispose();
    super.dispose();
  }

  void _onEnter(PointerEvent _) {
    setState(() => _hovered = true);
    _hoverController.forward();
  }

  void _onExit(PointerEvent _) {
    setState(() => _hovered = false);
    _hoverController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final isDesktop = MediaQuery.of(context).size.width >= 900;

    return MouseRegion(
      onEnter: _onEnter,
      onExit: _onExit,
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(
          color: _hovered
              ? colorScheme.primaryContainer.withOpacity(0.18)
              : colorScheme.surfaceContainerLow,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _hovered
                ? colorScheme.primary.withOpacity(0.3)
                : colorScheme.outlineVariant.withOpacity(0.4),
          ),
          boxShadow: _hovered
              ? [
                  BoxShadow(
                    color: colorScheme.primary.withOpacity(0.06),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [],
        ),
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(16),
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () => widget.onTap?.call(widget.item),
            splashColor: colorScheme.primary.withOpacity(0.08),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // ── Food Icon ────────────────────────────────
                  _FoodAvatar(
                    item: widget.item,
                    colorScheme: colorScheme,
                  ),
                  const SizedBox(width: 12),

                  // ── Name + Macros ────────────────────────────
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.item.name,
                          style: textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: colorScheme.onSurface,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        if (widget.item.brand != null) ...[
                          const SizedBox(height: 1),
                          Text(
                            widget.item.brand!,
                            style: textTheme.labelSmall?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                        const SizedBox(height: 6),
                        _MacroChipRow(item: widget.item),
                      ],
                    ),
                  ),

                  const SizedBox(width: 8),

                  // ── Action area ─────────────────────────────
                  if (isDesktop)
                    // Desktop: action row fades in on hover.
                    FadeTransition(
                      opacity: _hoverFade,
                      child: _DesktopActionRow(
                        item: widget.item,
                        isAdded: widget.isAdded,
                        onAdd: widget.onAdd,
                        colorScheme: colorScheme,
                      ),
                    )
                  else
                    // Mobile: always-visible compact add button.
                    _MobileAddButton(
                      item: widget.item,
                      isAdded: widget.isAdded,
                      onAdd: widget.onAdd,
                      colorScheme: colorScheme,
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ── Food Avatar ────────────────────────────────────────────────────────────────

class _FoodAvatar extends StatelessWidget {
  const _FoodAvatar({required this.item, required this.colorScheme});

  final FoodItem item;
  final ColorScheme colorScheme;

  static const _categoryIcons = <String, IconData>{
    'poultry': Icons.egg_alt_outlined,
    'dairy': Icons.local_drink_outlined,
    'fruit': Icons.apple_outlined,
    'vegetable': Icons.eco_outlined,
    'grain': Icons.grain_outlined,
    'snack': Icons.cookie_outlined,
    'beverage': Icons.local_cafe_outlined,
    'seafood': Icons.set_meal_outlined,
  };

  IconData _resolveIcon() {
    final cat = item.category?.toLowerCase() ?? '';
    for (final entry in _categoryIcons.entries) {
      if (cat.contains(entry.key)) return entry.value;
    }
    return Icons.restaurant_outlined;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: colorScheme.primaryContainer.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(
        _resolveIcon(),
        color: colorScheme.primary,
        size: 22,
      ),
    );
  }
}

// ── Macro Chip Row ─────────────────────────────────────────────────────────────

class _MacroChipRow extends StatelessWidget {
  const _MacroChipRow({required this.item});

  final FoodItem item;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 4,
      runSpacing: 4,
      children: [
        _MacroChip(
          label: '${item.calories.toInt()} kcal',
          color: const Color(0xFF6C63FF),
        ),
        _MacroChip(
          label: 'P ${item.proteinG.toStringAsFixed(1)}g',
          color: const Color(0xFF00C896),
        ),
        _MacroChip(
          label: 'C ${item.carbsG.toStringAsFixed(1)}g',
          color: const Color(0xFFFFB547),
        ),
        _MacroChip(
          label: 'F ${item.fatG.toStringAsFixed(1)}g',
          color: const Color(0xFFFF6B6B),
        ),
        _MacroChip(
          label: '${item.servingSizeG.toInt()}g serving',
          color: Colors.grey,
        ),
      ],
    );
  }
}

class _MacroChip extends StatelessWidget {
  const _MacroChip({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }
}

// ── Desktop Action Row ────────────────────────────────────────────────────────

/// Revealed on hover — lets mouse users click a specific action.
class _DesktopActionRow extends StatelessWidget {
  const _DesktopActionRow({
    required this.item,
    required this.isAdded,
    required this.onAdd,
    required this.colorScheme,
  });

  final FoodItem item;
  final bool isAdded;
  final ValueChanged<FoodItem> onAdd;
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    if (isAdded) {
      return Icon(Icons.check_circle_rounded,
          color: const Color(0xFF00C896), size: 28);
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Tooltip(
          message: 'Add (${item.servingSizeG.toInt()}g)',
          child: FilledButton.icon(
            onPressed: () => onAdd(item),
            icon: const Icon(Icons.add_rounded, size: 16),
            label: const Text('Add'),
            style: FilledButton.styleFrom(
              backgroundColor: colorScheme.primary,
              foregroundColor: colorScheme.onPrimary,
              visualDensity: VisualDensity.compact,
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ── Mobile Add Button ─────────────────────────────────────────────────────────

/// Always-visible compact add button for touch-first layouts.
class _MobileAddButton extends StatelessWidget {
  const _MobileAddButton({
    required this.item,
    required this.isAdded,
    required this.onAdd,
    required this.colorScheme,
  });

  final FoodItem item;
  final bool isAdded;
  final ValueChanged<FoodItem> onAdd;
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 250),
      transitionBuilder: (child, animation) =>
          ScaleTransition(scale: animation, child: child),
      child: isAdded
          ? Icon(
              Icons.check_circle_rounded,
              key: const ValueKey('check'),
              color: const Color(0xFF00C896),
              size: 32,
            )
          : GestureDetector(
              key: const ValueKey('add'),
              onTap: () => onAdd(item),
              child: Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      colorScheme.primary,
                      colorScheme.primary.withOpacity(0.8),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: colorScheme.primary.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.add_rounded,
                  color: colorScheme.onPrimary,
                  size: 22,
                ),
              ),
            ),
    );
  }
}
