// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AppUser _$AppUserFromJson(Map<String, dynamic> json) => _AppUser(
  id: json['id'] as String,
  fullName: json['fullName'] as String,
  phone: json['phone'] as String,
  email: json['email'] as String?,
  avatarUrl: json['avatarUrl'] as String?,
  savedAddressIds:
      (json['savedAddressIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const <String>[],
  isPhoneVerified: json['isPhoneVerified'] as bool? ?? false,
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$AppUserToJson(_AppUser instance) => <String, dynamic>{
  'id': instance.id,
  'fullName': instance.fullName,
  'phone': instance.phone,
  'email': instance.email,
  'avatarUrl': instance.avatarUrl,
  'savedAddressIds': instance.savedAddressIds,
  'isPhoneVerified': instance.isPhoneVerified,
  'createdAt': instance.createdAt?.toIso8601String(),
};
