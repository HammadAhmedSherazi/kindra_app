import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/shared_preferences.dart';

class LocalizationService {
  LocalizationService(this.locale);

  final Locale locale;
  static Map<String, String> _localizedStrings = {};

  static LocalizationService? of(BuildContext context) {
    return Localizations.of<LocalizationService>(context, LocalizationService);
  }

  static const LocalizationsDelegate<LocalizationService> delegate =
      _LocalizationServiceDelegate();

  Future<bool> load() async {
    try {
      final jsonString = await rootBundle
          .loadString('assets/l10n/${locale.languageCode}.json');
      final jsonMap = json.decode(jsonString) as Map<String, dynamic>;
      _localizedStrings =
          jsonMap.map((key, value) => MapEntry(key, value.toString()));
      return true;
    } catch (_) {
      _localizedStrings = {};
      return true;
    }
  }

  String translate(String key) => _localizedStrings[key] ?? key;
}

class _LocalizationServiceDelegate
    extends LocalizationsDelegate<LocalizationService> {
  const _LocalizationServiceDelegate();

  @override
  bool isSupported(Locale locale) =>
      ['en', 'es'].contains(locale.languageCode);

  @override
  Future<LocalizationService> load(Locale locale) async {
    final service = LocalizationService(locale);
    await service.load();
    return service;
  }

  @override
  bool shouldReload(_LocalizationServiceDelegate old) => false;
}

extension LocalizationExtension on BuildContext {
  String tr(String key) {
    return LocalizationService.of(this)?.translate(key) ?? key;
  }
}

final localeProvider =
    NotifierProvider<LocaleNotifier, Locale>(LocaleNotifier.new);

class LocaleNotifier extends Notifier<Locale> {
  @override
  Locale build() {
    return Locale(
        SharedPreferenceManager.sharedInstance.getLangCode());
  }

  void changeLanguage(String languageCode) {
    if (!['en', 'es'].contains(languageCode)) return;
    state = Locale(languageCode);
    SharedPreferenceManager.sharedInstance.storeLangCode(languageCode);
  }
}
