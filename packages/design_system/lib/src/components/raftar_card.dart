import 'package:design_system/src/tokens/raftar_colors.dart';
import 'package:design_system/src/tokens/raftar_elevation.dart';
import 'package:design_system/src/tokens/raftar_spacing.dart';
import 'package:flutter/material.dart';

/// A padded, rounded surface with a soft brand shadow. Optionally tappable.
/// Preferred over raw [Card] so spacing, radius, and elevation stay uniform.
class RaftarCard extends StatelessWidget {
  const RaftarCard({
    required this.child,
    this.onTap,
    this.padding = const EdgeInsets.all(RaftarSpacing.lg),
    this.elevated = true,
    super.key,
  });

  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;

  /// When true, applies the resting shadow; when false, a flat bordered card.
  final bool elevated;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(RaftarRadii.lg);
    final decorated = Container(
      decoration: BoxDecoration(
        color: RaftarColors.surface,
        borderRadius: radius,
        border: Border.all(color: RaftarColors.border),
        boxShadow: elevated ? RaftarElevation.low : null,
      ),
      padding: padding,
      child: child,
    );

    if (onTap == null) return decorated;
    return Material(
      color: Colors.transparent,
      borderRadius: radius,
      child: InkWell(
        onTap: onTap,
        borderRadius: radius,
        child: decorated,
      ),
    );
  }
}
