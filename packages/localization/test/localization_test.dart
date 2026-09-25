import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:localization/localization.dart';

Future<AppLocalizations> _load(WidgetTester tester, Locale locale) async {
  late AppLocalizations l10n;
  await tester.pumpWidget(
    MaterialApp(
      locale: locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Builder(
        builder: (context) {
          l10n = context.l10n;
          return const SizedBox();
        },
      ),
    ),
  );
  return l10n;
}

void main() {
  testWidgets('resolves English strings', (tester) async {
    final l10n = await _load(tester, const Locale('en'));
    expect(l10n.appName, 'Raftar Gaddi');
    expect(l10n.tagline, 'Har Load, Hamari Zimmedaari');
    expect(l10n.greeting('Aarav'), 'Hello, Aarav');
  });

  testWidgets('resolves Hindi strings', (tester) async {
    final l10n = await _load(tester, const Locale('hi'));
    expect(l10n.appName, 'रफ़्तार गाड़ी');
    expect(l10n.navWallet, 'वॉलेट');
  });

  test('supports English and Hindi', () {
    expect(
      AppLocalizations.supportedLocales.map((l) => l.languageCode),
      containsAll(<String>['en', 'hi']),
    );
  });
}
