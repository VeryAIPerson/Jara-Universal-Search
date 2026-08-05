import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../design/breakpoints.dart';
import '../design/jara_theme.dart';
import '../design/tokens.dart';
import 'jara_wave.dart';

/// Dual-hemisphere page: deep "memory sky" panel + soft surface panel,
/// separated by the Horizon S-curve.
///
/// [sky] renders on the dark gradient (use `tokens.textOnSky*` colors);
/// [surface] renders on the soft hemisphere. With [inverted] the
/// hemispheres swap (used by the Memory screen, like the reference's
/// second composition).
///
/// The scaffold picks its own axis from the window class (D17) — call
/// sites never say which one they want:
///
/// * `horizontal` (phones) — sky above, surface below, curve across.
///   Scrolls as one column. This is the signed-off phone composition and
///   is byte-for-byte what shipped.
/// * `vertical` (>= 600) — sky becomes a command column of
///   [JaraBreakpoints.skyColumnWidth] running full height with the curve
///   flowing down its inner edge; the surface fills the rest. The two
///   panes scroll independently, so a long result list can never drag
///   the search field off screen.
/// * `none` (watch, < 320) — two hemispheres do not fit, so the split is
///   dropped: one dark ground, one scroll, no curve.
class HorizonScaffold extends StatelessWidget {
  const HorizonScaffold({
    super.key,
    required this.sky,
    required this.surface,
    this.inverted = false,
    this.skyPadding = const EdgeInsets.fromLTRB(20, 8, 20, 96),
    this.surfacePadding = const EdgeInsets.fromLTRB(20, 40, 20, 120),
    this.controller,
  });

  final Widget sky;
  final Widget surface;
  final bool inverted;
  final EdgeInsets skyPadding;
  final EdgeInsets surfacePadding;

  /// Drives the content scroll: the single column on phones and watches,
  /// the surface pane when the Horizon has rotated.
  final ScrollController? controller;

  static const _physics =
      BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics());

  @override
  Widget build(BuildContext context) {
    final t = context.jara;
    final dir = Directionality.maybeOf(context) ?? TextDirection.ltr;

    return switch (JaraBreakpoints.axisFor(context.windowClass)) {
      HorizonAxis.horizontal => _stacked(t, dir),
      HorizonAxis.vertical => _columns(t, dir),
      HorizonAxis.none => _flat(t),
    };
  }

  /// Phones: unchanged from the signed-off screenshots. The only new
  /// input is the text direction, which mirrors the curve in RTL and
  /// resolves to the identical path in LTR.
  Widget _stacked(JaraTokens t, TextDirection dir) {
    final skyPanel = ClipPath(
      clipper: JaraWaveClipper(inverted: inverted, textDirection: dir),
      child: DecoratedBox(
        decoration: BoxDecoration(gradient: t.skyGradient),
        child: SafeArea(
          bottom: false,
          top: !inverted,
          child: Padding(
            padding: inverted
                ? skyPadding.copyWith(top: skyPadding.top + 64)
                : skyPadding,
            child: sky,
          ),
        ),
      ),
    );

    final surfacePanel = Padding(
      padding: inverted
          ? surfacePadding.copyWith(bottom: 0)
          : surfacePadding,
      child: SafeArea(top: inverted, bottom: false, child: surface),
    );

    return ColoredBox(
      color: t.surface,
      child: SingleChildScrollView(
        controller: controller,
        physics: _physics,
        child: inverted
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  surfacePanel,
                  const SizedBox(height: 28),
                  Transform.translate(
                    offset: const Offset(0, 0),
                    child: skyPanel,
                  ),
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  skyPanel,
                  Transform.translate(
                    offset: const Offset(0, -34),
                    child: surfacePanel,
                  ),
                ],
              ),
      ),
    );
  }

  /// Tablet and desktop (D17). `inverted` still means "swap the
  /// hemispheres along the layout axis" — that axis is now start→end
  /// rather than top→bottom, so the Memory screen's flip moves the
  /// command column to the trailing side and the curve onto its leading
  /// edge. Row and EdgeInsetsDirectional resolve start/end, so in RTL
  /// the whole composition mirrors with the reader.
  Widget _columns(JaraTokens t, TextDirection dir) {
    // Side by side, each pane needs the floating-shell clearance that
    // the phone composition only had to give whichever panel came last.
    final bottomClear = math.max(skyPadding.bottom, surfacePadding.bottom);

    // The wave clearance rotates with the wave: on phones the caller
    // reserves it under the sky (96 >= the 86 deep drop), here the deep
    // cut lands on the column's inner edge, so it moves there.
    const clear = JaraWaveClipper.trailDrop;
    final skyInsets = EdgeInsetsDirectional.fromSTEB(
      skyPadding.left + (inverted ? clear : 0),
      skyPadding.top,
      skyPadding.right + (inverted ? 0 : clear),
      bottomClear,
    );

    final skyColumn = ClipPath(
      clipper: JaraWaveClipper(
        axis: Axis.vertical,
        inverted: inverted,
        textDirection: dir,
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(gradient: t.skyGradient),
        child: SafeArea(
          bottom: false,
          child: SingleChildScrollView(
            // Two scroll views in one route must not both claim the
            // primary controller; the content pane keeps it.
            primary: false,
            physics: _physics,
            padding: skyInsets,
            child: sky,
          ),
        ),
      ),
    );

    final surfaceColumn = SingleChildScrollView(
      controller: controller,
      physics: _physics,
      padding: EdgeInsetsDirectional.fromSTEB(
        surfacePadding.left,
        surfacePadding.top,
        surfacePadding.right,
        bottomClear,
      ),
      child: SafeArea(
        bottom: false,
        child: Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: JaraBreakpoints.contentMaxWidth,
            ),
            child: surface,
          ),
        ),
      ),
    );

    return ColoredBox(
      color: t.surface,
      child: LayoutBuilder(
        builder: (context, constraints) {
          // A nav rail may already have eaten into the window, so clamp
          // against our own box: the command column never takes more
          // room than the content it commands.
          final width = constraints.maxWidth.isFinite
              ? math.min(
                  JaraBreakpoints.skyColumnWidth, constraints.maxWidth / 2)
              : JaraBreakpoints.skyColumnWidth;
          final sized = SizedBox(width: width, child: skyColumn);

          return Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: inverted
                ? [Expanded(child: surfaceColumn), sized]
                : [sized, Expanded(child: surfaceColumn)],
          );
        },
      ),
    );
  }

  /// Watch (D17): the two hemispheres cannot both live in 200 dp, so the
  /// split goes away entirely. `inverted` is ignored — it flips a
  /// composition that no longer exists, and sky-then-surface stays the
  /// right reading order (command, then content). The caller's phone
  /// paddings are replaced by the watch page inset plus a plain gap: the
  /// 96/120 values only existed to clear the curve and the floating
  /// bottom bar, neither of which the watch shell has.
  Widget _flat(JaraTokens t) {
    final inset = JaraBreakpoints.pageInsetFor(WindowClass.watch);
    return DecoratedBox(
      decoration: BoxDecoration(gradient: t.skyGradient),
      child: SingleChildScrollView(
        controller: controller,
        physics: _physics,
        child: SafeArea(
          bottom: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(
                    inset, skyPadding.top, inset, JaraSpacing.md),
                child: sky,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                    inset, 0, inset, JaraSpacing.xl),
                child: surface,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
