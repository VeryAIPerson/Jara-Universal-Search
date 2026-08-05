import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jara_universal_search/core/models/memory_item.dart';
import 'package:jara_universal_search/l10n/locales.dart';
import 'package:jara_universal_search/l10n/strings.dart';

/// The typed deck makes a missing key a compile error, so these tests
/// cover what the compiler cannot: empty strings, untranslated leftovers,
/// broken interpolation and lost brand tokens across all 20 markets.
void main() {
  test('ships exactly the 20 declared markets, no duplicates', () {
    expect(jaraLocales.length, 20);
    final tags = jaraLocales.map((e) => e.locale.toString()).toSet();
    expect(tags.length, 20);
    expect(jaraLocales.where((e) => e.isRtl).length, 2);
  });

  test('every locale resolves, including regional variants', () {
    expect(resolveJaraLocale(const Locale('tr')).locale.languageCode, 'tr');
    expect(resolveJaraLocale(const Locale('zh', 'Hant')).endonym, '繁體中文');
    expect(resolveJaraLocale(const Locale('zh', 'Hans')).endonym, '简体中文');
    // Unlisted region falls back on the language tag, not to English.
    expect(resolveJaraLocale(const Locale('pt', 'PT')).locale.languageCode,
        'pt');
    expect(resolveJaraLocale(const Locale('de', 'AT')).locale.languageCode,
        'de');
    // Unknown language falls back to the source language.
    expect(resolveJaraLocale(const Locale('is')).locale.languageCode, 'en');
  });

  test('Slavic plurals keep the real number, not the modulo', () {
    // 41 takes the singular form in Russian and Polish; the count shown
    // must still be 41. Hardcoding "1" in the one-branch is the classic
    // bug here and it shipped in the first draft of both decks.
    final ru = resolveJaraLocale(const Locale('ru')).strings;
    final pl = resolveJaraLocale(const Locale('pl')).strings;
    for (final s in [ru, pl]) {
      expect(s.newItemsThisWeek(41), contains('41'));
      expect(s.collectionItems(21), contains('21'));
      expect(s.resultsCount(101, '0.2 s'), contains('101'));
      expect(s.memoryStatusItems(31, 21),
          allOf(contains('31'), contains('21')));
      expect(s.basedOnItems(21), contains('21'));
    }
  });

  test('Arabic uses the dual rather than a digit for two', () {
    final ar = resolveJaraLocale(const Locale('ar')).strings;
    expect(ar.hoursAgo(2), 'قبل ساعتين');
    expect(ar.hoursAgo(7), contains('7'));
  });

  for (final entry in jaraLocales) {
    final tag = entry.locale.toString();
    final s = entry.strings;

    test('$tag — no empty or placeholder copy', () {
      final samples = <String>[
        s.appName, s.tagline, s.onb1Title, s.onb1Body, s.onb2Title,
        s.onb3Title, s.onbPrimaryCta, s.onbSecondaryCta, s.searchTitle,
        s.filterAll, s.memoryTitle, s.collectionsTitle, s.settingsTitle,
        s.privacyTitle, s.connectionsTitle, s.addTitle, s.shareTitle,
        s.emptyResultsTitle, s.emptyMemoryTitle, s.offlineLabel,
        s.back, s.done, s.apply, s.continueCta, s.searchAction,
        s.needsConnection, s.today, s.tomorrow, s.yesterday,
      ];
      for (final value in samples) {
        expect(value.trim(), isNotEmpty, reason: '$tag has an empty string');
        expect(value, isNot(contains('TODO')), reason: '$tag has a TODO');
      }
      expect(s.searchHints.length, 5, reason: '$tag needs 5 search hints');
      for (final hint in s.searchHints) {
        expect(hint.trim(), isNotEmpty);
      }
    });

    test('$tag — interpolations survive translation', () {
      expect(s.collectionItems(7), contains('7'));
      expect(s.basedOnItems(4), contains('4'));
      expect(s.resultsCount(6, '0.2 s'), allOf(contains('6'), contains('0.2')));
      expect(s.memoryStatusItems(3248, 6),
          allOf(contains('3248'), contains('6')));
      expect(s.newItemsThisWeek(41), contains('41'));
      // Counts chosen to avoid the dual: Arabic renders "two hours" as a
      // single inflected word (ساعتين) with no digit at all, which is
      // correct grammar rather than a lost interpolation.
      expect(s.daysAgo(3), contains('3'));
      expect(s.inDays(5), contains('5'));
      expect(s.minutesAgo(12), contains('12'));
      expect(s.hoursAgo(7), contains('7'));
      expect(s.indexedAgo('X'), contains('X'));
      expect(s.updatedAgo('X'), contains('X'));
      expect(s.lastSynced('X'), contains('X'));
      expect(s.memoryStatusFree('38 GB'), contains('38 GB'));
      // Empty name must not leave a dangling honorific or comma.
      for (final greeting in [
        s.greetingMorning(''),
        s.greetingDay(''),
        s.greetingEvening(''),
      ]) {
        expect(greeting.trim(), isNotEmpty);
        expect(greeting.trimLeft(), isNot(startsWith(',')));
        expect(greeting.trimLeft(), isNot(startsWith('،')));
      }
      expect(s.greetingMorning('Azad'), contains('Azad'));
    });

    test('$tag — every error case is covered and calm', () {
      for (final e in JaraError.values) {
        expect(s.errorTitle(e).trim(), isNotEmpty);
        expect(s.errorBody(e).trim(), isNotEmpty);
      }
      // The three cases that resolve themselves offer no action.
      expect(s.errorCta(JaraError.fileUnreadable), isNull);
      expect(s.errorCta(JaraError.noConnection), isNull);
      expect(s.errorCta(JaraError.localModelNotReady), isNull);
      expect(s.errorCta(JaraError.generic), isNotNull);
    });

    test('$tag — every memory type is labelled', () {
      for (final type in MemoryType.values) {
        expect(s.typeLabel(type).trim(), isNotEmpty);
        expect(s.typePluralLabel(type).trim(), isNotEmpty);
      }
    });

    test('$tag — brand tokens are never translated', () {
      expect(s.productName, 'Universal Search');
      expect(s.appName, contains('JARA'));
      expect(s.privacyBiometric,
          allOf(contains('Face ID'), contains('Touch ID')));
    });

    test('$tag — no forbidden technical vocabulary', () {
      final surface = [
        s.privacyOnDeviceBody, s.privacyCloudBody, s.settingsPremiumBody,
        s.onb2Body, s.emptyMemoryBody, s.offlineBody,
        for (final e in JaraError.values) s.errorBody(e),
      ].join(' ').toLowerCase();
      for (final banned in ['embedding', 'vector database', ' rag ']) {
        expect(surface, isNot(contains(banned)), reason: '$tag leaks $banned');
      }
    });
  }
}
