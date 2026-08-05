import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jara_universal_search/core/data/mock_memory_repository.dart';
import 'package:jara_universal_search/core/design/jara_theme.dart';
import 'package:jara_universal_search/core/design/tokens.dart';
import 'package:jara_universal_search/core/models/memory_item.dart';
import 'package:jara_universal_search/core/widgets/jara_search_field.dart';
import 'package:jara_universal_search/core/widgets/neu_tile.dart';
import 'package:jara_universal_search/core/widgets/result_cards.dart';

Widget _host(Widget child, {Brightness brightness = Brightness.dark}) {
  return MaterialApp(
    theme: buildJaraTheme(brightness),
    home: Scaffold(body: Center(child: child)),
  );
}

void main() {
  test('tokens: both themes expose the dark sky signature', () {
    expect(JaraTokens.dark.skyTop, JaraTokens.light.skyTop);
    expect(JaraTokens.dark.isDark, isTrue);
    expect(JaraTokens.light.isDark, isFalse);
    expect(JaraTokens.light.surface, JaraPalette.mist);
  });

  test('mock repository: search finds seeded VoxBridge memories', () {
    final repo = MockMemoryRepository();
    final outcome = repo.search('voxbridge tts');
    expect(outcome.items, isNotEmpty);
    expect(outcome.summary, isNotNull);
    expect(outcome.summary!.sourceCount, greaterThan(1));

    final filtered =
        repo.search('voxbridge', filter: MemoryType.screenshot).items;
    expect(filtered.every((i) => i.type == MemoryType.screenshot), isTrue);
  });

  test('mock repository: pin toggle and add are revision-safe', () {
    final repo = MockMemoryRepository();
    final id = repo.all.first.id;
    final was = repo.all.first.pinned;
    repo.togglePin(id);
    expect(repo.byId(id)!.pinned, !was);

    final before = repo.all.length;
    repo.add(MemoryItem(
      id: 'test-item',
      type: MemoryType.note,
      title: 'Test note',
      snippet: 'snippet',
      source: 'Test',
      date: DateTime.now(),
    ));
    expect(repo.all.length, before + 1);
    expect(repo.search('Test note').items.first.id, 'test-item');
  });

  testWidgets('JaraSearchField focuses and accepts input', (tester) async {
    String? submitted;
    await tester.pumpWidget(_host(Padding(
      padding: const EdgeInsets.all(16),
      child: JaraSearchField(
        hints: const ['Find anything'],
        onSubmitted: (v) => submitted = v,
      ),
    )));
    await tester.enterText(find.byType(TextField), 'passport');
    await tester.testTextInput.receiveAction(TextInputAction.search);
    await tester.pump();
    expect(submitted, 'passport');
  });

  testWidgets('NeuTile renders label, meta and semantics', (tester) async {
    var tapped = false;
    await tester.pumpWidget(_host(SizedBox(
      width: 120,
      height: 120,
      child: NeuTile(
        icon: Icons.description_outlined,
        iconColor: JaraPalette.srcDocument,
        label: 'Documents',
        meta: '128 · .pdf',
        onTap: () => tapped = true,
      ),
    )));
    expect(find.text('Documents'), findsOneWidget);
    expect(find.text('128 · .pdf'), findsOneWidget);
    await tester.tap(find.text('Documents'));
    await tester.pumpAndSettle();
    expect(tapped, isTrue);
  });

  testWidgets('UniversalResultCard highlights query and shows calendar block',
      (tester) async {
    final item = MemoryItem(
      id: 'cal',
      type: MemoryType.calendar,
      title: 'Doctor checkup',
      snippet: 'Annual checkup with results',
      source: 'Calendar',
      date: DateTime(2026, 8, 15, 9, 30),
      timeLabel: '09:30',
    );
    await tester.pumpWidget(_host(
      UniversalResultCard(item: item, query: 'doctor', dateLabel: 'Aug 15'),
      brightness: Brightness.light,
    ));
    expect(find.text('15'), findsOneWidget);
    expect(find.text('AUG'), findsOneWidget);
    expect(find.textContaining('Calendar'), findsOneWidget);
  });
}
