import 'package:flutter/material.dart';

import '../models/memory_item.dart';

/// Local-first mock repository. Seed data is realistic (VoxBridge project,
/// travel, health, receipts) so search, summaries and suggestions demo the
/// real product promise. Swap for the on-device index behind the same API.
class MockMemoryRepository {
  MockMemoryRepository() : _items = List.of(_seed);

  final List<MemoryItem> _items;
  final List<String> recentSearches = [
    'VoxBridge pricing',
    'passport photo',
    'doctor appointment',
    'london trip',
  ];

  List<MemoryItem> get all => List.unmodifiable(_items);

  List<MemoryItem> recentlySaved({int limit = 8}) {
    final sorted = List.of(_items)..sort((a, b) => b.date.compareTo(a.date));
    return sorted.take(limit).toList();
  }

  List<MemoryItem> pinned() => _items.where((i) => i.pinned).toList();

  MemoryItem? byId(String id) {
    for (final item in _items) {
      if (item.id == id) return item;
    }
    return null;
  }

  void togglePin(String id) {
    final index = _items.indexWhere((i) => i.id == id);
    if (index == -1) return;
    _items[index] = _items[index].copyWith(pinned: !_items[index].pinned);
  }

  void remove(String id) => _items.removeWhere((i) => i.id == id);

  void add(MemoryItem item) => _items.insert(0, item);

  int countOf(MemoryType type) => _items.where((i) => i.type == type).length;

  List<MemoryItem> ofType(MemoryType type) =>
      _items.where((i) => i.type == type).toList()
        ..sort((a, b) => b.date.compareTo(a.date));

  List<MemoryItem> inCollection(String collectionId) => _items
      .where((i) => i.collection?.toLowerCase() == collectionId.toLowerCase())
      .toList()
    ..sort((a, b) => b.date.compareTo(a.date));

  List<MemoryItem> related(MemoryItem item, {int limit = 4}) {
    final scored = <(MemoryItem, int)>[];
    for (final other in _items) {
      if (other.id == item.id) continue;
      var score = 0;
      if (other.collection != null && other.collection == item.collection) {
        score += 2;
      }
      score += other.tags.where(item.tags.contains).length * 2;
      if (other.type == item.type) score += 1;
      if (score > 0) scored.add((other, score));
    }
    scored.sort((a, b) => b.$2.compareTo(a.$2));
    return scored.take(limit).map((e) => e.$1).toList();
  }

  /// Naive on-device search: token match over title/snippet/tags/people
  /// with a recency nudge. Good enough to make the demo feel real.
  SearchOutcome search(String query, {MemoryType? filter}) {
    final watch = Stopwatch()..start();
    final tokens = query
        .toLowerCase()
        .split(RegExp(r'[\s,]+'))
        .where((t) => t.length > 1)
        .toList();

    final scored = <(MemoryItem, double)>[];
    for (final item in _items) {
      if (filter != null && item.type != filter) continue;
      final title = item.title.toLowerCase();
      final snippet = item.snippet.toLowerCase();
      final haystack =
          '$title $snippet ${item.tags.join(' ').toLowerCase()} ${item.people.join(' ').toLowerCase()} ${item.collection?.toLowerCase() ?? ''}';
      var score = 0.0;
      for (final t in tokens) {
        if (title.contains(t)) score += 3;
        if (snippet.contains(t)) score += 1.5;
        if (haystack.contains(t)) score += 1;
      }
      if (score == 0) continue;
      final ageDays = DateTime.now().difference(item.date).inDays;
      score += (90 - ageDays).clamp(0, 90) / 90;
      if (item.pinned) score += 0.5;
      scored.add((item, score));
    }
    scored.sort((a, b) => b.$2.compareTo(a.$2));
    final items = scored.map((e) => e.$1).toList();
    watch.stop();

    return SearchOutcome(
      query: query,
      items: items,
      elapsed: watch.elapsed + const Duration(milliseconds: 140),
      summary: _summaryFor(query, items),
    );
  }

