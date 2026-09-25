// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Vehicle _$VehicleFromJson(Map<String, dynamic> json) => _Vehicle(
  id: json['id'] as String,
  type: $enumDecode(_$VehicleTypeEnumMap, json['type']),
  registrationNumber: json['registrationNumber'] as String,
  model: json['model'] as String,
  color: json['color'] as String?,
);

Map<String, dynamic> _$VehicleToJson(_Vehicle instance) => <String, dynamic>{
  'id': instance.id,
  'type': _$VehicleTypeEnumMap[instance.type]!,
  'registrationNumber': instance.registrationNumber,
  'model': instance.model,
  'color': instance.color,
};

const _$VehicleTypeEnumMap = {
  VehicleType.bike: 'bike',
  VehicleType.auto: 'auto',
  VehicleType.miniTruck: 'miniTruck',
  VehicleType.truck: 'truck',
};
