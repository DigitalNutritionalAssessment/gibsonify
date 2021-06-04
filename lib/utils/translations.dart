import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

//this file is mainly to do with translations to different languages
//it was set in myapp that there are two language options available
//however, there is no button on the app to change it yet so this needs to be done in the future (low priority)
//also try to translate to other dialects

class Translations {
  Translations(Locale locale) {
    this.locale = locale;
    _localizedValues = null;
  }

  Locale locale;
  static Map<dynamic, dynamic> _localizedValues;

  static Translations of(BuildContext context) {
    return Localizations.of<Translations>(context, Translations);
  }

  String text(String key) {
    return _localizedValues[key] ?? '** $key not found';
  }

  static Future<Translations> load(Locale locale) async {
    Translations translations = new Translations(locale);
    String jsonContent =
        await rootBundle.loadString("locale/i18n_${locale.languageCode}.json");
    _localizedValues = json.decode(jsonContent);
    return translations;
  }

  get currentLanguage => locale.languageCode; //change to desired language
}

class TranslationsDelegate extends LocalizationsDelegate<Translations> {
  const TranslationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'hi'].contains(locale.languageCode); //from english to hindu

  @override
  Future<Translations> load(Locale locale) => Translations.load(locale);

  @override
  bool shouldReload(TranslationsDelegate old) => false;
}
