import 'package:flutter/material.dart';

import '../design/jara_theme.dart';
import 'jara_wave.dart';

/// Dual-hemisphere page: deep "memory sky" panel + soft surface panel,
/// separated by the Horizon S-curve. Scrolls as one column.
///
/// [sky] renders on the dark gradient (use `tokens.textOnSky*` colors);
/// [surface] renders on the soft hemisphere. With [inverted] the soft
/// hemisphere is on top (used by the Memory screen, like the reference's
/// second composition).
class HorizonScaffold extends StatelessWidget {
  const HorizonScaffold({
    super.key,
    required this.sky,
    required this.surface,
    this.inverted = false,
    this.skyPadding = const EdgeInsets.fromLTRB(20, 8, 20, 64),
    this.surfacePadding = const EdgeInsets.fromLTRB(20, 0, 20, 120),
    this.controller,
  });

  final Widget sky;
  final Widget surface;
  final bool inverted;
  final EdgeInsets skyPadding;
  final EdgeInsets surfacePadding;
  final ScrollController? controller;

  @override
  Widget build(BuildContext context) {
    final t = context.jara;

    final skyPanel = ClipPath(
      clipper: JaraWaveClipper(inverted: inverted),
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
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
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
}
