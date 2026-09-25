import 'package:flutter/widgets.dart';

/// Device size class derived from the available width.
enum FormFactor { mobile, tablet, desktop }

/// Layout breakpoints (logical pixels). Shared so all three apps — especially
/// the responsive admin dashboard — agree on where layouts change.
abstract final class Breakpoints {
  static const double tablet = 600;
  static const double desktop = 1024;

  static FormFactor of(double width) {
    if (width >= desktop) return FormFactor.desktop;
    if (width >= tablet) return FormFactor.tablet;
    return FormFactor.mobile;
  }
}

/// Convenience access to the current [FormFactor] from a [BuildContext].
extension ResponsiveContext on BuildContext {
  FormFactor get formFactor => Breakpoints.of(MediaQuery.sizeOf(this).width);

  bool get isMobile => formFactor == FormFactor.mobile;
  bool get isTablet => formFactor == FormFactor.tablet;
  bool get isDesktop => formFactor == FormFactor.desktop;
  bool get isWide => formFactor != FormFactor.mobile;
}

/// Builds a different widget per [FormFactor]. [tablet] and [desktop] fall
/// back to the next-smaller layout when omitted.
class ResponsiveBuilder extends StatelessWidget {
  const ResponsiveBuilder({
    required this.mobile,
    this.tablet,
    this.desktop,
    super.key,
  });

  final WidgetBuilder mobile;
  final WidgetBuilder? tablet;
  final WidgetBuilder? desktop;

  @override
  Widget build(BuildContext context) {
    return switch (context.formFactor) {
      FormFactor.desktop => (desktop ?? tablet ?? mobile)(context),
      FormFactor.tablet => (tablet ?? mobile)(context),
      FormFactor.mobile => mobile(context),
    };
  }
}

/// Centers and width-constrains page content so it stays readable on large
/// screens instead of stretching edge to edge.
class ContentConstraint extends StatelessWidget {
  const ContentConstraint({
    required this.child,
    this.maxWidth = 1120,
    super.key,
  });

  final Widget child;
  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: child,
      ),
    );
  }
}
