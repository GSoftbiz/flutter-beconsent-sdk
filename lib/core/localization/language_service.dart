class LanguageService {
  static String defaultLanguage = 'en';
  static final Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'accept_all': 'Accept All',
      'decline_additions': 'Decline Additions',
      'save_settings': 'Save Settings',
      'success': 'Success',
    },
    'th': {
      'accept_all': 'ยินยอมทั้งหมด',
      'decline_additions': 'ปฏิเสธค่าที่ไม่จำเป็น',
      'save_settings': 'บันทึกค่าที่เลือก',
      'success': 'สำเร็จ',
    }
  };
  static set language(String lang) {
    defaultLanguage = lang;
  }
  static String? get accept_all {
    return _localizedValues[defaultLanguage]?['accept_all'];
  }
  static String? get decline_additions {
    return _localizedValues[defaultLanguage]?['decline_additions'];
  }
  static String? get save_settings {
    return _localizedValues[defaultLanguage]?['save_settings'];
  }
  static String? get success {
    return _localizedValues[defaultLanguage]?['success'];
  }

}
