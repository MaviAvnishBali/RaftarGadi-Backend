/// Raftar Gaddi — `localization` package.
///
/// Shared localized strings (English + Hindi) generated from ARB files via
/// `flutter gen-l10n`. Apps wire [AppLocalizations.localizationsDelegates] and
/// [AppLocalizations.supportedLocales] into their `MaterialApp`, then read
/// strings with `context.l10n`.
library;

import 'package:flutter/widgets.dart';
import 'package:localization/src/gen/app_localizations.dart';

export 'src/gen/app_localizations.dart';

/// Ergonomic access to the current [AppLocalizations] from a [BuildContext].
extension RaftarLocalizationsX on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}
