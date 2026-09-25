import 'package:design_system/src/components/raftar_feedback.dart';
import 'package:design_system/src/tokens/raftar_colors.dart';
import 'package:design_system/src/tokens/raftar_spacing.dart';
import 'package:design_system/src/tokens/raftar_typography.dart';
import 'package:flutter/material.dart';

/// A small pill label used for statuses (booking state, driver online, etc.).
/// Tints itself from a [RaftarStatus] so status colour usage stays consistent.
class RaftarBadge extends StatelessWidget {
  const RaftarBadge({
    required this.label,
    this.status = RaftarStatus.info,
    super.key,
  });

  /// Convenience for a neutral, brand-tinted badge.
  const RaftarBadge.neutral({required this.label, super.key})
    : status = RaftarStatus.info;

  final String label;
  final RaftarStatus status;

  @override
  Widget build(BuildContext context) {
    final color = switch (status) {
      RaftarStatus.success => RaftarColors.success,
      RaftarStatus.warning => RaftarColors.warning,
      RaftarStatus.error => RaftarColors.error,
      RaftarStatus.info => RaftarColors.primary,
    };

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: RaftarSpacing.md,
        vertical: RaftarSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(RaftarRadii.pill),
      ),
      child: Text(
        label,
        style: RaftarTypography.textTheme.labelSmall?.copyWith(
          color: color,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
