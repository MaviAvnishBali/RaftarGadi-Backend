import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_widgets/shared_widgets.dart';

Widget _intText(int v) => Text('value: $v');

Widget _shell() => RaftarNavShell(
  selectedIndex: 0,
  onDestinationSelected: (_) {},
  destinations: const [
    RaftarDestination(icon: Icons.home, label: 'Home'),
    RaftarDestination(icon: Icons.person, label: 'Profile'),
  ],
  body: const SizedBox(),
);

Widget _host(Widget child, {Size size = const Size(400, 800)}) {
  return MaterialApp(
    theme: RaftarTheme.light,
    home: MediaQuery(
      data: MediaQueryData(size: size),
      child: Scaffold(body: child),
    ),
  );
}

void main() {
  group('AsyncValueView', () {
    testWidgets('shows loading, then data', (tester) async {
      await tester.pumpWidget(
        _host(const AsyncValueView<int>(value: AsyncLoading(), data: _intText)),
      );
      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      await tester.pumpWidget(
        _host(const AsyncValueView<int>(value: AsyncData(7), data: _intText)),
      );
      expect(find.text('value: 7'), findsOneWidget);
    });

    testWidgets('renders a Failure with a working retry', (tester) async {
      var retried = 0;
      await tester.pumpWidget(
        _host(
          AsyncValueView<int>(
            value: const AsyncError(
              NotFoundFailure('missing'),
              StackTrace.empty,
            ),
            data: _intText,
            onRetry: () => retried++,
          ),
        ),
      );
      expect(find.text('missing'), findsOneWidget);
      await tester.tap(find.text('Try again'));
      expect(retried, 1);
    });
  });

  group('RaftarNavShell', () {
    testWidgets('uses a bottom bar on mobile', (tester) async {
      await tester.pumpWidget(_host(_shell()));
      expect(find.byType(NavigationBar), findsOneWidget);
      expect(find.byType(NavigationRail), findsNothing);
    });

    testWidgets('uses a rail on desktop', (tester) async {
      await tester.pumpWidget(_host(_shell(), size: const Size(1300, 900)));
      expect(find.byType(NavigationRail), findsOneWidget);
      expect(find.byType(NavigationBar), findsNothing);
    });
  });
}
