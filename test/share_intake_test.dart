import 'package:flutter_test/flutter_test.dart';
import 'package:jara_universal_search/core/data/share_intake.dart';

/// Pure decode tests for the platform contract — the one place where
/// untrusted input from other apps enters JARA.
void main() {
  test('decodes the v2 contract, subject included', () {
    final p = SharedPayload.fromMap({
      'type': 'url',
      'value': 'https://voxbridge.app/pricing',
      'extras': <Object?>[],
      'subject': 'VoxBridge — Pricing',
    });
    expect(p, isNotNull);
    expect(p!.type, SharedPayloadType.url);
    expect(p.subject, 'VoxBridge — Pricing');
    expect(p.suggestedTitle, 'VoxBridge — Pricing');
  });

  test('subject is optional and blank subjects are dropped', () {
    final without = SharedPayload.fromMap({
      'type': 'url',
      'value': 'https://voxbridge.app/pricing',
      'extras': <Object?>[],
    });
    expect(without!.subject, isNull);
    expect(without.suggestedTitle, 'voxbridge.app/pricing');

    final blank = SharedPayload.fromMap({
      'type': 'text',
      'value': 'call the clinic tomorrow',
      'extras': <Object?>[],
      'subject': '   ',
    });
    expect(blank!.subject, isNull);
  });

  test('subject titles an image share that had no derivable title', () {
    final p = SharedPayload.fromMap({
      'type': 'image',
      'value': 'content://media/1',
      'extras': ['content://media/2'],
      'subject': 'Istanbul weekend',
    });
    expect(p!.itemCount, 2);
    expect(p.suggestedTitle, 'Istanbul weekend');
  });

  test('malformed input is dropped, never thrown', () {
    expect(SharedPayload.fromMap(null), isNull);
    expect(SharedPayload.fromMap({'type': 'video', 'value': 'x'}), isNull);
    expect(SharedPayload.fromMap({'type': 'url', 'value': '  '}), isNull);
    expect(
      SharedPayload.fromMap({'type': 'url', 'value': 42, 'subject': 7}),
      isNull,
    );
  });
}
