import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../design/breakpoints.dart';
import '../design/haptics.dart';
import '../design/jara_theme.dart';
import '../design/motion.dart';
import '../design/tokens.dart';
import '../design/typography.dart';
import 'jara_bottom_bar.dart';
import 'jara_fab.dart';

/// Desktop keyboard vocabulary. The shell answers these while focus sits
/// inside it; a root-level fallback answers when a pushed page or a sheet
/// holds focus (see `jaraRootShortcutActions` in app_router.dart).
class JaraFocusSearchIntent extends Intent {
  const JaraFocusSearchIntent();
}

class JaraAddIntent extends Intent {
  const JaraAddIntent();
}

class JaraDismissIntent extends Intent {
  const JaraDismissIntent();
}

class JaraDestinationIntent extends Intent {
  const JaraDestinationIntent(this.index);

  final int index;
}

/// Cmd on Apple platforms, Ctrl everywhere else.
Map<ShortcutActivator, Intent> jaraShortcuts() {
  final apple = defaultTargetPlatform == TargetPlatform.macOS ||
      defaultTargetPlatform == TargetPlatform.iOS;
  SingleActivator chord(LogicalKeyboardKey key) =>
      SingleActivator(key, meta: apple, control: !apple);
  return <ShortcutActivator, Intent>{
    chord(LogicalKeyboardKey.keyK): const JaraFocusSearchIntent(),
    chord(LogicalKeyboardKey.keyN): const JaraAddIntent(),
    chord(LogicalKeyboardKey.digit1): const JaraDestinationIntent(0),
    chord(LogicalKeyboardKey.digit2): const JaraDestinationIntent(1),
    chord(LogicalKeyboardKey.digit3): const JaraDestinationIntent(2),
    chord(LogicalKeyboardKey.digit4): const JaraDestinationIntent(3),
    const SingleActivator(LogicalKeyboardKey.escape): const JaraDismissIntent(),
  };
}

/// Focuses the first text field below [context]. Cmd/Ctrl+K routes to the
/// search branch and then focuses the field that screen owns, so the shell
/// never has to reach for a FocusNode it does not own.
void focusFirstField(BuildContext context) {
  EditableText? field;
  void visit(Element element) {
    if (field != null) return;
    final widget = element.widget;
    if (widget is EditableText) {
      field = widget;
      return;
    }
    element.visitChildren(visit);
  }

  context.visitChildElements(visit);
  field?.focusNode.requestFocus();
}

/// Navigation chrome for every window class, driven by
/// [JaraBreakpoints.of]:
///
/// * `watch` — nothing at all, the child renders bare.
/// * `compact` — the signed-off floating bar with the centre FAB.
/// * `medium`/`expanded` — an icon rail with the FAB at its top.
/// * `large` — a labelled sidebar with a full-width Add button.
///
/// [JaraBottomBarItem] is the single destination model: the bar and the
/// rail read the same list. On two-pane windows [detail] is painted beside
/// [body]; on narrower ones it is ignored (the detail is a pushed page).
class AdaptiveNavShell extends StatelessWidget {
  const AdaptiveNavShell({
    super.key,
    required this.destinations,
    required this.currentIndex,
    required this.onDestinationSelected,
    required this.onAdd,
    required this.body,
    this.detail,
    this.fabState = JaraFabState.add,
    this.addLabel = 'Add to JARA',
  });

  final List<JaraBottomBarItem> destinations;
  final int currentIndex;
  final ValueChanged<int> onDestinationSelected;
  final VoidCallback onAdd;

  /// The current branch: search results, memory list, collections.
  final Widget body;

  /// Trailing-pane content on `expanded`/`large`. Null shows the calm
  /// placeholder.
  final Widget? detail;

  final JaraFabState fabState;
  final String addLabel;

