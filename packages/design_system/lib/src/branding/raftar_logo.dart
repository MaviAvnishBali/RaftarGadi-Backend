import 'package:design_system/src/tokens/raftar_colors.dart';
import 'package:design_system/src/tokens/raftar_spacing.dart';
import 'package:flutter/material.dart';

/// The Raftar Gaddi logo, bundled in `design_system` so every app renders the
/// exact same mark. The source art sits on the brand navy, so [onNavyPanel]
/// wraps it in a rounded navy card for use on the white app background.
class RaftarLogo extends StatelessWidget {
  const RaftarLogo({
    this.height = 96,
    this.onNavyPanel = true,
    super.key,
  });

  final double height;

  /// Whether to place the logo on a rounded navy panel (recommended on the
  /// white theme). When false the raw image is shown.
  final bool onNavyPanel;

  static const String _asset = 'assets/logo/raftar_logo.png';
  static const String _package = 'design_system';

  @override
  Widget build(BuildContext context) {
    final image = Image.asset(
      _asset,
      package: _package,
      height: height,
      fit: BoxFit.contain,
      semanticLabel: 'Raftar Gaddi',
      errorBuilder: (context, error, stackTrace) => _Wordmark(height: height),
    );

    if (!onNavyPanel) return image;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: RaftarSpacing.xl,
        vertical: RaftarSpacing.lg,
      ),
      decoration: BoxDecoration(
        color: RaftarColors.navy,
        borderRadius: BorderRadius.circular(RaftarRadii.xl),
      ),
      child: image,
    );
  }
}

class _Wordmark extends StatelessWidget {
  const _Wordmark({required this.height});

  final double height;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Raftar Gaddi',
      child: SizedBox(
        height: height,
        child: FittedBox(
          child: Text(
            'Raftar\nGaddi',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: RaftarColors.white,
              fontWeight: FontWeight.w800,
              height: 0.9,
            ),
          ),
        ),
      ),
    );
  }
}
