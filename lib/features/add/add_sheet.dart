import 'package:flutter/material.dart';

/// Opens the Add to JARA sheet. Replaced by the capture feature package.
Future<void> showAddSheet(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (context) => const SizedBox(height: 320),
  );
}