  @override
  Widget build(BuildContext context) {
    final t = context.jara;
    final window = JaraBreakpoints.of(context);

    // Watch: a single screen, no chrome — a separate shell owns the
    // watch-sized screens, this one must not draw over them.
    if (window.isWatch) {
      return Scaffold(backgroundColor: t.surface, body: body);
    }

    if (!window.usesRail) {
      return Scaffold(
        backgroundColor: t.surface,
        extendBody: true,
        body: body,
        bottomNavigationBar: JaraBottomBar(
          currentIndex: currentIndex,
          onTap: onDestinationSelected,
          onFabTap: onAdd,
          fabState: fabState,
          fabSemanticLabel: addLabel,
          items: destinations,
        ),
      );
    }

    return Scaffold(
      backgroundColor: t.surface,
      // Surplus width past contentMaxWidth becomes margin, never line
      // length: a 2560 dp monitor must not read like a stretched phone.
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: JaraBreakpoints.contentMaxWidth,
          ),
          child: Row(
            children: [
              _NavRail(
                destinations: destinations,
                currentIndex: currentIndex,
                onDestinationSelected: onDestinationSelected,
                onAdd: onAdd,
                fabState: fabState,
                addLabel: addLabel,
                extended: window.usesExtendedRail,
              ),
              Expanded(
                child: window.usesTwoPane ? _panes(context) : body,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _panes(BuildContext context) {
    return Row(
      children: [
        Expanded(flex: 5, child: body),
        Container(width: 1, color: context.jara.border),
        Expanded(
          flex: 4,
          child: Align(
            alignment: Alignment.topCenter,
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: JaraBreakpoints.proseMaxWidth,
              ),
              child: detail ?? const _EmptyDetailPane(),
            ),
          ),
        ),
      ],
    );
  }
}

/// Leading rail — icon-only on tablets, labelled on desktop. Sits on the
/// leading side in both directions (it moves right under RTL).
class _NavRail extends StatelessWidget {
  const _NavRail({
    required this.destinations,
    required this.currentIndex,
    required this.onDestinationSelected,
    required this.onAdd,
    required this.fabState,
    required this.addLabel,
    required this.extended,
  });

  final List<JaraBottomBarItem> destinations;
  final int currentIndex;
  final ValueChanged<int> onDestinationSelected;
  final VoidCallback onAdd;
  final JaraFabState fabState;
  final String addLabel;
  final bool extended;

  @override
  Widget build(BuildContext context) {
    final t = context.jara;

    final add = extended
        ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: JaraSpacing.lg),
            child: _RailAddButton(
              state: fabState,
              label: addLabel,
              onTap: onAdd,
            ),
          )
        : Center(
            child: JaraFab(
              onTap: onAdd,
              state: fabState,
              semanticLabel: addLabel,
            ),
          );

    return Container(
      width: extended
          ? JaraBreakpoints.railExtendedWidth
          : JaraBreakpoints.railWidth,
      decoration: BoxDecoration(
        color: t.surfaceElevated,
        border: BorderDirectional(end: BorderSide(color: t.border)),
        boxShadow: t.neuShadows,
      ),
      child: SafeArea(
        // Short landscape windows scroll rather than overflow.
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: JaraSpacing.xl),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              add,
              const SizedBox(height: JaraSpacing.xxl),
              for (var i = 0; i < destinations.length; i++)
                _RailDestination(
                  item: destinations[i],
                  selected: i == currentIndex,
                  extended: extended,
                  onTap: () => onDestinationSelected(i),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RailDestination extends StatefulWidget {
  const _RailDestination({
    required this.item,
    required this.selected,
    required this.extended,
    required this.onTap,
  });

  final JaraBottomBarItem item;
  final bool selected;
  final bool extended;
  final VoidCallback onTap;

  @override
  State<_RailDestination> createState() => _RailDestinationState();
}

class _RailDestinationState extends State<_RailDestination> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final t = context.jara;
    final item = widget.item;
    final selected = widget.selected;
    final color =
        selected ? t.accent : (t.isDark ? t.textOnSkyTertiary : t.textTertiary);
    final icon = Icon(selected ? item.selectedIcon : item.icon,
        color: color, size: 24);

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
          // The rail paints its own hover lift below.
          hoverColor: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
                JaraSpacing.lg, JaraSpacing.xs, JaraSpacing.lg, JaraSpacing.xs),
            child: AnimatedContainer(
              duration: JaraMotion.of(context, JaraMotion.fast),
              height: 52,
              decoration: BoxDecoration(
                color: selected
                    ? t.accent.withValues(alpha: 0.12)
                    : (_hovered ? t.tile : Colors.transparent),
                borderRadius: BorderRadius.circular(JaraRadius.card),
                border: Border.all(
                  color: selected
                      ? t.accent.withValues(alpha: 0.32)
                      : (_hovered ? t.border : Colors.transparent),
                ),
              ),
              child: widget.extended
                  ? Row(
                      children: [
                        const SizedBox(width: 14),
                        icon,
                        const SizedBox(width: 14),
                        Expanded(
                          child: Text(
                            item.label,
                            style: JaraType.callout.copyWith(color: color),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        _SelectedDot(selected: selected, extended: true),
                        const SizedBox(width: JaraSpacing.md),
                      ],
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        icon,
                        const SizedBox(height: 5),
                        _SelectedDot(selected: selected, extended: false),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}

/// The bottom bar's active marker, reused so a destination reads the same
/// on every form factor.
class _SelectedDot extends StatelessWidget {
  const _SelectedDot({required this.selected, required this.extended});

  final bool selected;
  final bool extended;

  @override
  Widget build(BuildContext context) {
    final t = context.jara;
    return AnimatedContainer(
      duration: JaraMotion.of(context, JaraMotion.base),
      width: extended ? 6 : (selected ? 14 : 4),
      height: extended ? 6 : 4,
      decoration: BoxDecoration(
        color: selected ? t.accent : Colors.transparent,
        borderRadius: BorderRadius.circular(extended ? 3 : 2),
        boxShadow: selected ? t.accentGlow : null,
      ),
    );
  }
}

/// Desktop Add action: the FAB's state machine as a full-width button.
class _RailAddButton extends StatefulWidget {
  const _RailAddButton({
    required this.state,
    required this.label,
    required this.onTap,
  });

  final JaraFabState state;
  final String label;
  final VoidCallback onTap;

  @override
  State<_RailAddButton> createState() => _RailAddButtonState();
}

class _RailAddButtonState extends State<_RailAddButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final t = context.jara;
    final success = widget.state == JaraFabState.success;
    final glow = success ? t.gold : t.accent;

    return Semantics(
      button: true,
      label: widget.label,
      child: MouseRegion(
        onEnter: (_) => setState(() => _hovered = true),
        onExit: (_) => setState(() => _hovered = false),
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () {
            JaraHaptics.confirm();
            widget.onTap();
          },
          child: AnimatedContainer(
            duration: JaraMotion.of(context, JaraMotion.gentle),
            curve: JaraMotion.spring,
            height: 52,
            decoration: BoxDecoration(
              gradient: success
                  ? LinearGradient(colors: [t.gold, JaraPalette.goldBright])
                  : t.accentGradient,
              borderRadius: BorderRadius.circular(JaraRadius.card),
              border: Border.all(
                color: Colors.white.withValues(alpha: _hovered ? 0.34 : 0.18),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: glow.withValues(alpha: _hovered ? 0.55 : 0.4),
                  blurRadius: _hovered ? 26 : 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                JaraFabGlyph(state: widget.state, size: 20),
                const SizedBox(width: JaraSpacing.sm),
                Flexible(
                  child: Text(
                    widget.label,
                    style: JaraType.button.copyWith(color: Colors.white),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Trailing pane before anything is picked — quiet on purpose.
class _EmptyDetailPane extends StatelessWidget {
  const _EmptyDetailPane();

  @override
  Widget build(BuildContext context) {
    final t = context.jara;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(JaraSpacing.xxxl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.auto_awesome_motion_outlined,
              size: 36,
              color: t.textTertiary.withValues(alpha: 0.55),
            ),
            const SizedBox(height: JaraSpacing.md),
            Text(
              // l10n-todo: no key for the two-pane placeholder yet.
              'Select a memory to see it here',
              textAlign: TextAlign.center,
              style: JaraType.callout.copyWith(color: t.textTertiary),
            ),
          ],
        ),
      ),
    );
  }
}
