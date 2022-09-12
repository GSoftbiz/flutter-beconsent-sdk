import 'package:flutter/material.dart';
import 'package:flutter_beconsent_sdk/configs/app_configs.dart';
import 'package:flutter_beconsent_sdk/main.dart';

void main() {
  run(
    const Config(
      baseURL: '',
      supportedLocales: [
        Locale('en', ''),
        Locale('th', ''),
      ],
      fallbackLocale: Locale('en', ''),
    ),
  );
}
