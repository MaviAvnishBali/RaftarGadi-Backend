import 'package:flutter/material.dart';

/// Reusable route transition builders. Designed to be passed straight to
/// GoRouter's `CustomTransitionPage.transitionsBuilder` (or any
/// [PageRouteBuilder]) so navigation feels consistent across the apps without
/// coupling this package to a router.
abstract final class RaftarPageTransitions {
  /// A subtle slide-up combined with a fade — the default screen push.
  static Widget slideFade(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    final curved = CurvedAnimation(
      parent: animation,
      curve: Curves.easeOutCubic,
      reverseCurve: Curves.easeInCubic,
    );
    return FadeTransition(
      opacity: curved,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0.03),
          end: Offset.zero,
        ).animate(curved),
        child: child,
      ),
    );
  }

  /// A plain cross-fade, for tab/root switches where motion should be minimal.
  static Widget fade(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return FadeTransition(opacity: animation, child: child);
  }
}
