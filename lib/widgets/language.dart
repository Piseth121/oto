import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LanguagePage extends StatelessWidget {
  LanguagePage({super.key});

  final RxString selectedLanguage = Get.locale?.languageCode.obs ?? 'en'.obs;

  void changeLanguage(String langCode) {
    final locale = Locale(langCode);
    Get.updateLocale(locale);
    selectedLanguage.value = langCode;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Language'.tr),
        shadowColor: Colors.red,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
        iconTheme: IconThemeData(color: Colors.black),

      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('English'),
            trailing: Obx(() => Card(
              child: selectedLanguage.value == 'en'
                  ? Icon(Icons.check, color: Colors.green)
                  : null,
            )),
            onTap: () => changeLanguage('en'),
          ),
          Divider(),
          ListTile(
            title: Text('Khmer (ខ្មែរ)', style: TextStyle(fontFamily: "battambang"),),
            trailing: Obx(() => Card(
              child: selectedLanguage.value == 'km'
                  ? Icon(Icons.check, color: Colors.green)
                  : null,
            )),
            onTap: () => changeLanguage('km'),
          ),
          Divider(),
          ListTile(
            title: Text('Chinese (中文)'),
            trailing: Obx(() => Card(
              child: selectedLanguage.value == 'zh'
                  ? Icon(Icons.check, color: Colors.green)
                  : null,
            )),
            onTap: () => changeLanguage('zh'),
          ),
        ],
      ),
    );
  }
}
