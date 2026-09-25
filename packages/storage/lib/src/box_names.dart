/// Canonical Hive box names. Centralised so no two features silently collide
/// on the same box, and so clearing state on logout is a known list.
abstract final class BoxNames {
  static const String cache = 'raftar_cache';
  static const String session = 'raftar_session';
  static const String preferences = 'raftar_preferences';

  static const List<String> all = [cache, session, preferences];
}
