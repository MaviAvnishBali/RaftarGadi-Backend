// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Raftar Gaddi';

  @override
  String get tagline => 'Har Load, Hamari Zimmedaari';

  @override
  String greeting(String name) {
    return 'Hello, $name';
  }

  @override
  String get actionRetry => 'Try again';

  @override
  String get actionCancel => 'Cancel';

  @override
  String get actionConfirm => 'Confirm';

  @override
  String get actionSave => 'Save';

  @override
  String get actionSearch => 'Search';

  @override
  String get navHome => 'Home';

  @override
  String get navBookings => 'Bookings';

  @override
  String get navWallet => 'Wallet';

  @override
  String get navProfile => 'Profile';

  @override
  String get bookNow => 'Book now';

  @override
  String get fareEstimate => 'Estimated fare';

  @override
  String get pickupHint => 'Pickup location';

  @override
  String get dropHint => 'Drop location';
}
