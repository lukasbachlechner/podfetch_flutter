
import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:podfetch_flutter/services/language_service.dart';

final languageProvider =
    StateNotifierProvider<LanguageNotifier, Language>((ref) {
  return LanguageNotifier();
});

class LanguageNotifier extends StateNotifier<Language> {
  final box = Hive.box('localSettings');

  LanguageNotifier() : super(LanguageService.defaultLanguage) {
    final isoCode = box.get('languageCode', defaultValue: 'en');
    final currentLanguage = LanguageService.getByIsoCode(isoCode);
    super.state = currentLanguage;
  }

  void setLanguage(isoCode) {
    box.put('languageCode', isoCode);
    state = LanguageService.getByIsoCode(isoCode);
  }
}