  SmartSummary? _summaryFor(String query, List<MemoryItem> items) {
    final q = query.toLowerCase();
    if (items.length < 2) return null;
    if (q.contains('tts') || (q.contains('voxbridge') && q.contains('provider'))) {
      return SmartSummary(
        text:
            'You compared Inworld TTS, Gemini Flash TTS and ElevenLabs. Inworld was noted as the lowest-cost option; ElevenLabs led on voice quality.',
        sourceIds: items.take(4).map((i) => i.id).toList(),
      );
    }
    if (q.contains('voxbridge')) {
      return SmartSummary(
        text:
            'VoxBridge notes cover pricing tiers, a TTS provider comparison and the launch checklist. Pricing draft: Starter \$9, Pro \$29.',
        sourceIds: items.take(4).map((i) => i.id).toList(),
      );
    }
    if (q.contains('london')) {
      return SmartSummary(
        text:
            'Your London trip is on 12–16 September: flight booking, hotel confirmation near King’s Cross, and a saved list of places to visit.',
        sourceIds: items.take(3).map((i) => i.id).toList(),
      );
    }
    return null;
  }

  List<SearchSuggestion> suggest(String prefix) {
    final p = prefix.trim().toLowerCase();
    if (p.isEmpty) {
      return recentSearches
          .map((s) => SearchSuggestion(kind: SuggestionKind.history, text: s))
          .toList();
    }
    final out = <SearchSuggestion>[];
    for (final s in recentSearches) {
      if (s.toLowerCase().contains(p)) {
        out.add(SearchSuggestion(kind: SuggestionKind.history, text: s));
      }
    }
    if ('voxbridge'.startsWith(p) || p.contains('vox')) {
      out.addAll(const [
        SearchSuggestion(
            kind: SuggestionKind.completion, text: 'VoxBridge pricing'),
        SearchSuggestion(
            kind: SuggestionKind.completion, text: 'VoxBridge launch plan'),
        SearchSuggestion(
            kind: SuggestionKind.type,
            text: 'Screenshots tagged VoxBridge',
            type: MemoryType.screenshot),
        SearchSuggestion(
            kind: SuggestionKind.type,
            text: 'Emails about VoxBridge',
            type: MemoryType.email),
      ]);
    }
    final seen = <String>{};
    for (final item in _items) {
      if (out.length >= 8) break;
      if (item.title.toLowerCase().contains(p) && seen.add(item.title)) {
        out.add(SearchSuggestion(
          kind: SuggestionKind.file,
          text: item.title,
          subtitle: item.source,
          type: item.type,
        ));
      }
    }
    return out.take(8).toList();
  }

  MemoryStats stats() => MemoryStats(
        totalItems: 3248,
        collections: collections.length,
        addedThisWeek: 41,
        indexedSources: 6,
        storageUsedLabel: '1.2 GB',
        storageFreeLabel: '38 GB free',
        indexedFraction: 0.86,
        lastIndexed: DateTime.now().subtract(const Duration(minutes: 2)),
      );

  final List<MemoryCollection> collections = [
    MemoryCollection(
      id: 'voxbridge',
      name: 'VoxBridge',
      itemCount: 24,
      updated: DateTime.now().subtract(const Duration(hours: 3)),
      color: const Color(0xFF7AA8FF),
      types: const [MemoryType.document, MemoryType.screenshot, MemoryType.note],
    ),
    MemoryCollection(
      id: 'travel',
      name: 'Travel',
      itemCount: 18,
      updated: DateTime.now().subtract(const Duration(days: 1)),
      color: const Color(0xFF64D2B4),
      types: const [MemoryType.document, MemoryType.photo, MemoryType.link],
    ),
    MemoryCollection(
      id: 'health',
      name: 'Health',
      itemCount: 9,
      updated: DateTime.now().subtract(const Duration(days: 2)),
      color: const Color(0xFFEF8BA8),
      types: const [MemoryType.calendar, MemoryType.document],
    ),
    MemoryCollection(
      id: 'receipts',
      name: 'Receipts',
      itemCount: 32,
      updated: DateTime.now().subtract(const Duration(hours: 8)),
      color: const Color(0xFFF5A25B),
      types: const [MemoryType.screenshot, MemoryType.email],
    ),
    MemoryCollection(
      id: 'work',
      name: 'Work',
      itemCount: 47,
      updated: DateTime.now().subtract(const Duration(hours: 1)),
      color: const Color(0xFF836BFF),
      types: const [MemoryType.document, MemoryType.email, MemoryType.note],
    ),
    MemoryCollection(
      id: 'ideas',
      name: 'Ideas',
      itemCount: 12,
      updated: DateTime.now().subtract(const Duration(days: 4)),
      color: const Color(0xFFF2C94C),
      types: const [MemoryType.note, MemoryType.audio],
    ),
  ];

