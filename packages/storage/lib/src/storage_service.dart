import 'package:hive_ce/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:storage/src/box_names.dart';
import 'package:storage/src/key_value_store.dart';

/// Owns Hive's lifecycle: initialisation, box opening, and a typed
/// [KeyValueStore] per box. Constructed once at app startup and injected via
/// Riverpod (the app's composition root overrides the provider with the
/// initialised instance).
class StorageService {
  StorageService._(this._boxes);

  final Map<String, Box<dynamic>> _boxes;

  /// Initialises Hive in the platform's documents directory and opens every
  /// box in [BoxNames.all]. Call once before `runApp`.
  static Future<StorageService> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    Hive.init('${dir.path}/raftar');

    final boxes = <String, Box<dynamic>>{};
    for (final name in BoxNames.all) {
      boxes[name] = await Hive.openBox<dynamic>(name);
    }
    return StorageService._(boxes);
  }

  /// A store scoped to one box. Defaults to the general cache box.
  KeyValueStore store([String box = BoxNames.cache]) {
    final target = _boxes[box];
    if (target == null) {
      throw StateError('Box "$box" was not opened. Add it to BoxNames.all.');
    }
    return HiveKeyValueStore(target);
  }

  Future<void> dispose() => Hive.close();
}
