import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('RaftarButton shows a spinner and disables while loading', (
    tester,
  ) async {
    var pressed = 0;
    await tester.pumpWidget(
      MaterialApp(
        theme: RaftarTheme.light,
        home: Scaffold(
          body: RaftarButton(
            label: 'Book now',
            isLoading: true,
            onPressed: () => pressed++,
          ),
        ),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.text('Book now'), findsNothing);

    await tester.tap(find.byType(RaftarButton));
    expect(pressed, 0); // Disabled while loading.
  });

  testWidgets('RaftarFeedback.showSnackbar surfaces a message', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: RaftarTheme.light,
        home: Scaffold(
          body: Builder(
            builder: (context) => RaftarButton(
              label: 'Notify',
              expand: false,
              onPressed: () => RaftarFeedback.showSnackbar(
                context,
                message: 'Booking confirmed',
                status: RaftarStatus.success,
              ),
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.byType(RaftarButton));
    await tester.pump();
    expect(find.text('Booking confirmed'), findsOneWidget);
  });

  test('light theme uses the brand palette', () {
    final theme = RaftarTheme.light;
    expect(theme.colorScheme.primary, RaftarColors.primary);
    expect(theme.scaffoldBackgroundColor, RaftarColors.background);
    expect(theme.colorScheme.onSurface, RaftarColors.textPrimary);
  });
}
