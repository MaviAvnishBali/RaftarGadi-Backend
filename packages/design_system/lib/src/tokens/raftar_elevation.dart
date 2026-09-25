import 'package:design_system/src/tokens/raftar_colors.dart';
import 'package:flutter/material.dart';

/// Soft, navy-tinted shadows for a premium light-theme look (avoids the harsh
/// pure-black Material default). Use via the named shadow lists.
abstract final class RaftarElevation {
  static const Color _shadowColor = RaftarColors.navy;

  /// Resting card / tile shadow.
  static const List<BoxShadow> low = [
    BoxShadow(
      color: Color(0x0F1B2A4A),
      blurRadius: 12,
      offset: Offset(0, 4),
    ),
  ];

  /// Raised elements: bottom sheets, menus, floating buttons.
  static const List<BoxShadow> medium = [
    BoxShadow(
      color: Color(0x141B2A4A),
      blurRadius: 20,
      offset: Offset(0, 8),
    ),
  ];

  /// Modal / dialog shadow.
  static const List<BoxShadow> high = [
    BoxShadow(
      color: Color(0x1F1B2A4A),
      blurRadius: 32,
      offset: Offset(0, 12),
    ),
  ];

  static Color get shadowColor => _shadowColor;
}
