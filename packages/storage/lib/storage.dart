/// Raftar Gaddi — `storage` package.
///
/// Local persistence for offline support and session state, backed by Hive CE
/// behind a `KeyValueStore` abstraction so the engine stays swappable.
library;

export 'src/box_names.dart';
export 'src/key_value_store.dart';
export 'src/storage_providers.dart';
export 'src/storage_service.dart';
