import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pizza_app/shared/l10n/en.dart';
import 'package:pizza_app/shared/l10n/hu.dart';

class MeetingsAppLocalizations {
  final Locale locale;

  MeetingsAppLocalizations(this.locale);

  // Segédfüggvény, amivel a BuildContext-ből kikereshetjük a beregisztrált
  // PizzaAppLocalization példányt, amit a rendszer az épp aktuális nyelvvel
  // példányosít
  static MeetingsAppLocalizations? of(BuildContext context) {
    return Localizations.of<MeetingsAppLocalizations>(
        context, MeetingsAppLocalizations);
  }

  static const LocalizationsDelegate<MeetingsAppLocalizations> delegate =
      _MeetingsAppLocalizationsDelegate();

  // Hozzárendeljük a nyelv kódjához a definiált szövegeket
  static Map<String, Map<String, String>> _localizedValues = {
    'en': ENGLISH_TEXTS,
    'hu': HUNGARIAN_TEXTS,
  };

  // Az aktuális nyelv alapján adjuk vissza  az azonosítóhoz tartozó
  // lefordított szöveget.
  String stringById(String id) =>
      _localizedValues[locale.languageCode]?[id] ??
      'Missing translation: $id for locale: ${locale.languageCode}';

  // Az egyes azonosítókhoz metódust rendelünk
  String get addAddressDialogTitle => stringById('addAddressDialogTitle');
  String get addresses => stringById('addresses');
  String get addressSaved => stringById('addressSaved');
  String get addToCart => stringById('addToCart');
  String get cancel => stringById('cancel');
  String get canNotAccessToContacts => stringById('canNotAccessToContacts');
  String get cart => stringById('cart');
  String get cheeseBurst => stringById('cheeseBurst');
  String get chooseContact => stringById('chooseContact');
  String get city => stringById('city');
  String get crust => stringById('crust');
  String get details => stringById('details');
  String get email => stringById('email');
  String get enterYourEmail => stringById('enterYourEmail');
  String get enterYourName => stringById('enterYourName');
  String get enterYourPhone => stringById('enterYourPhone');
  String get extraCheese => stringById('extraCheese');
  String get extraSpice => stringById('extraSpice');
  String get garlicRoasted => stringById('garlicRoasted');
  String get houseNumber => stringById('houseNumber');
  String get large => stringById('large');
  String get mandatoryField => stringById('mandatoryField');
  String get medium => stringById('medium');
  String get name => stringById('name');
  String get phone => stringById('phone');
  String get profile => stringById('profile');
  String get profileSaved => stringById('profileSaved');
  String get save => stringById('save');
  String get size => stringById('size');
  String get small => stringById('small');
  String get standard => stringById('standard');
  String get street => stringById('street');
  String get takeAPicture => stringById('takeAPicture');
  String get todaySpecials => stringById('todaySpecials');
  String get toppings => stringById('toppings');
  String get total => stringById('total');
  String get unknown => stringById('unknown');
  String get whoWillEat => stringById('whoWillEat');
  String get rooms => stringById('rooms');
  String get meetings => stringById('meetings');
  String get sureToDelete => stringById('sureToDelete');
  String get yes => stringById('yes');
  String get no => stringById('no');
  String get addMeeting => stringById('addMeeting');

}

// Segédosztály, ami az aktuális nyelv alapján hoz létre egy
// MeetingsAppLocalizations példányt, amit majd a widget-ekben elérhetünk
// a BuildContext-en keresztül
class _MeetingsAppLocalizationsDelegate
    extends LocalizationsDelegate<MeetingsAppLocalizations> {
  const _MeetingsAppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'hu'].contains(locale.languageCode);

  @override
  Future<MeetingsAppLocalizations> load(Locale locale) {
    return SynchronousFuture<MeetingsAppLocalizations>(
      MeetingsAppLocalizations(locale),
    );
  }

  @override
  bool shouldReload(_MeetingsAppLocalizationsDelegate old) => false;
}
