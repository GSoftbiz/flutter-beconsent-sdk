import 'package:flutter_beconsent_sdk/theme/app_dimension.dart';
import 'package:flutter_beconsent_sdk/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../images/images.dart';


class FTextField extends StatelessWidget {
  final Color _focusedBorderColor = AppTheme.themeData.primaryColor;
  final Color _borderColor = AppTheme.colorTextFieldBorder;
  final String? title;
  final TextEditingController? controller;
  final TextInputFormatter? textInputFormatter;
  final ValueChanged<String>? onChanged;
  String? placeholder;
  int? lengthLimit;
  bool? multiline;
  bool? optional;
  TextInputType? inputType;
  bool? enable = true;
  bool? obscureText = false;
  Color? backgroundColor = Colors.white;
  Color? focusedBorderColor;
  Color? borderColor;
  TextStyle? hintStyle = AppTheme.themeData.textTheme.bodyText2;
  FocusNode? focus;
  bool? showCursor = true;
  bool? readOnly = false;
  bool? showVisibleToggle = false;

  //bool? visible = false;

  FTextField(
      {Key? key,
      this.title,
      this.placeholder,
      this.controller,
      this.textInputFormatter,
      this.onChanged,
      this.lengthLimit,
      this.multiline,
      this.optional,
      this.inputType,
      this.enable,
      this.obscureText,
      this.backgroundColor,
      this.focusedBorderColor,
      this.borderColor,
      this.hintStyle,
      this.focus,
      this.showCursor,
      this.readOnly,
      this.showVisibleToggle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<TextInputFormatter> textInputFormatters = [];
    if (textInputFormatter != null) {
      textInputFormatters.add(textInputFormatter!);
    }
    if (lengthLimit != null) {
      textInputFormatters.add(LengthLimitingTextInputFormatter(lengthLimit));
    }

    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          (title != null)
              ? Row(
                  children: [
                    Text(
                      title ?? "",
                      style: AppTheme.themeData.textTheme.bodyText2,
                    ),
                    const SizedBox(
                      width: AppDimension.spaceS,
                    ),
                    (optional != null && optional!)
                        ? Text(
                            "",
                            style: AppTheme.themeData.textTheme.bodyText2,
                          )
                        : const SizedBox()
                  ],
                )
              : const SizedBox(),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            child: _textField(context, textInputFormatters),
            height: multiline ?? false ? 120 : 49,
          ),
        ]);
  }

  _textField(
      BuildContext context, List<TextInputFormatter> textInputFormatters) {
    return TextField(
      showCursor: showCursor,
      style: AppTheme.themeData.textTheme.bodyText2?.copyWith(fontSize: 18),
      readOnly: readOnly ?? false,
      obscureText: obscureText ?? false,
      onChanged: onChanged,
      enabled: enable,
      keyboardType: inputType ?? TextInputType.text,
      maxLines: multiline ?? false ? 120 : 1,
      inputFormatters: textInputFormatters,
      controller: controller,
      focusNode: focus,
      decoration: InputDecoration(
          suffixIcon: (showVisibleToggle == true)
              ? GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.all(AppDimension.spaceS),
                    child: SvgPicture.asset(
                      (obscureText == true)
                          ? CommonImages.icPasswordVisible
                          : CommonImages.icPasswordInvisible,
                    ),
                  ),
                  onTap: () {
                    if (obscureText != null) {
                      obscureText = !obscureText!;
                      (context as Element).markNeedsBuild();
                    }
                  },
                )
              : null,
          hintText: placeholder,
          hintStyle:
              hintStyle ?? AppTheme.themeData.textTheme.bodyText2?.copyWith(color: Colors.grey),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
          fillColor: enable ?? true
              ? (backgroundColor ?? Colors.white)
              : borderColor,
          filled: true,
          disabledBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: borderColor??_borderColor),
              borderRadius: BorderRadius.circular(8)),
          enabledBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: borderColor??_borderColor),
              borderRadius: BorderRadius.circular(8)),
          focusedBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: focusedBorderColor??_focusedBorderColor),
              borderRadius: BorderRadius.circular(8)),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
    );
  }
}
