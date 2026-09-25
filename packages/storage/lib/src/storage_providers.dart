import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:storage/src/key_value_store.dart';
import 'package:storage/src/storage_service.dart';

/// Holds the initialised [StorageService]. The default throws: each app must
/// override it in its `ProviderScope` with the instance returned by
/// `StorageService.initialize()` during bootstrap.
final storageServiceProvider = Provider<StorageService>(
  (ref) => throw UnimplementedError(
    'Override storageServiceProvider in the app bootstrap after '
    'StorageService.initialize().',
  ),
);

/// The general-purpose cache store, derived from [storageServiceProvider].
final cacheStoreProvider = Provider<KeyValueStore>(
  (ref) => ref.watch(storageServiceProvider).store(),
);
