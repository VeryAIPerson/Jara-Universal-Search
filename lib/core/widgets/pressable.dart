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
    this.minHitSize,
  });

  final Widget child;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final bool haptic;
  final String? semanticLabel;
  final bool semanticButton;

  /// Minimum tap-target side length, see [minHitBox]. Null (the default)
  /// keeps the gesture box exactly [child]'s own size — unchanged for
  /// every existing caller that doesn't opt in.
  final double? minHitSize;

  @override
  State<Pressable> createState() => _PressableState();
}

class _PressableState extends State<Pressable> {
  bool _down = false;

  @override
  Widget build(BuildContext context) {
    final reduced = JaraMotion.reduced(context);
    final size = widget.minHitSize;
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
          child: size == null ? widget.child : minHitBox(size, widget.child),
        ),
      ),
    );
  }
}

/// Centers [child] in a box at least [size] on each axis — grows only the
/// invisible hit/layout area so a visually smaller control (a compact
/// chip, a sub-44 icon button) still satisfies the ≥44 touch-target
/// minimum (JaraSize.touchMin). [child]'s own painted size is untouched.
/// The one hit-target mechanism shared app-wide: built into [Pressable]
/// via [Pressable.minHitSize], and used directly by widgets (e.g.
/// JaraChip) that must not also pick up Pressable's haptic/press-scale.
Widget minHitBox(double size, Widget child) => ConstrainedBox(
      constraints: BoxConstraints(minWidth: size, minHeight: size),
      child: Center(widthFactor: 1, heightFactor: 1, child: child),
    );
