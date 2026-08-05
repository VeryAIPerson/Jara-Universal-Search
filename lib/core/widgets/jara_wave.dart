import 'package:flutter/widgets.dart';

/// The Horizon: an asymmetric S-curve that closes one edge of the
/// memory-sky panel — the visual signature carried over from the
/// reference composition.
///
/// The gesture is written once as a table of (run, drop) pairs: how far
/// along the curve's own axis a control point sits, and how deep it cuts
/// into the panel from the edge it caps. Every orientation is a
/// projection of that one table, so the vertical Horizon (tablet and
/// desktop, D17) is the same drawing rather than a second set of
/// hand-tuned coordinates — and the horizontal phone path comes out of
/// it unchanged, point for point.
///
/// [leftDrop]/[rightDrop] keep their phone names: the drop where the run
/// starts and where it ends. Running vertically they are the top and
/// bottom drops; in RTL they land on the mirrored sides.
class JaraWaveClipper extends CustomClipper<Path> {
  const JaraWaveClipper({
    this.leftDrop = leadDrop,
    this.rightDrop = trailDrop,
    this.inverted = false,
    this.axis = Axis.horizontal,
    this.textDirection = TextDirection.ltr,
  });

  /// Drop where the run starts — the shallow side of the asymmetry.
  static const double leadDrop = 44;

  /// Drop where the run ends — the deep side. Panel content has to clear
  /// this much of the capped edge; HorizonScaffold's paddings do that.
  static const double trailDrop = 86;

  final double leftDrop;
  final double rightDrop;

  /// When true the curve caps the panel's leading edge instead of its
  /// trailing one: the TOP edge when [axis] is horizontal (memory sky
  /// below — the Memory screen), the START edge when it is vertical.
  final bool inverted;

  /// Which way the curve runs: across the panel (phones) or down it
  /// (the tablet/desktop command column).
  final Axis axis;

  /// RTL mirrors the whole gesture about the panel's vertical centre, so
  /// an Arabic reader meets the shallow side of the curve first exactly
  /// like an English one does.
  final TextDirection textDirection;

  @override
  Path getClip(Size size) {
    final w = size.width;
    final h = size.height;
    final rtl = textDirection == TextDirection.rtl;

    double mx(double x) => rtl ? w - x : x;

    // (run, drop) → panel coordinates. Horizontal runs along the width
    // and drops along the height; vertical swaps the two.
    Offset at(double run, double drop) => axis == Axis.horizontal
        ? Offset(mx(run * w), inverted ? drop : h - drop)
        : Offset(mx(inverted ? drop : w - drop), run * h);

    // The two corners on the uncapped edge, which close the panel.
    Offset corner(double run) => axis == Axis.horizontal
        ? Offset(mx(run * w), inverted ? h : 0)
        : Offset(mx(inverted ? w : 0), run * h);

    final from = corner(0);
    final start = at(0, leftDrop);
    final a1 = at(0.22, -18);
    final a2 = at(0.42, 4);
    final crest = at(0.58, 34);
    final b1 = at(0.74, 62);
    final b2 = at(0.86, rightDrop);
    final end = at(1, rightDrop);
    final to = corner(1);

    return Path()
      ..moveTo(from.dx, from.dy)
      ..lineTo(start.dx, start.dy)
      ..cubicTo(a1.dx, a1.dy, a2.dx, a2.dy, crest.dx, crest.dy)
      ..cubicTo(b1.dx, b1.dy, b2.dx, b2.dy, end.dx, end.dy)
      ..lineTo(to.dx, to.dy)
      ..close();
  }

  @override
  bool shouldReclip(JaraWaveClipper old) =>
      old.leftDrop != leftDrop ||
      old.rightDrop != rightDrop ||
      old.inverted != inverted ||
      old.axis != axis ||
      old.textDirection != textDirection;
}
