import 'package:flutter/material.dart';

import '../design/haptics.dart';
import '../design/motion.dart';

/// Micro-interaction wrapper: scales to 0.97 on press with a light haptic.
/// Wrap tiles, cards and buttons instead of raw GestureDetector.
class Pressable extends StatefulWidget {
  const Pressable({
    super.key,
    required this.child,
    this.onTap,
    this.onLongPress,
    this.haptic = true,
    this.semanticLabel,
    this.semanticButton = true,
  });

  final Widget child;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final bool haptic;
  final String? semanticLabel;
  final bool semanticButton;

  @override
  State<Pressable> createState() => _PressableState();
}

class _PressableState extends State<Pressable> {
  bool _down = false;

  @override
  Widget build(BuildContext context) {
    final reduced = JaraMotion.reduced(context);
    return Semantics(
      button: widget.semanticButton,
      label: widget.semanticLabel,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTapDown: widget.onTap == null
            ? null
            : (_) => setState(() => _down = true),
        onTapCancel: () => setState(() => _down = false),
        onTapUp: (_) => setState(() => _down = false),
        onTap: widget.onTap == null
            ? null
            : () {
                if (widget.haptic) JaraHaptics.tap();
                widget.onTap!();
              },
        onLongPress: widget.onLongPress,
        child: AnimatedScale(
          scale: _down && !reduced ? 0.97 : 1,
          duration: JaraMotion.fast,
          curve: JaraMotion.standard,
          child: widget.child,
        ),
      ),
    );
  }
}
