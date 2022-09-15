// Styling inspire from https://github.com/flutter/gallery/blob/master/lib/themes/gallery_theme_data.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const FontWeight extraLight = FontWeight.w200;
  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;

  static const colorSlate = Color(0xFF57697B);
  static const colorFee = Color(0xFF106EBA);
  static const colorSoftGray = Color(0xFFF6F6F6);
  static const colorTextFieldBorder = Color(0xFFDFE1E6);
  static const colorTextHint = Color(0x99676767);
  static const colorFacebook = Color(0xFF007AFF);
  static const colorBitchRed = Color(0xFFFF3B30);

  static const _highlightColor = Color(0x80F15A27);
  static Color _primaryColor = Color(0xFF007AFF);
  static const _textColor = Color(0xFF000000);
  static final _subtitle1 = const TextStyle(
    fontWeight: medium,
    color: _textColor,
    fontSize: 12.0,
  );
  static const double _tabbarIconSize = 25;

  static setPrimaryColor(Color color){
    _primaryColor = color;
  }
  static final TextTheme _textTheme = TextTheme(
    headline1: const TextStyle(
      fontWeight: semiBold,
      color: _textColor,
      fontSize: 30.0,
    ),
    headline2: const TextStyle(
      fontWeight: semiBold,
      color: _textColor,
      fontSize: 28.0,
    ),
    headline3: const TextStyle(
      fontWeight: medium,
      color: _textColor,
      fontSize: 22.0,
    ),
    headline4: const TextStyle(
      fontWeight: bold,
      color: _textColor,
      fontSize: 20.0,
    ),
    headline5: const TextStyle(
      fontWeight: bold,
      color: _textColor,
      fontSize: 18.0,
    ),
    headline6: const TextStyle(
      fontWeight: medium,
      fontSize: 16.0,
      color: _textColor,
    ),
    bodyText1: const TextStyle(
      fontWeight: regular,
      fontSize: 14.0,
      color: _textColor,
    ),
    bodyText2: const TextStyle(
      fontWeight: regular,
      fontSize: 16.0,
      color: _textColor,
    ),
    caption: const TextStyle(
      fontWeight: semiBold,
      color: _textColor,
      fontSize: 16.0,
    ),
    subtitle1: _subtitle1,
    subtitle2: const TextStyle(
      fontWeight: regular,
      fontSize: 12.0,
      color: _textColor,
    ),
    overline: const TextStyle(
      fontWeight: medium,
      color: _textColor,
      fontSize: 12.0,
    ),
    button: const TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 14.0,
      color: _textColor,
    ),
  );

  static ThemeData get themeData => ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF3F3F4),
        textTheme: _textTheme,
        highlightColor: _highlightColor,
        fontFamily: 'Kanit',
        primaryColor: _primaryColor,
        backgroundColor: const Color(0xFFFFFFFF),
        dividerColor: const Color(0xFFEEEEEE),
        hintColor: const Color(0xFF999999),
        appBarTheme: _appBarTheme,
        textSelectionTheme:  TextSelectionThemeData(
          cursorColor: _primaryColor,
          selectionColor: _primaryColor,
          selectionHandleColor: _primaryColor,
        ),
        bottomNavigationBarTheme: _bottomNavigationBarTheme,
      );

  static AppBarTheme get _appBarTheme => AppBarTheme(
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        titleTextStyle: _textTheme.headline6,
        color: Colors.white,
        elevation: 1,
        centerTitle: true,
      );

  static BottomNavigationBarThemeData get _bottomNavigationBarTheme =>
      BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
        unselectedLabelStyle: _subtitle1,
        selectedLabelStyle: _subtitle1,
        selectedItemColor: _highlightColor,
        selectedIconTheme: const IconThemeData(
          color: _highlightColor,
          size: _tabbarIconSize,
        ),
        unselectedIconTheme: const IconThemeData(
          size: _tabbarIconSize,
        ),
      );
}
