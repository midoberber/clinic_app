import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:clinic_app/l10n/messages_all.dart';

class AppLocalizations {
  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static Future<AppLocalizations> load(Locale locale) {
    final String name =
        locale.countryCode == null ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);

    return initializeMessages(localeName).then((bool _) {
      Intl.defaultLocale = localeName;
      return new AppLocalizations();
    });
  }

  String get appTitle {
    return Intl.message('clinic_app', name: 'appTitle');
  }

  String get phoneNumber {
    return Intl.message("Enter Your Phone Number ", name: 'phoneNumber');
  }

  String get vldpasswordrequired {
    return Intl.message('Please enter the password ',
        name: 'vldpasswordrequired');
  }

  String get vldpasswordlength {
    return Intl.message('Password Length must be 6 charachters at least. ',
        name: 'vldpasswordlength');
  }

  String get vldphonerequired {
    return Intl.message('Please enter the phone number ',
        name: 'vldphonerequired');
  }

  String get vldphonelength {
    return Intl.message('Phone Length must be 6 charachters at least. ',
        name: 'vldphonelength');
  }

  String get login {
    return Intl.message('Login', name: 'login');
  }

  String get registerNow {
    return Intl.message('Register now', name: 'registerNow');
  }

  String get register {
    return Intl.message('Register', name: 'register');
  }

  String get welcome {
    return Intl.message('Welcome to clinic_app', name: 'login');
  }

  String get terms {
    return Intl.message('Review our Terms and Conditions', name: 'login');
  }

  String get hubs {
    return Intl.message('Hubs', name: 'hubs');
  }

  String get group {
    return Intl.message('Group', name: 'group');
  }

  String get enterPassword {
    return Intl.message("Enter Your Password", name: 'confirmPassword');
  }

  String get confirmPassword {
    return Intl.message("Confirm Password", name: 'confirmPassword');
  }

  String get male {
    return Intl.message("Male", name: 'male');
  }

  String get female {
    return Intl.message("Female", name: 'female');
  }

  String get locale {
    return Intl.message('en', name: 'locale');
  }
}

class SpecificLocalizationDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  final Locale overriddenLocale;

  SpecificLocalizationDelegate(this.overriddenLocale);

  @override
  bool isSupported(Locale locale) => overriddenLocale != null;

  @override
  Future<AppLocalizations> load(Locale locale) =>
      AppLocalizations.load(overriddenLocale);

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalizations> old) => true;
}
