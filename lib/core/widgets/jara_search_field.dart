import 'dart:async';

import 'package:flutter/material.dart';

import '../design/jara_theme.dart';
import '../design/motion.dart';
import '../design/tokens.dart';
import '../design/typography.dart';
import 'pressable.dart';

/// The command bar — deliberately taller and heavier than a classic search
/// bar; the centerpiece of the sky hemisphere. Rotates placeholder
/// examples, glows on focus, hosts voice + filter actions.
class JaraSearchField extends StatefulWidget {
  const JaraSearchField({
    super.key,
    this.controller,
    this.focusNode,
    this.hints = const [],
    this.onSubmitted,
    this.onChanged,
    this.onVoiceTap,
    this.onFilterTap,
    this.onTap,
    this.readOnly = false,
    this.autofocus = false,
    this.hero = true,
  });

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final List<String> hints;
  final ValueChanged<String>? onSubmitted;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onVoiceTap;
  final VoidCallback? onFilterTap;
  final VoidCallback? onTap;
  final bool readOnly;
  final bool autofocus;

  /// Hero-wrap so the field glides between home and results.
  final bool hero;

  @override
  State<JaraSearchField> createState() => _JaraSearchFieldState();
}

class _JaraSearchFieldState extends State<JaraSearchField> {
  late final FocusNode _focus = widget.focusNode ?? FocusNode();
  late final TextEditingController _controller =
      widget.controller ?? TextEditingController();
  Timer? _hintTimer;
  int _hintIndex = 0;
  bool _focused = false;

  @override
  void initState() {
    super.initState();
    _focus.addListener(_onFocus);
    if (widget.hints.length > 1) {
      _hintTimer = Timer.periodic(const Duration(milliseconds: 3600), (_) {
        if (!mounted || _controller.text.isNotEmpty) return;
        setState(() => _hintIndex = (_hintIndex + 1) % widget.hints.length);
      });
    }
  }

  void _onFocus() => setState(() => _focused = _focus.hasFocus);

  @override
  void dispose() {
    _hintTimer?.cancel();
    _focus.removeListener(_onFocus);
    if (widget.focusNode == null) _focus.dispose();
    if (widget.controller == null) _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = context.jara;
    final hint = widget.hints.isEmpty ? '' : widget.hints[_hintIndex];

    final field = AnimatedContainer(
      duration: JaraMotion.of(context, JaraMotion.base),
      curve: JaraMotion.standard,
      height: JaraSize.searchFieldHeight,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: t.tileOnSky,
        borderRadius: BorderRadius.circular(JaraRadius.field),
        border: Border.all(
          color: _focused ? t.accent : t.borderOnSky,
          width: _focused ? 1.4 : 1,
        ),
        boxShadow: _focused ? t.accentGlow : null,
      ),
      child: Row(
        children: [
          const SizedBox(width: 8),
          Icon(Icons.search_rounded,
              color: _focused ? t.accent : t.textOnSkyTertiary, size: 22),
          const SizedBox(width: 8),
          Expanded(
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                if (_controller.text.isEmpty)
                  IgnorePointer(
                    child: AnimatedSwitcher(
                      duration: JaraMotion.of(context, JaraMotion.gentle),
                      switchInCurve: JaraMotion.enter,
                      transitionBuilder: (child, anim) => FadeTransition(
                        opacity: anim,
                        child: SlideTransition(
                          position: Tween(
                                  begin: const Offset(0, 0.4),
                                  end: Offset.zero)
                              .animate(anim),
                          child: child,
                        ),
                      ),
                      child: Text(
                        hint,
                        key: ValueKey(_hintIndex),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: JaraType.callout
                            .copyWith(color: t.textOnSkyTertiary),
                      ),
                    ),
                  ),
                TextField(
                  controller: _controller,
                  focusNode: _focus,
                  readOnly: widget.readOnly,
                  autofocus: widget.autofocus,
                  onTap: widget.onTap,
                  onChanged: (v) {
                    setState(() {});
                    widget.onChanged?.call(v);
                  },
                  onSubmitted: widget.onSubmitted,
                  textInputAction: TextInputAction.search,
                  style: JaraType.bodyMedium.copyWith(color: t.textOnSky),
                  cursorColor: t.accent,
                  decoration: const InputDecoration(
                    isCollapsed: true,
                    border: InputBorder.none,
                  ),
                ),
              ],
            ),
          ),
          if (_controller.text.isNotEmpty)
            NeuMiniAction(
              icon: Icons.close_rounded,
              semanticLabel: 'Clear search',
              onTap: () {
                _controller.clear();
                setState(() {});
                widget.onChanged?.call('');
              },
            ),
          if (widget.onFilterTap != null)
            NeuMiniAction(
              icon: Icons.tune_rounded,
              semanticLabel: 'Search filters',
              onTap: widget.onFilterTap!,
            ),
          if (widget.onVoiceTap != null) ...[
            const SizedBox(width: 4),
            Pressable(
              onTap: widget.onVoiceTap,
              semanticLabel: 'Voice search',
              child: Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  gradient: t.accentGradient,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: t.accentGlow,
                ),
                child: const Icon(Icons.mic_none_rounded,
                    color: Colors.white, size: 21),
              ),
            ),
          ],
          const SizedBox(width: 4),
        ],
      ),
    );

    // TextField needs a Material ancestor; provide our own (transparent,
    // zero visual effect) so the field also stands outside a Scaffold —
    // hero flights already required it on the hero path.
    final material = Material(type: MaterialType.transparency, child: field);
    if (!widget.hero) return material;
    return Hero(tag: 'jara-search-field', child: material);
  }
}

/// Tiny inline action inside the search field.
class NeuMiniAction extends StatelessWidget {
  const NeuMiniAction({
    super.key,
    required this.icon,
    required this.onTap,
    this.semanticLabel,
  });

  final IconData icon;
  final VoidCallback onTap;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final t = context.jara;
    return Pressable(
      onTap: onTap,
      semanticLabel: semanticLabel,
      child: SizedBox(
        width: 38,
        height: 44,
        child: Icon(icon, size: 20, color: t.textOnSkySecondary),
      ),
    );
  }
}
