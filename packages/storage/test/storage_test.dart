import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive_ce/hive.dart';
import 'package:storage/storage.dart';

void main() {
  late Directory dir;

  setUp(() async {
    dir = await Directory.systemTemp.createTemp('raftar_storage_test');
    Hive.init(dir.path);
  });

  tearDown(() async {
    await Hive.deleteFromDisk();
    if (dir.existsSync()) await dir.delete(recursive: true);
  });

  test('HiveKeyValueStore round-trips and deletes values', () async {
    final box = await Hive.openBox<dynamic>('t');
    final store = HiveKeyValueStore(box);

    await store.write('answer', 42);
    expect(store.read<int>('answer'), 42);
    expect(store.containsKey('answer'), isTrue);
    expect(store.keys, contains('answer'));

    await store.delete('answer');
    expect(store.read<int>('answer'), isNull);
    expect(store.containsKey('answer'), isFalse);
  });
}
