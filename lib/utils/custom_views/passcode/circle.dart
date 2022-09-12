import 'package:flutter_beconsent_sdk/theme/app_theme.dart';
import 'package:flutter/material.dart';

@immutable
class CircleUIConfig {
  static const _emptyColor = Color(0xFFD9D9D9);
  final Color borderColor;
  final Color fillColor;
  final Color emptyColor;
  final double borderWidth;
  final double circleSize;

  const CircleUIConfig({
    this.borderColor = Colors.white,
    this.borderWidth = 1,
    this.fillColor = Colors.white,
    this.emptyColor = _emptyColor,
    this.circleSize = 20,
  });
}

class Circle extends StatelessWidget {
  final bool filled;
  final CircleUIConfig circleUIConfig;
  final double extraSize;

  Circle({
    Key? key,
    this.filled = false,
    required this.circleUIConfig,
    this.extraSize = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: extraSize),
      width: circleUIConfig.circleSize,
      height: circleUIConfig.circleSize,
      decoration: BoxDecoration(
        color: filled ? circleUIConfig.fillColor : circleUIConfig.emptyColor,
        shape: BoxShape.circle,
        border: Border.all(
          color: circleUIConfig.borderColor,
          width: circleUIConfig.borderWidth,
        ),
      ),
    );
  }
}
