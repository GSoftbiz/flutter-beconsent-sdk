import 'package:flutter_beconsent_sdk/theme/app_dimension.dart';
import 'package:flutter_beconsent_sdk/theme/app_theme.dart';
import 'package:flutter/material.dart';

class TextFieldHelper {
  static createRound30(BuildContext context,
      {String? hint,
      TextInputType keyboardType = TextInputType.text,
      ValueChanged<String>? onChanged,
        int? maxLength}) {
    return TextField(
      keyboardType: keyboardType,
      maxLength: maxLength,
      style: AppTheme.themeData.textTheme.bodyText2,
      onChanged: onChanged,
      decoration: InputDecoration(
          counterText: "",
          contentPadding: const EdgeInsets.symmetric(
              vertical: 0.0, horizontal: AppDimension.spaceM),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimension.roundL),
              borderSide: const BorderSide(
                  color: AppTheme.colorTextFieldBorder, width: 1.0)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimension.roundL),
              borderSide: BorderSide(
                  color: AppTheme.themeData.primaryColor, width: 1.0)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimension.roundL),
              borderSide: const BorderSide(
                  color: AppTheme.colorTextFieldBorder, width: 1.0)),
          filled: true,
          hintStyle: AppTheme.themeData.textTheme.bodyText2?.copyWith(
              color: AppTheme.colorTextHint, fontWeight: AppTheme.light),
          hintText: hint,
          fillColor: Colors.white),
    );
  }
}
