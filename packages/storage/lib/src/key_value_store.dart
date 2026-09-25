import 'package:hive_ce/hive.dart';

/// A minimal persistence contract the data layer depends on for offline
/// caching and local session state. Repositories use this instead of Hive
/// directly, so the storage engine can be swapped (Hive -> Isar/Drift) without
/// touching a single repository.
abstract interface class KeyValueStore {
  T? read<T>(String key);

  Future<void> write<T>(String key, T value);

  Future<void> delete(String key);

  Future<void> clear();

  bool containsKey(String key);

  List<String> get keys;
}

/// Hive CE-backed [KeyValueStore] bound to a single already-open [Box].
class HiveKeyValueStore implements KeyValueStore {
  HiveKeyValueStore(this._box);

  final Box<dynamic> _box;

  @override
  T? read<T>(String key) => _box.get(key) as T?;

  @override
  Future<void> write<T>(String key, T value) => _box.put(key, value);

  @override
  Future<void> delete(String key) => _box.delete(key);

  @override
  Future<void> clear() => _box.clear();

  @override
  bool containsKey(String key) => _box.containsKey(key);

  @override
  List<String> get keys => _box.keys.cast<String>().toList();
}
