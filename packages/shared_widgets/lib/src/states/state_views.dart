import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

/// Centered loading spinner with an optional caption.
class RaftarLoadingView extends StatelessWidget {
  const RaftarLoadingView({this.message, super.key});

  final String? message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator(color: RaftarColors.primary),
          if (message != null) ...[
            const SizedBox(height: RaftarSpacing.lg),
            Text(message!, style: Theme.of(context).textTheme.bodyMedium),
          ],
        ],
      ),
    );
  }
}

/// Friendly empty-state with an icon, title, and optional action.
class RaftarEmptyView extends StatelessWidget {
  const RaftarEmptyView({
    required this.title,
    this.message,
    this.icon = Icons.inbox_rounded,
    this.actionLabel,
    this.onAction,
    super.key,
  });

  final String title;
  final String? message;
  final IconData icon;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(RaftarSpacing.xxl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 56, color: RaftarColors.textTertiary),
            const SizedBox(height: RaftarSpacing.lg),
            Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            if (message != null) ...[
              const SizedBox(height: RaftarSpacing.sm),
              Text(
                message!,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
            if (actionLabel != null) ...[
              const SizedBox(height: RaftarSpacing.xl),
              RaftarButton(
                label: actionLabel!,
                expand: false,
                onPressed: onAction,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Error state that renders a [Failure] in human terms with a retry action.
class RaftarErrorView extends StatelessWidget {
  const RaftarErrorView({
    required this.failure,
    this.onRetry,
    super.key,
  });

  final Failure failure;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return RaftarEmptyView(
      icon: Icons.error_outline_rounded,
      title: 'Something went wrong',
      message: failure.message,
      actionLabel: onRetry == null ? null : 'Try again',
      onAction: onRetry,
    );
  }
}
