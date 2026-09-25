import 'package:meta/meta.dart';

/// A page of results plus the cursor metadata a list UI needs to page and
/// know when to stop. The mock API and a future real API share this shape, so
/// pagination logic in the UI never changes when the backend arrives.
@immutable
class PaginatedResponse<T> {
  const PaginatedResponse({
    required this.items,
    required this.page,
    required this.pageSize,
    required this.total,
  });

  factory PaginatedResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) {
    return PaginatedResponse<T>(
      items: (json['items'] as List<dynamic>).map(fromJsonT).toList(),
      page: json['page'] as int,
      pageSize: json['pageSize'] as int,
      total: json['total'] as int,
    );
  }

  final List<T> items;
  final int page;
  final int pageSize;
  final int total;

  /// Whether another page exists after this one.
  bool get hasMore => page * pageSize < total;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PaginatedResponse<T> &&
          _listEquals(other.items, items) &&
          other.page == page &&
          other.pageSize == pageSize &&
          other.total == total;

  @override
  int get hashCode => Object.hash(Object.hashAll(items), page, pageSize, total);
}

bool _listEquals<E>(List<E> a, List<E> b) {
  if (a.length != b.length) return false;
  for (var i = 0; i < a.length; i++) {
    if (a[i] != b[i]) return false;
  }
  return true;
}