  final List<ConnectionInfo> connections = [
    ConnectionInfo(
      id: 'photos',
      name: 'Photos',
      icon: Icons.photo_library_outlined,
      status: ConnectionStatus.connected,
      lastSync: DateTime.now().subtract(const Duration(minutes: 12)),
      permissionLabel: 'Selected albums',
      itemCount: 1892,
    ),
    ConnectionInfo(
      id: 'calendar',
      name: 'Calendar',
      icon: Icons.calendar_month_outlined,
      status: ConnectionStatus.connected,
      lastSync: DateTime.now().subtract(const Duration(minutes: 30)),
      permissionLabel: 'All calendars',
      itemCount: 214,
    ),
    const ConnectionInfo(
      id: 'reminders',
      name: 'Reminders',
      icon: Icons.checklist_rounded,
      status: ConnectionStatus.disconnected,
      permissionLabel: 'Not connected',
    ),
    ConnectionInfo(
      id: 'gmail',
      name: 'Gmail',
      icon: Icons.alternate_email_rounded,
      status: ConnectionStatus.syncing,
      lastSync: DateTime.now().subtract(const Duration(hours: 2)),
      permissionLabel: 'Read-only',
      itemCount: 640,
    ),
    const ConnectionInfo(
      id: 'outlook',
      name: 'Outlook',
      icon: Icons.mail_outline_rounded,
      status: ConnectionStatus.disconnected,
      permissionLabel: 'Not connected',
    ),
    ConnectionInfo(
      id: 'files',
      name: 'Files',
      icon: Icons.folder_outlined,
      status: ConnectionStatus.connected,
      lastSync: DateTime.now().subtract(const Duration(minutes: 5)),
      permissionLabel: 'JARA folder',
      itemCount: 486,
    ),
    ConnectionInfo(
      id: 'icloud',
      name: 'iCloud Drive',
      icon: Icons.cloud_outlined,
      status: ConnectionStatus.attention,
      lastSync: DateTime.now().subtract(const Duration(days: 6)),
      permissionLabel: 'Re-authentication needed',
      itemCount: 128,
    ),
    const ConnectionInfo(
      id: 'gdrive',
      name: 'Google Drive',
      icon: Icons.add_to_drive_outlined,
      status: ConnectionStatus.disconnected,
      permissionLabel: 'Not connected',
    ),
    const ConnectionInfo(
      id: 'dropbox',
      name: 'Dropbox',
      icon: Icons.inbox_outlined,
      status: ConnectionStatus.disconnected,
      permissionLabel: 'Not connected',
    ),
  ];
}

final _now = DateTime.now();

