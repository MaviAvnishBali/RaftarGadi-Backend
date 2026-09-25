import 'package:design_system/src/tokens/raftar_colors.dart';
import 'package:design_system/src/tokens/raftar_spacing.dart';
import 'package:design_system/src/tokens/raftar_typography.dart';
import 'package:flutter/material.dart';

/// A labelled text field with consistent styling and an optional leading icon.
/// Uses the themed [InputDecorationTheme], adding only the label row above.
class RaftarTextField extends StatelessWidget {
  const RaftarTextField({
    required this.label,
    this.controller,
    this.hint,
    this.prefixIcon,
    this.keyboardType,
    this.obscureText = false,
    this.errorText,
    this.onChanged,
    this.textInputAction,
    super.key,
  });

  final String label;
  final TextEditingController? controller;
  final String? hint;
  final IconData? prefixIcon;
  final TextInputType? keyboardType;
  final bool obscureText;
  final String? errorText;
  final ValueChanged<String>? onChanged;
  final TextInputAction? textInputAction;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: RaftarTypography.textTheme.labelMedium),
        const SizedBox(height: RaftarSpacing.sm),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscureText,
          onChanged: onChanged,
          textInputAction: textInputAction,
          style: RaftarTypography.textTheme.bodyLarge,
          decoration: InputDecoration(
            hintText: hint,
            errorText: errorText,
            prefixIcon: prefixIcon == null
                ? null
                : Icon(prefixIcon, color: RaftarColors.textTertiary),
          ),
        ),
      ],
    );
  }
}
