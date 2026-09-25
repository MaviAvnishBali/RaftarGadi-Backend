import 'package:design_system/src/tokens/raftar_colors.dart';
import 'package:flutter/material.dart';

/// Visual weight of a [RaftarButton].
enum RaftarButtonVariant { primary, secondary, text }

/// The app's standard button. Wraps Material buttons so every screen gets the
/// same sizing, loading behaviour, and optional leading icon for free.
class RaftarButton extends StatelessWidget {
  const RaftarButton({
    required this.label,
    required this.onPressed,
    this.variant = RaftarButtonVariant.primary,
    this.icon,
    this.isLoading = false,
    this.expand = true,
    super.key,
  });

  final String label;

  /// Null disables the button. Ignored while [isLoading].
  final VoidCallback? onPressed;
  final RaftarButtonVariant variant;
  final IconData? icon;
  final bool isLoading;

  /// Whether the button fills the available width.
  final bool expand;

  @override
  Widget build(BuildContext context) {
    final effectiveOnPressed = isLoading ? null : onPressed;
    final child = isLoading
        ? const _ButtonSpinner()
        : _ButtonContent(label: label, icon: icon);

    final button = switch (variant) {
      RaftarButtonVariant.primary => FilledButton(
        onPressed: effectiveOnPressed,
        child: child,
      ),
      RaftarButtonVariant.secondary => OutlinedButton(
        onPressed: effectiveOnPressed,
        child: child,
      ),
      RaftarButtonVariant.text => TextButton(
        onPressed: effectiveOnPressed,
        child: child,
      ),
    };

    return expand ? SizedBox(width: double.infinity, child: button) : button;
  }
}

class _ButtonContent extends StatelessWidget {
  const _ButtonContent({required this.label, this.icon});

  final String label;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    if (icon == null) return Text(label);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 20),
        const SizedBox(width: 8),
        Text(label),
      ],
    );
  }
}

class _ButtonSpinner extends StatelessWidget {
  const _ButtonSpinner();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 20,
      width: 20,
      child: CircularProgressIndicator(
        strokeWidth: 2.5,
        valueColor: AlwaysStoppedAnimation(RaftarColors.white),
      ),
    );
  }
}
