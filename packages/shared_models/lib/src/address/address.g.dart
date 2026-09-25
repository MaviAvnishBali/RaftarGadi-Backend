// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Address _$AddressFromJson(Map<String, dynamic> json) => _Address(
  id: json['id'] as String,
  label: $enumDecode(_$AddressLabelEnumMap, json['label']),
  title: json['title'] as String,
  formattedAddress: json['formattedAddress'] as String,
  location: GeoPoint.fromJson(json['location'] as Map<String, dynamic>),
  contactName: json['contactName'] as String?,
  contactPhone: json['contactPhone'] as String?,
);

Map<String, dynamic> _$AddressToJson(_Address instance) => <String, dynamic>{
  'id': instance.id,
  'label': _$AddressLabelEnumMap[instance.label]!,
  'title': instance.title,
  'formattedAddress': instance.formattedAddress,
  'location': instance.location.toJson(),
  'contactName': instance.contactName,
  'contactPhone': instance.contactPhone,
};

const _$AddressLabelEnumMap = {
  AddressLabel.home: 'home',
  AddressLabel.work: 'work',
  AddressLabel.other: 'other',
};
