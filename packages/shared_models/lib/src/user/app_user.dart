import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_user.freezed.dart';
part 'app_user.g.dart';

/// An authenticated customer of the platform.
@freezed
abstract class AppUser with _$AppUser {
  const factory AppUser({
    required String id,
    required String fullName,
    required String phone,
    String? email,
    String? avatarUrl,
    @Default(<String>[]) List<String> savedAddressIds,
    @Default(false) bool isPhoneVerified,
    DateTime? createdAt,
  }) = _AppUser;

  factory AppUser.fromJson(Map<String, dynamic> json) =>
      _$AppUserFromJson(json);
}
