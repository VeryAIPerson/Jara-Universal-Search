import 'package:flutter/widgets.dart';

import 'strings.dart';
import 'strings_ar.dart';
import 'strings_de.dart';
import 'strings_en.dart';
import 'strings_es.dart';
import 'strings_fa.dart';
import 'strings_fr.dart';
import 'strings_hi.dart';
import 'strings_id.dart';
import 'strings_it.dart';
import 'strings_ja.dart';
import 'strings_ko.dart';
import 'strings_nl.dart';
import 'strings_pl.dart';
import 'strings_pt_br.dart';
import 'strings_ru.dart';
import 'strings_th.dart';
import 'strings_tr.dart';
import 'strings_vi.dart';
import 'strings_zh_hans.dart';
import 'strings_zh_hant.dart';

/// One shipped language: its locale, the deck that implements it, and the
/// name to show in the picker — always written in the language itself, so
/// a user who cannot read the current UI can still find their own.
class JaraLocale {
  const JaraLocale({
    required this.locale,
    required this.strings,
    required this.endonym,
  });

  final Locale locale;
  final JaraStrings strings;

  /// e.g. "Türkçe", "العربية", "简体中文".
  final String endonym;

  /// Arabic and Persian mirror the whole layout, including the Horizon
  /// curve. Driven off the language tag rather than a hand-kept flag.
  bool get isRtl => const {'ar', 'fa', 'he', 'ur'}.contains(
        locale.languageCode,
      );
}

/// The 20 markets JARA ships in (D19). Order is the picker's order:
/// English first as the source language, then by market reach.
const jaraLocales = <JaraLocale>[
  JaraLocale(
    locale: Locale('en'),
    strings: JaraStringsEn(),
    endonym: 'English',
  ),
  JaraLocale(
    locale: Locale('zh', 'Hans'),
    strings: JaraStringsZhHans(),
    endonym: '简体中文',
  ),
  JaraLocale(
    locale: Locale('es'),
    strings: JaraStringsEs(),
    endonym: 'Español',
  ),
  JaraLocale(
    locale: Locale('ar'),
    strings: JaraStringsAr(),
    endonym: 'العربية',
  ),
  JaraLocale(
    locale: Locale('hi'),
    strings: JaraStringsHi(),
    endonym: 'हिन्दी',
  ),
  JaraLocale(
    locale: Locale('pt', 'BR'),
    strings: JaraStringsPtBr(),
    endonym: 'Português (Brasil)',
  ),
  JaraLocale(
    locale: Locale('ru'),
    strings: JaraStringsRu(),
    endonym: 'Русский',
  ),
  JaraLocale(
    locale: Locale('ja'),
    strings: JaraStringsJa(),
    endonym: '日本語',
  ),
  JaraLocale(
    locale: Locale('de'),
    strings: JaraStringsDe(),
    endonym: 'Deutsch',
  ),
  JaraLocale(
    locale: Locale('fr'),
    strings: JaraStringsFr(),
    endonym: 'Français',
  ),
  JaraLocale(
    locale: Locale('ko'),
    strings: JaraStringsKo(),
    endonym: '한국어',
  ),
  JaraLocale(
    locale: Locale('it'),
    strings: JaraStringsIt(),
    endonym: 'Italiano',
  ),
  JaraLocale(
    locale: Locale('tr'),
    strings: JaraStringsTr(),
    endonym: 'Türkçe',
  ),
  JaraLocale(
    locale: Locale('id'),
    strings: JaraStringsId(),
    endonym: 'Bahasa Indonesia',
  ),
  JaraLocale(
    locale: Locale('vi'),
    strings: JaraStringsVi(),
    endonym: 'Tiếng Việt',
  ),
  JaraLocale(
    locale: Locale('th'),
    strings: JaraStringsTh(),
    endonym: 'ไทย',
  ),
  JaraLocale(
    locale: Locale('pl'),
    strings: JaraStringsPl(),
    endonym: 'Polski',
  ),
  JaraLocale(
    locale: Locale('nl'),
    strings: JaraStringsNl(),
    endonym: 'Nederlands',
  ),
  JaraLocale(
    locale: Locale('zh', 'Hant'),
    strings: JaraStringsZhHant(),
    endonym: '繁體中文',
  ),
  JaraLocale(
    locale: Locale('fa'),
    strings: JaraStringsFa(),
    endonym: 'فارسی',
  ),
];

const _fallback = JaraLocale(
  locale: Locale('en'),
  strings: JaraStringsEn(),
  endonym: 'English',
);

/// Resolves a locale to its deck. Falls back language-tag first (so a
/// `zh-Hant-HK` device still gets Traditional Chinese and `pt-PT` still
/// gets Portuguese), then to English.
JaraLocale resolveJaraLocale(Locale locale) {
  for (final entry in jaraLocales) {
    if (entry.locale == locale) return entry;
  }
  for (final entry in jaraLocales) {
    if (entry.locale.languageCode == locale.languageCode &&
        entry.locale.countryCode == locale.countryCode) {
      return entry;
    }
  }
  for (final entry in jaraLocales) {
    if (entry.locale.languageCode == locale.languageCode) return entry;
  }
  return _fallback;
}

List<Locale> get jaraSupportedLocales =>
    jaraLocales.map((e) => e.locale).toList(growable: false);
