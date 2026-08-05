import 'package:flutter/widgets.dart';

/// Bolds query tokens inside result text.
InlineSpan highlightSpans(
  String text,
  String query, {
  required TextStyle style,
  required TextStyle highlightStyle,
}) {
  final tokens = query
      .toLowerCase()
      .split(RegExp(r'[\s,]+'))
      .where((t) => t.length > 1)
      .toSet();
  if (tokens.isEmpty) return TextSpan(text: text, style: style);

  final spans = <TextSpan>[];
  final lower = text.toLowerCase();
  var cursor = 0;

  while (cursor < text.length) {
    var matchStart = -1;
    var matchEnd = -1;
    for (final t in tokens) {
      final idx = lower.indexOf(t, cursor);
      if (idx != -1 && (matchStart == -1 || idx < matchStart)) {
        matchStart = idx;
        matchEnd = idx + t.length;
      }
    }
    if (matchStart == -1) {
      spans.add(TextSpan(text: text.substring(cursor), style: style));
      break;
    }
    if (matchStart > cursor) {
      spans.add(
          TextSpan(text: text.substring(cursor, matchStart), style: style));
    }
    spans.add(TextSpan(
        text: text.substring(matchStart, matchEnd), style: highlightStyle));
    cursor = matchEnd;
  }
  return TextSpan(children: spans);
}
