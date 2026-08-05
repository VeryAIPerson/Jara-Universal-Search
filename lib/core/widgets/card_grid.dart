import 'package:flutter/material.dart';

import '../design/tokens.dart';

/// Result cards read better side by side than as one very wide column —
/// but only while each card keeps a scannable width. Lifted here after
/// four screens grew byte-identical copies; the column count comes from
/// the caller (usually `JaraBreakpoints.gridColumnsFor`), the width floor
/// is enforced locally so a narrow pane degrades to one column.
Widget cardGrid(List<Widget> cards, int columns) {
  const gap = JaraSpacing.md;
  const minCard = 320.0;
  return LayoutBuilder(
    builder: (context, c) {
      final fits = ((c.maxWidth + gap) / (minCard + gap)).floor();
      final n = columns < fits ? columns : (fits < 1 ? 1 : fits);
      if (n < 2) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            for (var i = 0; i < cards.length; i++) ...[
              if (i > 0) const SizedBox(height: gap),
              cards[i],
            ],
          ],
        );
      }
      final width = ((c.maxWidth - gap * (n - 1)) / n).floorToDouble();
      return Wrap(
        spacing: gap,
        runSpacing: gap,
        children: [
          for (final card in cards) SizedBox(width: width, child: card),
        ],
      );
    },
  );
}
