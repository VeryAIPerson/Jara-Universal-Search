import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../core/design/breakpoints.dart';
import '../../core/design/jara_theme.dart';

/// Wear OS faces are mostly circular, so watch layout starts from the
/// shape of the glass rather than from a rectangle: anything the wearer
/// has to read must clear the curve at the vertical offset it sits on.
enum WatchShape { round, square }

/// Production override for [WatchShape]. Flutter surfaces no
/// `Configuration.isScreenRound()`; when that platform channel lands,
/// wrap the watch app in this scope with the real answer and the
/// MediaQuery fallback below stops being consulted.
class WatchShapeScope extends InheritedWidget {
  const WatchShapeScope({
    super.key,
    required this.shape,
    required super.child,
  });

  final WatchShape shape;

  static WatchShape? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<WatchShapeScope>()?.shape;

  @override
  bool updateShouldNotify(WatchShapeScope old) => old.shape != shape;
}

/// Resolved geometry of one watch face: shape, safe insets and the few
/// sizes that must scale with the glass instead of sitting on a fixed
/// phone token.
@immutable
class WatchMetrics {
  const WatchMetrics({
    required this.size,
    required this.shape,
    required this.systemPadding,
  });

  factory WatchMetrics.of(BuildContext context) {
    final mq = MediaQuery.of(context);
    return WatchMetrics(
      size: mq.size,
      shape: WatchShapeScope.maybeOf(context) ?? _shapeFrom(mq),
      systemPadding: mq.padding,
    );
  }

  final Size size;
  final WatchShape shape;
  final EdgeInsets systemPadding;

  bool get isRound => shape == WatchShape.round;

  /// Diameter on a round face, side on a square one.
  double get face => size.shortestSide;

  /// Round faces report their bezel through window insets — a chin on
  /// flat-tyre devices, a ring inset elsewhere — and square faces report
  /// none, which is what makes this usable as a fallback.
  static WatchShape _shapeFrom(MediaQueryData mq) {
    final inset = math.max(
      mq.padding.vertical + mq.padding.horizontal,
      mq.viewPadding.vertical + mq.viewPadding.horizontal,
    );
    return inset > 0 ? WatchShape.round : WatchShape.square;
  }

  static double get _floor =>
      JaraBreakpoints.pageInsetFor(WindowClass.watch);

  double get _hInset =>
      isRound ? face * 0.104 : math.max(_floor, face * 0.052);

  /// Bigger than the horizontal one: the top and bottom of a circle are
  /// where a rectangle loses the most width.
  double get _vInset =>
      isRound ? face * 0.156 : math.max(_floor, face * 0.06);

  /// Safe content box, never tighter than the system's own insets.
  EdgeInsets get content => EdgeInsets.fromLTRB(
        math.max(_hInset, systemPadding.left),
        math.max(_vInset, systemPadding.top),
        math.max(_hInset, systemPadding.right),
        math.max(_vInset, systemPadding.bottom),
      );

  /// Inscribed square of the face — the widest a centred fixed element
  /// may be and still clear the curve at any vertical offset it can
  /// reach. Hero elements (mic, orb, primary action, state text) use it.
  double get heroWidth =>
      isRound ? face * 0.707 : size.width - _hInset * 2;

  /// Thumb target for the one action the watch exists for.
  double get micSize => (face * 0.38).clamp(68.0, 88.0);
}

/// Watch sizing. The phone's 44 dp minimum assumes a settled two-hand
/// grip; a watch is tapped one-handed with the other arm moving, so the
/// floor moves up and rows get taller than their text needs.
abstract final class WatchSize {
  static const double touchMin = 52;
  static const double rowMin = 60;
  static const double typeChip = 34;
  static const double actionHeight = 56;
}

/// Dark ground for every watch screen. [flat] drops the sky gradient for
/// pure black where a glow needs to read against it.
class WatchScaffold extends StatelessWidget {
  const WatchScaffold({super.key, required this.child, this.flat = false});

  final Widget child;
  final bool flat;

  @override
  Widget build(BuildContext context) {
    final t = context.jara;
    return Scaffold(
      backgroundColor: t.skyBottom,
      body: DecoratedBox(
        decoration: flat
            ? BoxDecoration(color: t.skyBottom)
            : BoxDecoration(gradient: t.skyGradient),
        child: SizedBox.expand(child: child),
      ),
    );
  }
}

/// One scrolling column inside the round-safe box. Content shorter than
/// the glass centres; longer content scrolls, and the cap scrims let a
/// row dissolve into the bezel instead of being sliced by it.
class WatchScrollView extends StatelessWidget {
  const WatchScrollView({
    super.key,
    required this.children,
    this.centered = true,
    this.controller,
  });

  final List<Widget> children;
  final bool centered;
  final ScrollController? controller;

  @override
  Widget build(BuildContext context) {
    final m = WatchMetrics.of(context);
    return WatchEdgeScrim(
      height: m.content.top,
      child: LayoutBuilder(
        builder: (context, box) {
          final free = math.max(0.0, box.maxHeight - m.content.vertical);
          return SingleChildScrollView(
            controller: controller,
            padding: m.content,
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: centered ? free : 0),
              child: Column(
                mainAxisAlignment: centered
                    ? MainAxisAlignment.center
                    : MainAxisAlignment.start,
                children: children,
              ),
            ),
          );
        },
      ),
    );
  }
}

/// Wear dismisses a surface with a swipe from the bezel inwards. Flutter
/// only receives that as a back event on devices that route it as one, so
/// watch screens carry the gesture explicitly. Mirrored under RTL.
class WatchDismissible extends StatelessWidget {
  const WatchDismissible({
    super.key,
    required this.child,
    required this.onDismiss,
  });

  static const double _minVelocity = 240;

  final Widget child;
  final VoidCallback onDismiss;

  @override
  Widget build(BuildContext context) {
    final rtl = Directionality.of(context) == TextDirection.rtl;
    return GestureDetector(
      excludeFromSemantics: true,
      onHorizontalDragEnd: (d) {
        final v = d.primaryVelocity ?? 0;
        if (rtl ? v < -_minVelocity : v > _minVelocity) onDismiss();
      },
      child: child,
    );
  }
}

/// Top and bottom fade to the ground colour. On an OLED face the ground
/// is black, so this costs no light and reads as the content simply
/// running out under the bezel.
class WatchEdgeScrim extends StatelessWidget {
  const WatchEdgeScrim({
    super.key,
    required this.child,
    required this.height,
  });

  final Widget child;
  final double height;

  @override
  Widget build(BuildContext context) {
    final t = context.jara;
    return Stack(
      children: [
        child,
        _band(t.skyTop, Alignment.topCenter, Alignment.bottomCenter, true),
        _band(t.skyBottom, Alignment.bottomCenter, Alignment.topCenter, false),
      ],
    );
  }

  Widget _band(Color from, Alignment begin, Alignment end, bool atTop) {
    return Positioned(
      left: 0,
      right: 0,
      top: atTop ? 0 : null,
      bottom: atTop ? null : 0,
      height: height,
      child: IgnorePointer(
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: begin,
              end: end,
              colors: [from, from.withValues(alpha: 0)],
            ),
          ),
        ),
      ),
    );
  }
}
