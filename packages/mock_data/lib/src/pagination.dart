import 'dart:math';

import 'package:core/core.dart';

/// Turns an in-memory list into a paginated + searched JSON envelope matching
/// `PaginatedResponse`. Reads `page`, `pageSize`, and `q` from the request
/// query, so the mock exercises the exact same pagination/search contract the
/// real API will.
Json paginate<T>(
  List<T> items,
  Query? query, {
  required Json Function(T item) toJson,
  bool Function(T item, String query)? matches,
}) {
  final page = _readInt(query?['page'], fallback: 1);
  final pageSize = _readInt(query?['pageSize'], fallback: 20);
  final search = (query?['q'] as String?)?.trim().toLowerCase();

  var filtered = items;
  if (search != null && search.isNotEmpty && matches != null) {
    filtered = items.where((item) => matches(item, search)).toList();
  }

  final start = (page - 1) * pageSize;
  final pageItems = start >= filtered.length
      ? <T>[]
      : filtered.sublist(start, min(start + pageSize, filtered.length));

  return {
    'items': pageItems.map(toJson).toList(),
    'page': page,
    'pageSize': pageSize,
    'total': filtered.length,
  };
}

int _readInt(Object? value, {required int fallback}) {
  if (value is int) return value;
  if (value is String) return int.tryParse(value) ?? fallback;
  return fallback;
}
