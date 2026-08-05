import 'package:flutter/material.dart';

import '../design/tokens.dart';

enum MemoryType {
  document,
  photo,
  screenshot,
  note,
  link,
  audio,
  calendar,
  email,
  chat;

  Color get color => switch (this) {
        document => JaraPalette.srcDocument,
        photo => JaraPalette.srcPhoto,
        screenshot => JaraPalette.srcScreenshot,
        note => JaraPalette.srcNote,
        link => JaraPalette.srcLink,
        audio => JaraPalette.srcAudio,
        calendar => JaraPalette.srcCalendar,
        email => JaraPalette.srcEmail,
        chat => JaraPalette.srcChat,
      };

  IconData get icon => switch (this) {
        document => Icons.description_outlined,
        photo => Icons.image_outlined,
        screenshot => Icons.screenshot_outlined,
        note => Icons.sticky_note_2_outlined,
        link => Icons.link_rounded,
        audio => Icons.graphic_eq_rounded,
        calendar => Icons.event_outlined,
        email => Icons.mail_outline_rounded,
        chat => Icons.chat_bubble_outline_rounded,
      };
}

class MemoryItem {
  const MemoryItem({
    required this.id,
    required this.type,
    required this.title,
    required this.snippet,
    required this.source,
    required this.date,
    this.tags = const [],
    this.people = const [],
    this.collection,
    this.extLabel,
    this.sizeLabel,
    this.pageLabel,
    this.location,
    this.timeLabel,
    this.matchReason,
    this.pinned = false,
  });

  final String id;
  final MemoryType type;
  final String title;
  final String snippet;

  /// Human origin, e.g. "Files · Dropbox", "Camera Roll", "Gmail".
  final String source;
  final DateTime date;
  final List<String> tags;
  final List<String> people;
  final String? collection;

  /// ".pdf", ".png" — shown as tiny metadata like the reference tiles.
  final String? extLabel;
  final String? sizeLabel;
  final String? pageLabel;
  final String? location;
  final String? timeLabel;

  /// Why this matched ("Text found in image").
  final String? matchReason;
  final bool pinned;

  MemoryItem copyWith({bool? pinned}) => MemoryItem(
        id: id,
        type: type,
        title: title,
        snippet: snippet,
        source: source,
        date: date,
        tags: tags,
        people: people,
        collection: collection,
        extLabel: extLabel,
        sizeLabel: sizeLabel,
        pageLabel: pageLabel,
        location: location,
        timeLabel: timeLabel,
        matchReason: matchReason,
        pinned: pinned ?? this.pinned,
      );
}

class MemoryCollection {
  const MemoryCollection({
    required this.id,
    required this.name,
    required this.itemCount,
    required this.updated,
    required this.color,
    required this.types,
  });

  final String id;
  final String name;
  final int itemCount;
  final DateTime updated;
  final Color color;
  final List<MemoryType> types;
}

enum SuggestionKind { history, completion, person, project, file, date, type }

class SearchSuggestion {
  const SearchSuggestion({
    required this.kind,
    required this.text,
    this.subtitle,
    this.type,
  });

  final SuggestionKind kind;
  final String text;
  final String? subtitle;
  final MemoryType? type;
}

class SmartSummary {
  const SmartSummary({
    required this.text,
    required this.sourceIds,
  });

  final String text;
  final List<String> sourceIds;
  int get sourceCount => sourceIds.length;
}

class SearchOutcome {
  const SearchOutcome({
    required this.query,
    required this.items,
    required this.elapsed,
    this.summary,
  });

  final String query;
  final List<MemoryItem> items;
  final Duration elapsed;
  final SmartSummary? summary;

  Map<MemoryType, List<MemoryItem>> get grouped {
    final map = <MemoryType, List<MemoryItem>>{};
    for (final item in items) {
      map.putIfAbsent(item.type, () => []).add(item);
    }
    return map;
  }
}

enum ConnectionStatus { connected, syncing, disconnected, attention }

class ConnectionInfo {
  const ConnectionInfo({
    required this.id,
    required this.name,
    required this.icon,
    required this.status,
    this.lastSync,
    this.permissionLabel,
    this.itemCount = 0,
  });

  final String id;
  final String name;
  final IconData icon;
  final ConnectionStatus status;
  final DateTime? lastSync;
  final String? permissionLabel;
  final int itemCount;
}

class MemoryStats {
  const MemoryStats({
    required this.totalItems,
    required this.collections,
    required this.addedThisWeek,
    required this.indexedSources,
    required this.storageUsedLabel,
    required this.storageFreeLabel,
    required this.indexedFraction,
    required this.lastIndexed,
  });

  final int totalItems;
  final int collections;
  final int addedThisWeek;
  final int indexedSources;
  final String storageUsedLabel;
  final String storageFreeLabel;
  final double indexedFraction;
  final DateTime lastIndexed;
}
