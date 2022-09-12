import 'package:flutter/material.dart';

class Config {
  final String baseURL;
  final List<Locale> supportedLocales;
  final Locale fallbackLocale;
  final String localizationPath;

  const Config({
    required this.baseURL,
    required this.supportedLocales,
    required this.fallbackLocale,
    this.localizationPath = 'assets/translations',
  });
}
