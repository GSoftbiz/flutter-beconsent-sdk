import 'package:flutter_beconsent_sdk/theme/app_theme.dart';
import 'package:flutter/material.dart';

class FButton extends StatelessWidget {
  FButton(
      {Key? key,
      required this.title,
      required this.onPressed,
      this.icon,
      this.textStyle,
      this.enable,
      this.padding,
      this.roundRadius,
      this.borderColor,
      this.backgroundColor})
      : super(key: key);
  TextStyle? textStyle;
  Color? backgroundColor;
  Color? foregroundColor;
  Color? borderColor;
  final String title;
  final GestureTapCallback onPressed;
  final Widget? icon;
  final double? padding;
  bool? enable = true;
  final double? roundRadius;
  double buttonRadius = 4;

  @override
  Widget build(BuildContext context) {
    if (backgroundColor != null) {
      foregroundColor = backgroundColor;
    } else {
      backgroundColor = AppTheme.themeData.primaryColor;
      foregroundColor = AppTheme.themeData.primaryColor;
    }
    if (roundRadius != null) {
      buttonRadius = roundRadius!;
    }
    return Container(
      height: 49,
      decoration: BoxDecoration(
        border: Border.all(color: borderColor??Colors.transparent),
        borderRadius: BorderRadius.circular(buttonRadius),
        boxShadow: const [
          BoxShadow(
            color: Colors.white,
            spreadRadius: 0,
            blurRadius: 30,
            offset: Offset(0, 5), // changes position of shadow
          ),
        ],
      ),
      child: TextButton(
        onPressed: enable ?? true ? onPressed : null,
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(foregroundColor!),
          backgroundColor: MaterialStateProperty.all<Color>(enable ?? true
              ? backgroundColor!
              : backgroundColor!.withAlpha(70)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(buttonRadius),
            ),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(left: padding ?? 0, right: padding ?? 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              (icon != null)
                  ? Container(
                      child: icon,
                    )
                  : Container(),
              (icon != null)
                  ? const SizedBox(
                      width: 8,
                    )
                  : Container(),
              Text(title,
                  style: (textStyle != null)
                      ? textStyle
                      : AppTheme.themeData.textTheme.bodyText2?.copyWith(
                          color: Colors.white, fontWeight: AppTheme.medium))
            ],
          ),
        ),
      ),
    );
  }
}
