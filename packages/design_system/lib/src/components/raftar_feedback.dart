import 'package:design_system/src/components/raftar_button.dart';
import 'package:design_system/src/tokens/raftar_colors.dart';
import 'package:design_system/src/tokens/raftar_spacing.dart';
import 'package:design_system/src/tokens/raftar_typography.dart';
import 'package:flutter/material.dart';

/// Status intent for a snackbar, mapped to a colour and icon.
enum RaftarStatus { success, warning, error, info }

extension _StatusStyle on RaftarStatus {
  Color get color => switch (this) {
    RaftarStatus.success => RaftarColors.success,
    RaftarStatus.warning => RaftarColors.warning,
    RaftarStatus.error => RaftarColors.error,
    RaftarStatus.info => RaftarColors.primary,
  };

  IconData get icon => switch (this) {
    RaftarStatus.success => Icons.check_circle_rounded,
    RaftarStatus.warning => Icons.warning_rounded,
    RaftarStatus.error => Icons.error_rounded,
    RaftarStatus.info => Icons.info_rounded,
  };
}

/// Snackbars, confirm dialogs, and bottom sheets in one place so feedback is
/// consistent everywhere. Static helpers keep call sites tidy.
abstract final class RaftarFeedback {
  /// Shows a floating status snackbar.
  static void showSnackbar(
    BuildContext context, {
    required String message,
    RaftarStatus status = RaftarStatus.info,
  }) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(status.icon, color: status.color, size: 20),
              const SizedBox(width: RaftarSpacing.md),
              Expanded(child: Text(message)),
            ],
          ),
        ),
      );
  }

  /// Shows a confirm/cancel dialog. Resolves to true when confirmed.
  static Future<bool> confirm(
    BuildContext context, {
    required String title,
    required String message,
    String confirmLabel = 'Confirm',
    String cancelLabel = 'Cancel',
    bool destructive = false,
  }) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(cancelLabel),
          ),
          FilledButton(
            style: destructive
                ? FilledButton.styleFrom(backgroundColor: RaftarColors.error)
                : null,
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(confirmLabel),
          ),
        ],
      ),
    );
    return result ?? false;
  }

  /// Shows a themed modal bottom sheet with a title and content.
  static Future<T?> showSheet<T>(
    BuildContext context, {
    required String title,
    required Widget child,
    String? primaryLabel,
    VoidCallback? onPrimary,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          left: RaftarSpacing.lg,
          right: RaftarSpacing.lg,
          top: RaftarSpacing.sm,
          bottom: MediaQuery.of(context).viewInsets.bottom + RaftarSpacing.xl,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: RaftarTypography.textTheme.headlineSmall),
            const SizedBox(height: RaftarSpacing.lg),
            child,
            if (primaryLabel != null) ...[
              const SizedBox(height: RaftarSpacing.xl),
              RaftarButton(label: primaryLabel, onPressed: onPrimary),
            ],
          ],
        ),
      ),
    );
  }
}
