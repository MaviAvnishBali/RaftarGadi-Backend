import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_widgets/src/states/state_views.dart';

/// Renders a Riverpod [AsyncValue] into the standard loading / error / data
/// states so every screen handles async the same way. Errors are surfaced as
/// [Failure]s (falling back to [UnknownFailure] for non-domain errors).
class AsyncValueView<T> extends StatelessWidget {
  const AsyncValueView({
    required this.value,
    required this.data,
    this.onRetry,
    this.loadingMessage,
    super.key,
  });

  final AsyncValue<T> value;
  final Widget Function(T data) data;
  final VoidCallback? onRetry;
  final String? loadingMessage;

  @override
  Widget build(BuildContext context) {
    return value.when(
      skipLoadingOnReload: true,
      skipLoadingOnRefresh: false,
      data: data,
      loading: () => RaftarLoadingView(message: loadingMessage),
      error: (error, _) {
        final failure = error is Failure
            ? error
            : UnknownFailure(error.toString(), error);
        return RaftarErrorView(failure: failure, onRetry: onRetry);
      },
    );
  }
}
