import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared_models/src/common/geo_point.dart';

part 'address.freezed.dart';
part 'address.g.dart';

/// How a saved address is categorised in the UI.
enum AddressLabel { home, work, other }

/// A pickup or drop-off location, optionally saved to the customer's book.
@freezed
abstract class Address with _$Address {
  const factory Address({
    required String id,
    required AddressLabel label,
    required String title,
    required String formattedAddress,
    required GeoPoint location,
    String? contactName,
    String? contactPhone,
  }) = _Address;

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);
}
