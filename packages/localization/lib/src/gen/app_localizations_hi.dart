// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get appName => 'रफ़्तार गाड़ी';

  @override
  String get tagline => 'हर लोड, हमारी ज़िम्मेदारी';

  @override
  String greeting(String name) {
    return 'नमस्ते, $name';
  }

  @override
  String get actionRetry => 'फिर से कोशिश करें';

  @override
  String get actionCancel => 'रद्द करें';

  @override
  String get actionConfirm => 'पुष्टि करें';

  @override
  String get actionSave => 'सहेजें';

  @override
  String get actionSearch => 'खोजें';

  @override
  String get navHome => 'होम';

  @override
  String get navBookings => 'बुकिंग';

  @override
  String get navWallet => 'वॉलेट';

  @override
  String get navProfile => 'प्रोफ़ाइल';

  @override
  String get bookNow => 'अभी बुक करें';

  @override
  String get fareEstimate => 'अनुमानित किराया';

  @override
  String get pickupHint => 'पिकअप स्थान';

  @override
  String get dropHint => 'ड्रॉप स्थान';
}
