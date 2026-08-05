import 'package:flutter/widgets.dart';

/// The Horizon: an asymmetric S-curve that closes the bottom edge of the
/// memory-sky panel — the visual signature carried over from the reference
/// composition. [leftDrop]/[rightDrop] are how far above the panel's bottom
/// edge the curve sits at each side.
class JaraWaveClipper extends CustomClipper<Path> {
  const JaraWaveClipper({
    this.leftDrop = 44,
    this.rightDrop = 86,
    this.inverted = false,
  });

  final double leftDrop;
  final double rightDrop;

  /// When true the curve caps the TOP edge instead (memory sky below).
  final bool inverted;

  @override
  Path getClip(Size size) {
    final w = size.width;
    final h = size.height;
    final path = Path();

    if (!inverted) {
      path
        ..lineTo(0, h - leftDrop)
        ..cubicTo(w * 0.22, h + 18, w * 0.42, h - 4, w * 0.58, h - 34)
        ..cubicTo(w * 0.74, h - 62, w * 0.86, h - rightDrop, w, h - rightDrop)
        ..lineTo(w, 0)
        ..close();
    } else {
      path
        ..moveTo(0, leftDrop)
        ..cubicTo(w * 0.22, -18, w * 0.42, 4, w * 0.58, 34)
        ..cubicTo(w * 0.74, 62, w * 0.86, rightDrop, w, rightDrop)
        ..lineTo(w, h)
        ..lineTo(0, h)
        ..close();
    }
    return path;
  }

  @override
  bool shouldReclip(JaraWaveClipper old) =>
      old.leftDrop != leftDrop ||
      old.rightDrop != rightDrop ||
      old.inverted != inverted;
}
