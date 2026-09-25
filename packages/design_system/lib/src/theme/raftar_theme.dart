import 'package:design_system/src/tokens/raftar_colors.dart';
import 'package:design_system/src/tokens/raftar_spacing.dart';
import 'package:design_system/src/tokens/raftar_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Builds the Raftar Gaddi [ThemeData]. Phase 2 ships the light theme
/// (white background, blue brand, navy text); a dark theme can be added here
/// later behind the same API without touching any screen.
abstract final class RaftarTheme {
  static ThemeData get light {
    const scheme = RaftarColors.lightScheme;

    final base = ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: RaftarColors.background,
      textTheme: RaftarTypography.textTheme,
      splashFactory: InkSparkle.splashFactory,
    );

    return base.copyWith(
      appBarTheme: const AppBarTheme(
        backgroundColor: RaftarColors.background,
        foregroundColor: RaftarColors.textPrimary,
        elevation: 0,
        scrolledUnderElevation: 0.5,
        centerTitle: false,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        titleTextStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: RaftarColors.textPrimary,
        ),
      ),
      cardTheme: CardThemeData(
        color: RaftarColors.surface,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(RaftarRadii.lg),
          side: const BorderSide(color: RaftarColors.border),
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: RaftarColors.border,
        thickness: 1,
        space: 1,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: RaftarColors.primary,
          foregroundColor: RaftarColors.white,
          disabledBackgroundColor: RaftarColors.border,
          minimumSize: const Size.fromHeight(52),
          textStyle: RaftarTypography.textTheme.labelLarge,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(RaftarRadii.md),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: RaftarColors.primary,
          minimumSize: const Size.fromHeight(52),
          side: const BorderSide(color: RaftarColors.primary),
          textStyle: RaftarTypography.textTheme.labelLarge,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(RaftarRadii.md),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: RaftarColors.primary,
          textStyle: RaftarTypography.textTheme.labelLarge,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: RaftarColors.surfaceMuted,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: RaftarSpacing.lg,
          vertical: RaftarSpacing.lg,
        ),
        hintStyle: const TextStyle(color: RaftarColors.textTertiary),
        labelStyle: const TextStyle(color: RaftarColors.textSecondary),
        border: _inputBorder(RaftarColors.border),
        enabledBorder: _inputBorder(RaftarColors.border),
        focusedBorder: _inputBorder(RaftarColors.primary, width: 1.5),
        errorBorder: _inputBorder(RaftarColors.error),
        focusedErrorBorder: _inputBorder(RaftarColors.error, width: 1.5),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: RaftarColors.surfaceMuted,
        selectedColor: RaftarColors.primaryContainer,
        side: const BorderSide(color: RaftarColors.border),
        labelStyle: RaftarTypography.textTheme.labelMedium,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(RaftarRadii.pill),
        ),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: RaftarColors.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(RaftarRadii.xl),
        ),
        titleTextStyle: RaftarTypography.textTheme.headlineSmall,
        contentTextStyle: RaftarTypography.textTheme.bodyLarge,
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: RaftarColors.surface,
        elevation: 0,
        showDragHandle: true,
        dragHandleColor: RaftarColors.borderStrong,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(RaftarRadii.xl),
          ),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: RaftarColors.navy,
        contentTextStyle: const TextStyle(color: RaftarColors.white),
        actionTextColor: RaftarColors.accent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(RaftarRadii.md),
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: RaftarColors.surface,
        selectedItemColor: RaftarColors.primary,
        unselectedItemColor: RaftarColors.textTertiary,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),
    );
  }

  static OutlineInputBorder _inputBorder(Color color, {double width = 1}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(RaftarRadii.md),
      borderSide: BorderSide(color: color, width: width),
    );
  }
}
