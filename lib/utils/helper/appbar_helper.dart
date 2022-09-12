import 'package:flutter_beconsent_sdk/theme/app_dimension.dart';
import 'package:flutter_beconsent_sdk/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppBarHelper {
  static createAppBar(BuildContext context, String title,
      {Color backgroundColor = Colors.white, bool centerTitle = false}) {
    return AppBar(
      leading: GestureDetector(
        child: const Padding(
          padding: EdgeInsets.all(0),
          child: Icon(Icons.arrow_back_ios_rounded),
        ),
        onTap: () {
          Navigator.of(context).pop();
        },
      ),
      centerTitle: centerTitle,
      title: Text(
        title,
        style: AppTheme.themeData.textTheme.headline3,
      ),
      backgroundColor: backgroundColor,
      elevation: 0,
    );
  }

  static createAppBarWithRightAction(BuildContext context, String title,
      String rightIcon, GestureTapCallback onTab) {
    return AppBar(
      leading: GestureDetector(
        child: const Padding(
          padding: EdgeInsets.all(16),
          child: Icon(Icons.arrow_back_ios_rounded),
        ),
        onTap: () {
          Navigator.of(context).pop();
        },
      ),
      centerTitle: true,
      title: Text(
        title,
        style: AppTheme.themeData.textTheme.headline1,
      ),
      backgroundColor: Colors.white,
      elevation: 0,
      actions: [
        GestureDetector(
          child: Container(
            margin: const EdgeInsets.only(right: AppDimension.spaceM),
            child: SvgPicture.asset(rightIcon),
          ),
          onTap: () {
            onTab.call();
          },
        )
      ],
    );
  }

  static createLargeAppBar(BuildContext context, String title) {
    return AppBar(
      centerTitle: false,
      title: Text(
        title,
        style: AppTheme.themeData.textTheme.headline1,
      ),
      backgroundColor: Colors.white,
      elevation: 0,
    );
  }
}
