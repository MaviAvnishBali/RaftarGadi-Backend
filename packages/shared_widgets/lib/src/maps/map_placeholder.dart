import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

/// A styled stand-in for the live map used in tracking screens. Until a Google
/// Maps API key is wired in, this renders a branded placeholder with optional
/// pickup/drop labels, so tracking UIs can be built and demoed now. Swap this
/// widget for a real `GoogleMap` later — the surrounding layout is unaffected.
class MapPlaceholder extends StatelessWidget {
  const MapPlaceholder({
    this.pickupLabel,
    this.dropLabel,
    this.height,
    super.key,
  });

  final String? pickupLabel;
  final String? dropLabel;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [RaftarColors.surfaceMuted, RaftarColors.primaryContainer],
        ),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          const _GridPainterBox(),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.map_rounded,
                  size: 48,
                  color: RaftarColors.primary,
                ),
                const SizedBox(height: RaftarSpacing.sm),
                Text(
                  'Live map',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ],
            ),
          ),
          if (pickupLabel != null)
            Positioned(
              left: RaftarSpacing.lg,
              top: RaftarSpacing.lg,
              child: _Pin(
                label: pickupLabel!,
                color: RaftarColors.primary,
                icon: Icons.trip_origin_rounded,
              ),
            ),
          if (dropLabel != null)
            Positioned(
              right: RaftarSpacing.lg,
              bottom: RaftarSpacing.lg,
              child: _Pin(
                label: dropLabel!,
                color: RaftarColors.navy,
                icon: Icons.location_on_rounded,
              ),
            ),
        ],
      ),
    );
  }
}

class _GridPainterBox extends StatelessWidget {
  const _GridPainterBox();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(painter: _GridPainter(), child: const SizedBox.expand());
  }
}

class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = RaftarColors.border
      ..strokeWidth = 1;
    const step = 40.0;
    for (var x = 0.0; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (var y = 0.0; y < size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _Pin extends StatelessWidget {
  const _Pin({required this.label, required this.color, required this.icon});

  final String label;
  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: RaftarSpacing.md,
        vertical: RaftarSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: RaftarColors.surface,
        borderRadius: BorderRadius.circular(RaftarRadii.pill),
        boxShadow: RaftarElevation.low,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: RaftarSpacing.xs),
          Text(label, style: Theme.of(context).textTheme.labelSmall),
        ],
      ),
    );
  }
}
