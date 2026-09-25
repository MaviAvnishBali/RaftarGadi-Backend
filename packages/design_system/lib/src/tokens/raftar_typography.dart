import 'package:design_system/src/tokens/raftar_colors.dart';
import 'package:flutter/material.dart';

/// The type scale. Uses the platform default family (Roboto/SF) for zero
/// runtime cost and full offline support; swap `fontFamily` here to adopt a
/// bundled brand font later without touching call sites.
abstract final class RaftarTypography {
  static const String? fontFamily = null;

  static const TextTheme textTheme = TextTheme(
    displayLarge: TextStyle(
      fontSize: 40,
      height: 1.1,
      fontWeight: FontWeight.w700,
      color: RaftarColors.textPrimary,
      letterSpacing: -0.5,
    ),
    displayMedium: TextStyle(
      fontSize: 32,
      height: 1.15,
      fontWeight: FontWeight.w700,
      color: RaftarColors.textPrimary,
      letterSpacing: -0.25,
    ),
    headlineLarge: TextStyle(
      fontSize: 28,
      height: 1.2,
      fontWeight: FontWeight.w700,
      color: RaftarColors.textPrimary,
    ),
    headlineMedium: TextStyle(
      fontSize: 24,
      height: 1.25,
      fontWeight: FontWeight.w600,
      color: RaftarColors.textPrimary,
    ),
    headlineSmall: TextStyle(
      fontSize: 20,
      height: 1.3,
      fontWeight: FontWeight.w600,
      color: RaftarColors.textPrimary,
    ),
    titleLarge: TextStyle(
      fontSize: 18,
      height: 1.3,
      fontWeight: FontWeight.w600,
      color: RaftarColors.textPrimary,
    ),
    titleMedium: TextStyle(
      fontSize: 16,
      height: 1.4,
      fontWeight: FontWeight.w600,
      color: RaftarColors.textPrimary,
    ),
    titleSmall: TextStyle(
      fontSize: 14,
      height: 1.4,
      fontWeight: FontWeight.w600,
      color: RaftarColors.textPrimary,
    ),
    bodyLarge: TextStyle(
      fontSize: 16,
      height: 1.5,
      fontWeight: FontWeight.w400,
      color: RaftarColors.textPrimary,
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      height: 1.5,
      fontWeight: FontWeight.w400,
      color: RaftarColors.textSecondary,
    ),
    bodySmall: TextStyle(
      fontSize: 12,
      height: 1.45,
      fontWeight: FontWeight.w400,
      color: RaftarColors.textSecondary,
    ),
    labelLarge: TextStyle(
      fontSize: 14,
      height: 1.2,
      fontWeight: FontWeight.w600,
      color: RaftarColors.textPrimary,
    ),
    labelMedium: TextStyle(
      fontSize: 12,
      height: 1.2,
      fontWeight: FontWeight.w600,
      color: RaftarColors.textSecondary,
    ),
    labelSmall: TextStyle(
      fontSize: 11,
      height: 1.2,
      fontWeight: FontWeight.w500,
      color: RaftarColors.textTertiary,
    ),
  );
}
