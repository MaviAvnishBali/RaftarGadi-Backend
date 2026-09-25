import 'dart:math';

import 'package:shared_models/shared_models.dart';

/// The computed path between two points: what fare estimation and live
/// tracking need. [polyline] is the ordered set of points to draw on a map.
class RouteInfo {
  const RouteInfo({
    required this.distanceKm,
    required this.durationMinutes,
    required this.polyline,
  });

  final double distanceKm;
  final int durationMinutes;
  final List<GeoPoint> polyline;
}

/// Contract for routing/distance. The mock uses straight-line geometry; a real
/// implementation (Google Directions, Mapbox) drops in behind this interface
/// without changing fare estimation or tracking.
abstract interface class RouteService {
  Future<RouteInfo> route({required GeoPoint from, required GeoPoint to});
}

/// Straight-line (haversine) [RouteService]. Assumes an average city speed to
/// derive a duration. Good enough to drive realistic fares and a map preview.
class MockRouteService implements RouteService {
  const MockRouteService({this.averageSpeedKmh = 24});

  final double averageSpeedKmh;

  @override
  Future<RouteInfo> route({
    required GeoPoint from,
    required GeoPoint to,
  }) async {
    final km = _haversineKm(from, to);
    final minutes = max(1, (km / averageSpeedKmh * 60).round());
    return RouteInfo(
      distanceKm: double.parse(km.toStringAsFixed(2)),
      durationMinutes: minutes,
      polyline: [from, to],
    );
  }

  static double _haversineKm(GeoPoint a, GeoPoint b) {
    const earthRadiusKm = 6371.0;
    final dLat = _toRad(b.latitude - a.latitude);
    final dLng = _toRad(b.longitude - a.longitude);
    final lat1 = _toRad(a.latitude);
    final lat2 = _toRad(b.latitude);

    final h =
        sin(dLat / 2) * sin(dLat / 2) +
        sin(dLng / 2) * sin(dLng / 2) * cos(lat1) * cos(lat2);
    return earthRadiusKm * 2 * asin(min(1, sqrt(h)));
  }

  static double _toRad(double deg) => deg * pi / 180;
}
