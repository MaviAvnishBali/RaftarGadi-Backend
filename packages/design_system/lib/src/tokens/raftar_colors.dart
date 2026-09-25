import 'package:flutter/material.dart';

/// The Raftar Gaddi colour system.
///
/// Brand palette is **blue + neutrals** on a white background, with navy for
/// text (derived from the logo mark). The logo's green is intentionally not a
/// UI colour. Semantic status colours (success/warning/error) are functional
/// signals kept separate from the brand palette — `success` stays green
/// because "delivered/completed" reads as green universally in logistics.
abstract final class RaftarColors {
  // --- Brand ---------------------------------------------------------------
  /// Deep navy from the logo. Primary text colour and dark brand surfaces.
  static const Color navy = Color(0xFF1B2A4A);
  static const Color navyDark = Color(0xFF121D33);

  /// Primary brand blue — buttons, links, headings, active states.
  static const Color primary = Color(0xFF2E7BD6);
  static const Color primaryPressed = Color(0xFF1F5FA8);

  /// Light blue accent — highlights, chips, subtle emphasis.
  static const Color accent = Color(0xFF5BB4E8);

  /// Very light blue tint used for filled containers / selected chips.
  static const Color primaryContainer = Color(0xFFDCEBFB);

  // --- Neutrals ------------------------------------------------------------
  static const Color white = Color(0xFFFFFFFF);

  /// App background and card surface (white theme).
  static const Color background = Color(0xFFFFFFFF);
  static const Color surface = Color(0xFFFFFFFF);

  /// Subtle blue-grey surface for grouped sections and disabled fills.
  static const Color surfaceMuted = Color(0xFFF4F7FB);

  static const Color textPrimary = navy;
  static const Color textSecondary = Color(0xFF5A6B85);
  static const Color textTertiary = Color(0xFF8A97AC);

  static const Color border = Color(0xFFE1E7F0);
  static const Color borderStrong = Color(0xFFC7D0DE);

  // --- Semantic status (functional, not brand) -----------------------------
  static const Color success = Color(0xFF2E9E6B);
  static const Color warning = Color(0xFFE4A33D);
  static const Color error = Color(0xFFD64545);
  static const Color info = primary;

  /// The Material 3 light [ColorScheme] built from the brand palette.
  static const ColorScheme lightScheme = ColorScheme(
    brightness: Brightness.light,
    primary: primary,
    onPrimary: white,
    primaryContainer: primaryContainer,
    onPrimaryContainer: navy,
    secondary: accent,
    onSecondary: navy,
    secondaryContainer: Color(0xFFE6F3FC),
    onSecondaryContainer: navy,
    tertiary: navy,
    onTertiary: white,
    surface: surface,
    onSurface: textPrimary,
    surfaceContainerHighest: surfaceMuted,
    onSurfaceVariant: textSecondary,
    outline: borderStrong,
    outlineVariant: border,
    error: error,
    onError: white,
    errorContainer: Color(0xFFFBE3E3),
    onErrorContainer: Color(0xFF7A1F1F),
    shadow: Color(0x1A1B2A4A),
    scrim: Color(0x801B2A4A),
    inverseSurface: navy,
    onInverseSurface: white,
    inversePrimary: accent,
  );
}
