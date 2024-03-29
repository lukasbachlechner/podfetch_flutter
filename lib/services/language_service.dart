class LanguageService {
  static const staticLanguagesList = [
    {"isoCode": "af", "name": "Afrikaans"},
    {"isoCode": "af-ZA", "name": "Afrikaans (South Africa)"},
    {"isoCode": "ar", "name": "Arabic"},
    {"isoCode": "ar-AE", "name": "Arabic (U.A.E.)"},
    {"isoCode": "ar-BH", "name": "Arabic (Bahrain)"},
    {"isoCode": "ar-DZ", "name": "Arabic (Algeria)"},
    {"isoCode": "ar-EG", "name": "Arabic (Egypt)"},
    {"isoCode": "ar-IQ", "name": "Arabic (Iraq)"},
    {"isoCode": "ar-JO", "name": "Arabic (Jordan)"},
    {"isoCode": "ar-KW", "name": "Arabic (Kuwait)"},
    {"isoCode": "ar-LB", "name": "Arabic (Lebanon)"},
    {"isoCode": "ar-LY", "name": "Arabic (Libya)"},
    {"isoCode": "ar-MA", "name": "Arabic (Morocco)"},
    {"isoCode": "ar-OM", "name": "Arabic (Oman)"},
    {"isoCode": "ar-QA", "name": "Arabic (Qatar)"},
    {"isoCode": "ar-SA", "name": "Arabic (Saudi Arabia)"},
    {"isoCode": "ar-SY", "name": "Arabic (Syria)"},
    {"isoCode": "ar-TN", "name": "Arabic (Tunisia)"},
    {"isoCode": "ar-YE", "name": "Arabic (Yemen)"},
    {"isoCode": "az", "name": "Azeri (Latin)"},
    {"isoCode": "az-AZ", "name": "Azeri (Latin) (Azerbaijan)"},
    {"isoCode": "az-AZ", "name": "Azeri (Cyrillic) (Azerbaijan)"},
    {"isoCode": "be", "name": "Belarusian"},
    {"isoCode": "be-BY", "name": "Belarusian (Belarus)"},
    {"isoCode": "bg", "name": "Bulgarian"},
    {"isoCode": "bg-BG", "name": "Bulgarian (Bulgaria)"},
    {"isoCode": "bs-BA", "name": "Bosnian (Bosnia and Herzegovina)"},
    {"isoCode": "ca", "name": "Catalan"},
    {"isoCode": "ca-ES", "name": "Catalan (Spain)"},
    {"isoCode": "cs", "name": "Czech"},
    {"isoCode": "cs-CZ", "name": "Czech (Czech Republic)"},
    {"isoCode": "cy", "name": "Welsh"},
    {"isoCode": "cy-GB", "name": "Welsh (United Kingdom)"},
    {"isoCode": "da", "name": "Danish"},
    {"isoCode": "da-DK", "name": "Danish (Denmark)"},
    {"isoCode": "de", "name": "German"},
    {"isoCode": "de-AT", "name": "German (Austria)"},
    {"isoCode": "de-CH", "name": "German (Switzerland)"},
    {"isoCode": "de-DE", "name": "German (Germany)"},
    {"isoCode": "de-LI", "name": "German (Liechtenstein)"},
    {"isoCode": "de-LU", "name": "German (Luxembourg)"},
    {"isoCode": "dv", "name": "Divehi"},
    {"isoCode": "dv-MV", "name": "Divehi (Maldives)"},
    {"isoCode": "el", "name": "Greek"},
    {"isoCode": "el-GR", "name": "Greek (Greece)"},
    {"isoCode": "en", "name": "English"},
    {"isoCode": "en-AU", "name": "English (Australia)"},
    {"isoCode": "en-BZ", "name": "English (Belize)"},
    {"isoCode": "en-CA", "name": "English (Canada)"},
    {"isoCode": "en-CB", "name": "English (Caribbean)"},
    {"isoCode": "en-GB", "name": "English (United Kingdom)"},
    {"isoCode": "en-IE", "name": "English (Ireland)"},
    {"isoCode": "en-JM", "name": "English (Jamaica)"},
    {"isoCode": "en-NZ", "name": "English (New Zealand)"},
    {"isoCode": "en-PH", "name": "English (Republic of the Philippines)"},
    {"isoCode": "en-TT", "name": "English (Trinidad and Tobago)"},
    {"isoCode": "en-US", "name": "English (United States)"},
    {"isoCode": "en-ZA", "name": "English (South Africa)"},
    {"isoCode": "en-ZW", "name": "English (Zimbabwe)"},
    {"isoCode": "eo", "name": "Esperanto"},
    {"isoCode": "es", "name": "Spanish"},
    {"isoCode": "es-AR", "name": "Spanish (Argentina)"},
    {"isoCode": "es-BO", "name": "Spanish (Bolivia)"},
    {"isoCode": "es-CL", "name": "Spanish (Chile)"},
    {"isoCode": "es-CO", "name": "Spanish (Colombia)"},
    {"isoCode": "es-CR", "name": "Spanish (Costa Rica)"},
    {"isoCode": "es-DO", "name": "Spanish (Dominican Republic)"},
    {"isoCode": "es-EC", "name": "Spanish (Ecuador)"},
    {"isoCode": "es-ES", "name": "Spanish (Castilian)"},
    {"isoCode": "es-ES", "name": "Spanish (Spain)"},
    {"isoCode": "es-GT", "name": "Spanish (Guatemala)"},
    {"isoCode": "es-HN", "name": "Spanish (Honduras)"},
    {"isoCode": "es-MX", "name": "Spanish (Mexico)"},
    {"isoCode": "es-NI", "name": "Spanish (Nicaragua)"},
    {"isoCode": "es-PA", "name": "Spanish (Panama)"},
    {"isoCode": "es-PE", "name": "Spanish (Peru)"},
    {"isoCode": "es-PR", "name": "Spanish (Puerto Rico)"},
    {"isoCode": "es-PY", "name": "Spanish (Paraguay)"},
    {"isoCode": "es-SV", "name": "Spanish (El Salvador)"},
    {"isoCode": "es-UY", "name": "Spanish (Uruguay)"},
    {"isoCode": "es-VE", "name": "Spanish (Venezuela)"},
    {"isoCode": "et", "name": "Estonian"},
    {"isoCode": "et-EE", "name": "Estonian (Estonia)"},
    {"isoCode": "eu", "name": "Basque"},
    {"isoCode": "eu-ES", "name": "Basque (Spain)"},
    {"isoCode": "fa", "name": "Farsi"},
    {"isoCode": "fa-IR", "name": "Farsi (Iran)"},
    {"isoCode": "fi", "name": "Finnish"},
    {"isoCode": "fi-FI", "name": "Finnish (Finland)"},
    {"isoCode": "fo", "name": "Faroese"},
    {"isoCode": "fo-FO", "name": "Faroese (Faroe Islands)"},
    {"isoCode": "fr", "name": "French"},
    {"isoCode": "fr-BE", "name": "French (Belgium)"},
    {"isoCode": "fr-CA", "name": "French (Canada)"},
    {"isoCode": "fr-CH", "name": "French (Switzerland)"},
    {"isoCode": "fr-FR", "name": "French (France)"},
    {"isoCode": "fr-LU", "name": "French (Luxembourg)"},
    {"isoCode": "fr-MC", "name": "French (Principality of Monaco)"},
    {"isoCode": "gl", "name": "Galician"},
    {"isoCode": "gl-ES", "name": "Galician (Spain)"},
    {"isoCode": "gu", "name": "Gujarati"},
    {"isoCode": "gu-IN", "name": "Gujarati (India)"},
    {"isoCode": "he", "name": "Hebrew"},
    {"isoCode": "he-IL", "name": "Hebrew (Israel)"},
    {"isoCode": "hi", "name": "Hindi"},
    {"isoCode": "hi-IN", "name": "Hindi (India)"},
    {"isoCode": "hr", "name": "Croatian"},
    {"isoCode": "hr-BA", "name": "Croatian (Bosnia and Herzegovina)"},
    {"isoCode": "hr-HR", "name": "Croatian (Croatia)"},
    {"isoCode": "hu", "name": "Hungarian"},
    {"isoCode": "hu-HU", "name": "Hungarian (Hungary)"},
    {"isoCode": "hy", "name": "Armenian"},
    {"isoCode": "hy-AM", "name": "Armenian (Armenia)"},
    {"isoCode": "id", "name": "Indonesian"},
    {"isoCode": "id-ID", "name": "Indonesian (Indonesia)"},
    {"isoCode": "is", "name": "Icelandic"},
    {"isoCode": "is-IS", "name": "Icelandic (Iceland)"},
    {"isoCode": "it", "name": "Italian"},
    {"isoCode": "it-CH", "name": "Italian (Switzerland)"},
    {"isoCode": "it-IT", "name": "Italian (Italy)"},
    {"isoCode": "ja", "name": "Japanese"},
    {"isoCode": "ja-JP", "name": "Japanese (Japan)"},
    {"isoCode": "ka", "name": "Georgian"},
    {"isoCode": "ka-GE", "name": "Georgian (Georgia)"},
    {"isoCode": "kk", "name": "Kazakh"},
    {"isoCode": "kk-KZ", "name": "Kazakh (Kazakhstan)"},
    {"isoCode": "kn", "name": "Kannada"},
    {"isoCode": "kn-IN", "name": "Kannada (India)"},
    {"isoCode": "ko", "name": "Korean"},
    {"isoCode": "ko-KR", "name": "Korean (Korea)"},
    {"isoCode": "kok", "name": "Konkani"},
    {"isoCode": "kok-IN", "name": "Konkani (India)"},
    {"isoCode": "ky", "name": "Kyrgyz"},
    {"isoCode": "ky-KG", "name": "Kyrgyz (Kyrgyzstan)"},
    {"isoCode": "lt", "name": "Lithuanian"},
    {"isoCode": "lt-LT", "name": "Lithuanian (Lithuania)"},
    {"isoCode": "lv", "name": "Latvian"},
    {"isoCode": "lv-LV", "name": "Latvian (Latvia)"},
    {"isoCode": "mi", "name": "Maori"},
    {"isoCode": "mi-NZ", "name": "Maori (New Zealand)"},
    {"isoCode": "mk", "name": "FYRO Macedonian"},
    {
      "isoCode": "mk-MK",
      "name": "FYRO Macedonian (Former Yugoslav Republic of Macedonia)"
    },
    {"isoCode": "mn", "name": "Mongolian"},
    {"isoCode": "mn-MN", "name": "Mongolian (Mongolia)"},
    {"isoCode": "mr", "name": "Marathi"},
    {"isoCode": "mr-IN", "name": "Marathi (India)"},
    {"isoCode": "ms", "name": "Malay"},
    {"isoCode": "ms-BN", "name": "Malay (Brunei Darussalam)"},
    {"isoCode": "ms-MY", "name": "Malay (Malaysia)"},
    {"isoCode": "mt", "name": "Maltese"},
    {"isoCode": "mt-MT", "name": "Maltese (Malta)"},
    {"isoCode": "nb", "name": "Norwegian (Bokm?l)"},
    {"isoCode": "nb-NO", "name": "Norwegian (Bokm?l) (Norway)"},
    {"isoCode": "nl", "name": "Dutch"},
    {"isoCode": "nl-BE", "name": "Dutch (Belgium)"},
    {"isoCode": "nl-NL", "name": "Dutch (Netherlands)"},
    {"isoCode": "nn-NO", "name": "Norwegian (Nynorsk) (Norway)"},
    {"isoCode": "ns", "name": "Northern Sotho"},
    {"isoCode": "ns-ZA", "name": "Northern Sotho (South Africa)"},
    {"isoCode": "pa", "name": "Punjabi"},
    {"isoCode": "pa-IN", "name": "Punjabi (India)"},
    {"isoCode": "pl", "name": "Polish"},
    {"isoCode": "pl-PL", "name": "Polish (Poland)"},
    {"isoCode": "ps", "name": "Pashto"},
    {"isoCode": "ps-AR", "name": "Pashto (Afghanistan)"},
    {"isoCode": "pt", "name": "Portuguese"},
    {"isoCode": "pt-BR", "name": "Portuguese (Brazil)"},
    {"isoCode": "pt-PT", "name": "Portuguese (Portugal)"},
    {"isoCode": "qu", "name": "Quechua"},
    {"isoCode": "qu-BO", "name": "Quechua (Bolivia)"},
    {"isoCode": "qu-EC", "name": "Quechua (Ecuador)"},
    {"isoCode": "qu-PE", "name": "Quechua (Peru)"},
    {"isoCode": "ro", "name": "Romanian"},
    {"isoCode": "ro-RO", "name": "Romanian (Romania)"},
    {"isoCode": "ru", "name": "Russian"},
    {"isoCode": "ru-RU", "name": "Russian (Russia)"},
    {"isoCode": "sa", "name": "Sanskrit"},
    {"isoCode": "sa-IN", "name": "Sanskrit (India)"},
    {"isoCode": "se", "name": "Sami (Northern)"},
    {"isoCode": "se-FI", "name": "Sami (Northern) (Finland)"},
    {"isoCode": "se-FI", "name": "Sami (Skolt) (Finland)"},
    {"isoCode": "se-FI", "name": "Sami (Inari) (Finland)"},
    {"isoCode": "se-NO", "name": "Sami (Northern) (Norway)"},
    {"isoCode": "se-NO", "name": "Sami (Lule) (Norway)"},
    {"isoCode": "se-NO", "name": "Sami (Southern) (Norway)"},
    {"isoCode": "se-SE", "name": "Sami (Northern) (Sweden)"},
    {"isoCode": "se-SE", "name": "Sami (Lule) (Sweden)"},
    {"isoCode": "se-SE", "name": "Sami (Southern) (Sweden)"},
    {"isoCode": "sk", "name": "Slovak"},
    {"isoCode": "sk-SK", "name": "Slovak (Slovakia)"},
    {"isoCode": "sl", "name": "Slovenian"},
    {"isoCode": "sl-SI", "name": "Slovenian (Slovenia)"},
    {"isoCode": "sq", "name": "Albanian"},
    {"isoCode": "sq-AL", "name": "Albanian (Albania)"},
    {"isoCode": "sr-BA", "name": "Serbian (Latin) (Bosnia and Herzegovina)"},
    {"isoCode": "sr-BA", "name": "Serbian (Cyrillic) (Bosnia and Herzegovina)"},
    {"isoCode": "sr-SP", "name": "Serbian (Latin) (Serbia and Montenegro)"},
    {"isoCode": "sr-SP", "name": "Serbian (Cyrillic) (Serbia and Montenegro)"},
    {"isoCode": "sv", "name": "Swedish"},
    {"isoCode": "sv-FI", "name": "Swedish (Finland)"},
    {"isoCode": "sv-SE", "name": "Swedish (Sweden)"},
    {"isoCode": "sw", "name": "Swahili"},
    {"isoCode": "sw-KE", "name": "Swahili (Kenya)"},
    {"isoCode": "syr", "name": "Syriac"},
    {"isoCode": "syr-SY", "name": "Syriac (Syria)"},
    {"isoCode": "ta", "name": "Tamil"},
    {"isoCode": "ta-IN", "name": "Tamil (India)"},
    {"isoCode": "te", "name": "Telugu"},
    {"isoCode": "te-IN", "name": "Telugu (India)"},
    {"isoCode": "th", "name": "Thai"},
    {"isoCode": "th-TH", "name": "Thai (Thailand)"},
    {"isoCode": "tl", "name": "Tagalog"},
    {"isoCode": "tl-PH", "name": "Tagalog (Philippines)"},
    {"isoCode": "tn", "name": "Tswana"},
    {"isoCode": "tn-ZA", "name": "Tswana (South Africa)"},
    {"isoCode": "tr", "name": "Turkish"},
    {"isoCode": "tr-TR", "name": "Turkish (Turkey)"},
    {"isoCode": "tt", "name": "Tatar"},
    {"isoCode": "tt-RU", "name": "Tatar (Russia)"},
    {"isoCode": "ts", "name": "Tsonga"},
    {"isoCode": "uk", "name": "Ukrainian"},
    {"isoCode": "uk-UA", "name": "Ukrainian (Ukraine)"},
    {"isoCode": "ur", "name": "Urdu"},
    {"isoCode": "ur-PK", "name": "Urdu (Islamic Republic of Pakistan)"},
    {"isoCode": "uz", "name": "Uzbek (Latin)"},
    {"isoCode": "uz-UZ", "name": "Uzbek (Latin) (Uzbekistan)"},
    {"isoCode": "uz-UZ", "name": "Uzbek (Cyrillic) (Uzbekistan)"},
    {"isoCode": "vi", "name": "Vietnamese"},
    {"isoCode": "vi-VN", "name": "Vietnamese (Viet Nam)"},
    {"isoCode": "xh", "name": "Xhosa"},
    {"isoCode": "xh-ZA", "name": "Xhosa (South Africa)"},
    {"isoCode": "zh", "name": "Chinese"},
    {"isoCode": "zh-CN", "name": "Chinese (S)"},
    {"isoCode": "zh-HK", "name": "Chinese (Hong Kong)"},
    {"isoCode": "zh-MO", "name": "Chinese (Macau)"},
    {"isoCode": "zh-SG", "name": "Chinese (Singapore)"},
    {"isoCode": "zh-TW", "name": "Chinese (T)"},
    {"isoCode": "zu", "name": "Zulu"},
    {"isoCode": "zu-ZA", "name": "Zulu (South Africa)"}
  ];

  static Language get defaultLanguage {
    return getByIsoCode('en');
  }

  static Language getByIsoCode(String isoCode) {
    Language? result = all().firstWhere(
      (language) => language.isoCode.toLowerCase() == isoCode.toLowerCase(),
      orElse: () => const Language('', '<not specified>'),
    );

    return result;
  }

  static List<Language> all({bool majorOnly = false}) {
    final allLanguages = staticLanguagesList
        .map(
          (language) => Language(language['isoCode']!, language['name']!),
        )
        .toList();

    return majorOnly
        ? allLanguages.where((language) => language.isMajor).toList()
        : allLanguages;
  }
}

class Language {
  final String isoCode;
  final String name;

  const Language(this.isoCode, this.name);

  bool get isMajor {
    return isoCode.length == 2;
  }

  String get emoji {
    final countryCode = isMajor ? isoCode : isoCode.split('-')[1];
    return EmojiConverter.fromAlpha2CountryCode(countryCode);
  }

  String get emojiAndName {
    return '$emoji $name';
  }
}

class EmojiConverter {
  // Offset value points to the unicode character needed for the emoji flag
  static const int _offset = 127397;
  static final int _a = 'A'.codeUnitAt(0);
  static final int _z = 'Z'.codeUnitAt(0);
  static const _exception =
      FormatException('Provided code is not an alpha 2 country code.');

  static String fromAlpha2CountryCode(String alpha2Code) {
    if (alpha2Code.length != 2) throw _exception;

    String formatted = alpha2Code.toUpperCase();
    final int first = formatted.codeUnitAt(0);
    final int second = formatted.codeUnitAt(1);

    // Check that the two letters are alphabetical characters
    if (first > _z || first < _a || second > _z || second < _a)
      throw _exception;

    // Create the emoji flag from the offset
    return String.fromCharCode(first + _offset) +
        String.fromCharCode(second + _offset);
  }
}
