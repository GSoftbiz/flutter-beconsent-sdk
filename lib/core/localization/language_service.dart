import 'package:flutter_beconsent_sdk/modules/consent/beconsent.dart';

class LanguageService {
  static String defaultLanguage = 'en';
  static final Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'accept_all': 'Accept All',
      'decline_additions': 'Decline Additions',
      'save_settings': 'Save Settings',
      'success': 'Save Success',
      'first_name': 'First name',
      'last_name': 'Last name',
      'email': 'Email',
      'country': 'Country',
      'dsrm_title': 'Data Subject Right Access',
      'dsrm_desc_1_1':
          'This request form assists you [APP_NAME] in the process of making an information request (the right to have access to the information) we hold about you. In addition, in certain circumstances you also have the right to:',
      'dsrm_desc_1_2':
          '1. 	rectify or update your personal data\n. 	object to or restrict the use of your personal data\n3. 	the right to data portability (where processing is technically fesible)\n4. 	the right to erasure',
      'dsrm_desc_1_3':
          'If you wish to withdraw any of your consents to the processing of your data where you have explicitly consented to the use of your personal data and that is the lawful basis for processing, you can always do so on the consent page.',
      'dsrm_title_2': 'Identity Validation',
      'dsrm_desc_2':
          'In order to validate your or the data subject on whose behalf you write to us’ request, we need to verify your identity. Please fill-out the form below.',
      'dsrm_check_box_desc':
          'If you are a minor of the Civil and Commercial Code e.g. under 20 years of age,an incompetent or quasi-incompetent person.',
      'dsrm_guardian_title':
          'Verifiable Parental/Legal Guardian of the data subject above',
      'dsrm_title_3': 'Select right request',
      'dsrm_desc_3':
          'Please select which data subject right request you are making',
      'dsrm_title_4': 'The right to Correction',
      'other_request': 'Others request',
      'please_provide_detail': 'Please provide description of request',
      'dsrm_desc_4':
          'Please provide details why you believe the personal data we kept about you to be inaccurate or incomplete.',
      'provide_detail': 'Describe in detail',
      'dsrm_desc_4_2':
          'I certify that the information given on this request form is true and accurate, and I understand that it may be necessary for me to provide additional information in order to confirm my identity. I understand that the initial response period of 30 calendar days specified in Personal Data Protection Act, will not commence until [APP_NAME] can verify of my entitlement.',
      'submit': 'Submit',
      'last':
          'Please note that we are not responsible for the security of the personal data or its processing once received by the third party. We may not provide you with certain data if providing it would interfere with another individual’s',
      'consent_needed': 'Sorry, please submit your consent before continue',
      'baht': 'Baht',
      'fee_charge': 'Fee charge',
      'policy_footer': 'You can learn system\'s Privacy Policy details here',
    },
    'th': {
      'accept_all': 'ยินยอมทั้งหมด',
      'decline_additions': 'ปฏิเสธค่าที่ไม่จำเป็น',
      'save_settings': 'บันทึกค่าที่เลือก',
      'success': 'บันทึกสำเร็จ',
      'first_name': 'ชื่อ',
      'last_name': 'นามสกุล',
      'email': 'อีเมล',
      'country': 'ประเทศ',
      'dsrm_title': 'คำร้องขอใช้สิทธิของเจ้าของข้อมูล',
      'dsrm_desc_1_1':
          'แบบฟอร์มคำร้องขอนี้จะช่วยท่านในกระบวนการสร้างคำร้องขอใช้สิทธิ เพื่อเข้าถึงข้อมูลส่วนบุคคลของท่านที่ [APP_NAME] ได้เก็บรวบรวมไว้ นอกจากนั้นท่านยังสามารถสร้างคำร้องขอใช้สิทธิอื่นได้ ดังนี้:',
      'dsrm_desc_1_2':
          '1. แก้ไขหรืออัปเดตข้อมูลส่วนบุคคลของท่าน\n2. คัดค้านหรือระงับการใช้ข้อมูลส่วนบุคคลของท่าน\n3. สิทธิในการโอนย้ายข้อมูลส่วนบุคคล (ในกรณีที่การประมวลผลเป็นไปได้ในทางเทคนิค\n4. สิทธิในการลบข้อมูลส่วนบุคคล',
      'dsrm_desc_1_3':
          'หากท่านต้องการเพิกถอนความยินยอมใด ๆ ต่อการประมวลผลข้อมูลส่วนบุคคลของท่าน ตามที่ท่านได้ให้ความยินยอมอย่างชัดแจ้งไว้ด้วยฐานทางกฎหมายสำหรับการประมวลผลข้อมูลส่วนบุคคล ท่านสามารถดำเนินการได้เสมอผ่านช่องทางที่ท่านได้ให้ความยินยอมอย่างชัดแจ้ง',
      'dsrm_title_2': 'การยืนยันตัวตน',
      'dsrm_desc_2':
          'เพื่อตรวจสอบความถูกต้องของท่านหรือเจ้าของข้อมูลส่วนบุคคลที่ท่านเขียนในคำร้องขอต่อ [APP_NAME] ในนามของผู้อื่น [APP_NAME] จึงมีความจำเป็นต้องยืนยันตัวตนของท่าน กรุณากรอกแบบฟอร์มด้านล่าง',
      'dsrm_check_box_desc':
          'ท่านเป็นผู้เยาว์ (อายุต่ำกว่า 20 ปีบริบูรณ์) คนไร้ความสามารถ หรือคนเสมือนไร้ความสามารถ ซึ่งได้รับความยินยอมจากผู้ปกครองหรือผู้พิทักษ์แล้ว',
      'dsrm_guardian_title':
          'ข้อมูลติดต่อเพื่อยืนยันตัวตนผู้ปกครองหรือผู้พิทักษ์',
      'dsrm_title_3': 'เลือกสิทธิที่ต้องการ',
      'dsrm_desc_3':
          'โปรดเลือกคำร้องขอใช้สิทธิของเจ้าของข้อมูลส่วนบุคคลที่ท่านต้องการ',
      'dsrm_title_4': 'สิทธิในการเข้าถึงข้อมูล',
      'other_request': 'คำร้องขออื่นๆ',
      'please_provide_detail': 'โปรดอธิบายรายละเอียด',
      'dsrm_desc_4':
          'โปรดระบุเหตุผลสำหรับคำร้องขอข้างต้น เพื่อช่วย [APP_NAME] ในการพิจารณาว่าท่านมีความเข้าใจ ที่ถูกต้องสำหรับคำร้องขอ อย่างไรก็ตามโปรดทราบว่า [APP_NAME] อาจเก็บข้อมูลส่วนบุคคลของท่านไว้ หากมีฐานทางกฏหมายที่ให้ [APP_NAME] ดำเนินการเช่นนั้น (เช่น เพื่อป้องกันข้อเรียกร้องทางกฏหมาย หรือเสรีภาพในการแสดงออก) แต่ [APP_NAME] จะแจ้งให้ท่านทราบหากเป็นกรณีดังกล่าว',
      'provide_detail': 'อธิบายรายละเอียด',
      'dsrm_desc_4_2':
          'ข้าพเจ้าขอรับรองว่าข้อมูลที่ให้ไว้ในแบบฟอร์มคำร้องขอนั้นเป็นความจริงและถูกต้องทุกประการ และข้าพเจ้ายินยอม ในการให้ข้อมูลเพิ่มเติมเพื่อยืนยันตัวตนของข้าพเจ้า ข้าพเจ้าเข้าใจดีว่าระยะเวลาพิจารณาและดำเนินการ 30 วันของ [APP_NAME]  ตามที่กำหนดไว้ในพระราชบัญญัติคุ้มครองข้อมูลส่วนบุคคล พ.ศ. 2562 และจะยังไม่เริ่มนับจนกว่า [APP_NAME] จะสามารถยืนยันสิทธิของข้าพเจ้าได้',
      'submit': 'ส่ง',
      'last':
          'ในขณะที่ [APP_NAME] ประเมินว่าข้อมูลส่วนบุคคลของท่านที่ [APP_NAME] เก็บไว้นั้นไม่ถูกต้องหรือไม่ครบถ้วนสมบูรณ์ ท่านอาจใช้สิทธิของท่าน เพื่อจำกัดการประมวลผลข้อมูลที่เกี่ยวข้องกับ [APP_NAME] ได้',
      'consent_needed': 'ขออภัย กรุณาส่งคำยินยอมของท่าน ก่อนทำรายการนี้',
      'baht': 'บาท',
      'fee_charge': 'ค่าธรรมเนียม',
      'policy_footer': 'ท่านสามารถดูรายละเอียดการจัดการข้อมูลส่วนบุคคลของระบบในนโยบายความเป็นส่วนตัวที่',
    }
  };

  static set language(String lang) {
    defaultLanguage = lang;
  }

  static String? get policy_footer {
    return _localizedValues[defaultLanguage]?['policy_footer'];
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

  static String get(String key) {
    return replaceAppName(_localizedValues[defaultLanguage]?[key] ?? "");
  }

  static String replaceAppName(String s) {
    return s.replaceAll(
        "[APP_NAME]",
        (defaultLanguage == "en")
            ? BeConsent.appNameEn ?? BeConsent.appNameTh ?? "-"
            : BeConsent.appNameTh ?? BeConsent.appNameEn ?? "-");
  }
}