final List<MemoryItem> _seed = [
  MemoryItem(
    id: 'doc-vox-pricing',
    type: MemoryType.document,
    title: 'VoxBridge pricing draft v3',
    snippet:
        'Starter \$9/mo (2 voices, 30 min). Pro \$29/mo (12 voices, 5 hrs, priority queue). Enterprise custom. Inworld TTS keeps unit cost lowest at scale.',
    source: 'Files · JARA folder',
    date: _now.subtract(const Duration(hours: 4)),
    tags: const ['voxbridge', 'pricing'],
    collection: 'VoxBridge',
    extLabel: '.pdf',
    sizeLabel: '1.4 MB',
    pageLabel: 'p. 2 of 6',
    pinned: true,
  ),
  MemoryItem(
    id: 'note-tts-compare',
    type: MemoryType.note,
    title: 'TTS provider comparison',
    snippet:
        'Inworld TTS — lowest cost, good latency. Gemini Flash TTS — fast, mid quality. ElevenLabs — best quality, priciest. Decision: prototype with Inworld, premium tier on ElevenLabs.',
    source: 'JARA Notes',
    date: _now.subtract(const Duration(days: 2)),
    tags: const ['voxbridge', 'tts', 'research'],
    collection: 'VoxBridge',
  ),
  MemoryItem(
    id: 'shot-vox-quota',
    type: MemoryType.screenshot,
    title: 'ElevenLabs quota screen',
    snippet: 'Detected text: "Character quota 82% used · resets Aug 12".',
    source: 'Screenshots',
    date: _now.subtract(const Duration(days: 1)),
    tags: const ['voxbridge', 'tts'],
    collection: 'VoxBridge',
    extLabel: '.png',
    matchReason: 'Text found in image',
  ),
  MemoryItem(
    id: 'mail-vox-invoice',
    type: MemoryType.email,
    title: 'Inworld — July invoice',
    snippet: 'Your July usage: 214k characters, \$18.40. Invoice attached.',
    source: 'Gmail',
    date: _now.subtract(const Duration(days: 5)),
    tags: const ['voxbridge', 'invoice'],
    people: const ['billing@inworld.ai'],
    collection: 'Receipts',
  ),
  MemoryItem(
    id: 'note-vox-launch',
    type: MemoryType.note,
    title: 'VoxBridge launch plan',
    snippet:
        'Beta: Sep 1. Store listing draft ready. Demo video pending. Pricing page copies from draft v3.',
    source: 'JARA Notes',
    date: _now.subtract(const Duration(days: 3)),
    tags: const ['voxbridge', 'launch'],
    collection: 'VoxBridge',
  ),
  MemoryItem(
    id: 'doc-london-itin',
    type: MemoryType.document,
    title: 'London trip itinerary',
    snippet:
        'Flights TK1979 out 12 Sep 08:40, return 16 Sep. Hotel: Kings Cross Inn, conf #HX-2214. Day 2: British Museum, day 3: meetings in Shoreditch.',
    source: 'Files · Dropbox',
    date: _now.subtract(const Duration(days: 12)),
    tags: const ['travel', 'london'],
    collection: 'Travel',
    extLabel: '.pdf',
    sizeLabel: '620 KB',
    pageLabel: 'p. 1 of 3',
  ),
  MemoryItem(
    id: 'photo-passport',
    type: MemoryType.photo,
    title: 'Passport photo page',
    snippet: 'Detected: passport, MRZ text, expiry 2031.',
    source: 'Camera Roll',
    date: _now.subtract(const Duration(days: 34)),
    tags: const ['travel', 'ids'],
    collection: 'Travel',
    extLabel: '.jpeg',
    matchReason: 'Object detected: passport',
  ),
  MemoryItem(
    id: 'link-london-list',
    type: MemoryType.link,
    title: 'London coffee & bookshops list',
    snippet: 'saved from Safari — 14 places, map view available.',
    source: 'Saved Links',
    date: _now.subtract(const Duration(days: 9)),
    tags: const ['travel', 'london'],
    collection: 'Travel',
  ),
  MemoryItem(
    id: 'cal-doctor',
    type: MemoryType.calendar,
    title: 'Dr. Aksoy — checkup',
    snippet: 'Annual checkup, bring last blood test results.',
    source: 'Calendar',
    date: _now.add(const Duration(days: 6)),
    tags: const ['health'],
    collection: 'Health',
    location: 'Acıbadem Clinic, Floor 3',
    timeLabel: '09:30 – 10:00',
    people: const ['Dr. Aksoy'],
  ),
  MemoryItem(
    id: 'doc-blood-test',
    type: MemoryType.document,
    title: 'Blood test results — June',
    snippet: 'Vitamin D low (18 ng/mL), rest within range.',
    source: 'Files · Scans',
    date: _now.subtract(const Duration(days: 41)),
    tags: const ['health'],
    collection: 'Health',
    extLabel: '.pdf',
    sizeLabel: '340 KB',
  ),
  MemoryItem(
    id: 'shot-rent-payment',
    type: MemoryType.screenshot,
    title: 'Rent transfer confirmation',
    snippet: 'Detected text: "₺24.500 — Ziraat — 1 Aug 09:12 — ref 88214".',
    source: 'Screenshots',
    date: _now.subtract(const Duration(days: 4)),
    tags: const ['payments', 'receipts'],
    collection: 'Receipts',
    extLabel: '.png',
    matchReason: 'Text found in image',
  ),
  MemoryItem(
    id: 'audio-idea-app',
    type: MemoryType.audio,
    title: 'Voice note — onboarding idea',
    snippet:
        'Transcript: "…what if the demo mode seeds fake memories so search feels alive on first run…"',
    source: 'Voice Notes',
    date: _now.subtract(const Duration(days: 6)),
    tags: const ['ideas', 'jara'],
    collection: 'Ideas',
    timeLabel: '0:48',
  ),
  MemoryItem(
    id: 'mail-flight-conf',
    type: MemoryType.email,
    title: 'Turkish Airlines — booking TK1979',
    snippet: 'E-ticket attached. IST → LHR 12 Sep 08:40. PNR: S4K2LM.',
    source: 'Gmail',
    date: _now.subtract(const Duration(days: 13)),
    tags: const ['travel', 'london'],
    people: const ['noreply@thy.com'],
    collection: 'Travel',
  ),
  MemoryItem(
    id: 'chat-jara-palette',
    type: MemoryType.chat,
    title: 'JARA chat — palette decision',
    snippet:
        'You asked about accent colors; settled on electric indigo #5B7CFA with violet gradient for Universal Search.',
    source: 'JARA Chats',
    date: _now.subtract(const Duration(days: 7)),
    tags: const ['jara', 'design'],
    collection: 'Work',
  ),
  MemoryItem(
    id: 'link-flutter-neu',
    type: MemoryType.link,
    title: 'Neumorphism in Flutter — dual shadows',
    snippet: 'saved from Arc — implementation notes for soft UI shadows.',
    source: 'Saved Links',
    date: _now.subtract(const Duration(days: 15)),
    tags: const ['jara', 'design', 'flutter'],
    collection: 'Work',
  ),
  MemoryItem(
    id: 'photo-whiteboard',
    type: MemoryType.photo,
    title: 'Whiteboard — memory architecture',
    snippet: 'Detected text: "capture → enrich → index → recall".',
    source: 'Camera Roll',
    date: _now.subtract(const Duration(days: 10)),
    tags: const ['jara', 'architecture'],
    collection: 'Work',
    extLabel: '.heic',
    matchReason: 'Text found in image',
  ),
  MemoryItem(
    id: 'cal-design-review',
    type: MemoryType.calendar,
    title: 'Design review — Lamplight system',
    snippet: 'Review Horizon layout + tile grid with Azad.',
    source: 'Calendar',
    date: _now.add(const Duration(days: 2)),
    tags: const ['jara', 'design'],
    collection: 'Work',
    location: 'Meet',
    timeLabel: '14:00 – 14:45',
    people: const ['Azad'],
  ),
  MemoryItem(
    id: 'note-grocery-recipe',
    type: MemoryType.note,
    title: 'Karnıyarık recipe',
    snippet: 'Eggplant, ground beef, tomato paste — mom’s proportions.',
    source: 'JARA Notes',
    date: _now.subtract(const Duration(days: 21)),
    tags: const ['family', 'recipes'],
  ),
  MemoryItem(
    id: 'shot-wifi-pass',
    type: MemoryType.screenshot,
    title: 'Office wifi password',
    snippet: 'Detected text: "GUEST-5G / lamp2026!".',
    source: 'Screenshots',
    date: _now.subtract(const Duration(days: 27)),
    tags: const ['work'],
    collection: 'Work',
    extLabel: '.png',
    matchReason: 'Text found in image',
  ),
  MemoryItem(
    id: 'audio-standup',
    type: MemoryType.audio,
    title: 'Voice note — standup summary',
    snippet: 'Transcript: "…ship the horizon scaffold, then the fleet builds screens…"',
    source: 'Voice Notes',
    date: _now.subtract(const Duration(days: 1, hours: 3)),
    tags: const ['work', 'jara'],
    collection: 'Work',
    timeLabel: '1:12',
  ),
];
