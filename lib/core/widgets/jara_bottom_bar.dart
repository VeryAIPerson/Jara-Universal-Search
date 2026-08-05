import 'package:flutter/material.dart';

import '../design/haptics.dart';
import '../design/jara_theme.dart';
import '../design/motion.dart';
import '../design/tokens.dart';
import 'jara_fab.dart';

class JaraBottomBarItem {
  const JaraBottomBarItem({
    required this.icon,
    required this.selectedIcon,
    required this.label,
  });

  final IconData icon;
  final IconData selectedIcon;
  final String label;
}

/// Floating soft bar with a center FAB well: two destinations each side,
/// icon-first with a glow dot for the active tab.
class JaraBottomBar extends StatelessWidget {
  const JaraBottomBar({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.onTap,
    required this.onFabTap,
    this.fabState = JaraFabState.add,
    this.fabSemanticLabel = 'Add to JARA',
  });

  final List<JaraBottomBarItem> items;
  final int currentIndex;
  final ValueChanged<int> onTap;
  final VoidCallback onFabTap;
  final JaraFabState fabState;
  final String fabSemanticLabel;

  @override
  Widget build(BuildContext context) {
    final t = context.jara;
    assert(items.length == 4, 'JaraBottomBar expects 4 destinations');

    Widget slot(int index) => Expanded(
          child: _BarSlot(
            item: items[index],
            selected: index == currentIndex,
            onTap: () => onTap(index),
          ),
        );

    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
        child: SizedBox(
          height: JaraSize.bottomBar + 14,
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                height: JaraSize.bottomBar,
                decoration: BoxDecoration(
                  color: t.isDark
                      ? t.surfaceElevated.withValues(alpha: 0.94)
                      : t.surfaceElevated,
                  borderRadius: BorderRadius.circular(JaraRadius.bar),
                  border: Border.all(color: t.border),
                  boxShadow: [
                    BoxShadow(
                      color: t.isDark
                          ? Colors.black.withValues(alpha: 0.5)
                          : JaraPalette.neuShadowLight
                              .withValues(alpha: 0.45),
                      blurRadius: 24,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    slot(0),
                    slot(1),
                    const SizedBox(width: JaraSize.fab + 16),
                    slot(2),
                    slot(3),
                  ],
                ),
              ),
              Positioned(
                bottom: JaraSize.bottomBar - JaraSize.fab / 2 - 6,
                child: JaraFab(
                  onTap: onFabTap,
                  state: fabState,
                  semanticLabel: fabSemanticLabel,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// One destination well. The hover lift is desktop-only — a touch pointer
/// never enters it, so the phone bar renders exactly as before.
class _BarSlot extends StatefulWidget {
  const _BarSlot({
    required this.item,
    required this.selected,
    required this.onTap,
  });

  final JaraBottomBarItem item;
  final bool selected;
  final VoidCallback onTap;

  @override
  State<_BarSlot> createState() => _BarSlotState();
}

class _BarSlotState extends State<_BarSlot> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final t = context.jara;
    final item = widget.item;
    final selected = widget.selected;
    final color =
        selected ? t.accent : (t.isDark ? t.textOnSkyTertiary : t.textTertiary);

    return Semantics(
      button: true,
      selected: selected,
      label: item.label,
      child: MouseRegion(
        onEnter: (_) => setState(() => _hovered = true),
        onExit: (_) => setState(() => _hovered = false),
        child: InkResponse(
          onTap: () {
            JaraHaptics.select();
            widget.onTap();
          },
          radius: 32,
          hoverColor: Colors.transparent,
          child: SizedBox(
            height: JaraSize.bottomBar,
            child: Center(
              child: AnimatedContainer(
                duration: JaraMotion.of(context, JaraMotion.fast),
                width: 56,
                height: 48,
                decoration: BoxDecoration(
                  color: _hovered ? t.tile : Colors.transparent,
                  borderRadius: BorderRadius.circular(JaraRadius.chip),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(selected ? item.selectedIcon : item.icon,
                        color: color, size: 24),
                    const SizedBox(height: 5),
                    AnimatedContainer(
                      duration: JaraMotion.of(context, JaraMotion.base),
                      width: selected ? 14 : 4,
                      height: 4,
                      decoration: BoxDecoration(
                        color: selected ? t.accent : Colors.transparent,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
