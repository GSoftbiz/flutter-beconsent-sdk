import 'package:flutter/material.dart';
import 'package:flutter_beconsent_sdk/modules/common/widgets/rounded_button.dart';

class BlueRoundedButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String title;
  final bool active;

  const BlueRoundedButton({
    Key? key,
    required this.onPressed,
    required this.title,
    this.active = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RoundedButton(
      onPressed: onPressed,
      title: title,
      active: active,
      activeColors: const [
        Color(0xFF0077BF),
        Color(0xFF004773),
      ],
    );
  }
}
