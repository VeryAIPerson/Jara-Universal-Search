import 'package:flutter/material.dart';

import '../design/haptics.dart';
import '../design/jara_theme.dart';
import '../design/motion.dart';
import '../design/tokens.dart';

enum JaraFabState { add, indexing, success }

/// Center-docked circular action — Add to JARA. Morphs into a spinning
/// sync arc while indexing and flashes a gold ring on success, echoing
/// the reference's circular refresh button.
class JaraFab extends StatefulWidget {
  const JaraFab({
    super.key,
    required this.onTap,
    this.state = JaraFabState.add,
    this.semanticLabel = 'Add to JARA',
  });

  final VoidCallback onTap;
  final JaraFabState state;
  final String semanticLabel;

  @override
  State<JaraFab> createState() => _JaraFabState();
}

class _JaraFabState extends State<JaraFab> {
  /// Desktop pointers only — touch never sets this.
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final t = context.jara;
    final isSuccess = widget.state == JaraFabState.success;

    return Semantics(
      button: true,
      label: widget.semanticLabel,
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
            width: JaraSize.fab,
            height: JaraSize.fab,
            decoration: BoxDecoration(
              gradient: isSuccess
                  ? LinearGradient(colors: [t.gold, JaraPalette.goldBright])
                  : t.accentGradient,
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white.withValues(alpha: _hovered ? 0.34 : 0.18),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: (isSuccess ? t.gold : t.accent)
                      .withValues(alpha: 0.5),
                  blurRadius: 28,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: JaraFabGlyph(state: widget.state),
          ),
        ),
      ),
    );
  }
}

/// The FAB's morphing glyph: plus → spinning sync → check. Split out so
/// the desktop rail's Add button plays the same beats as the phone FAB.
class JaraFabGlyph extends StatefulWidget {
  const JaraFabGlyph({
    super.key,
    required this.state,
    this.size = 30,
    this.color = Colors.white,
  });

  final JaraFabState state;
  final double size;
  final Color color;

  @override
  State<JaraFabGlyph> createState() => _JaraFabGlyphState();
}

class _JaraFabGlyphState extends State<JaraFabGlyph>
    with SingleTickerProviderStateMixin {
  late final AnimationController _spin = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1400),
  );

  @override
  void didUpdateWidget(JaraFabGlyph old) {
    super.didUpdateWidget(old);
    _sync();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _sync();
  }

  void _sync() {
    if (widget.state == JaraFabState.indexing && !JaraMotion.reduced(context)) {
      _spin.repeat();
    } else {
      _spin.stop();
      _spin.value = 0;
    }
  }

  @override
  void dispose() {
    _spin.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _spin,
      child: Icon(
        switch (widget.state) {
          JaraFabState.add => Icons.add_rounded,
          JaraFabState.indexing => Icons.sync_rounded,
          JaraFabState.success => Icons.check_rounded,
        },
        color: widget.color,
        size: widget.size,
      ),
    );
  }
}
