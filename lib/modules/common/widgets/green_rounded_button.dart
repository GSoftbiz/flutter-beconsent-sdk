import 'package:flutter/material.dart';
import 'package:flutter_beconsent_sdk/modules/common/widgets/rounded_button.dart';

class GreenRoundedButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String title;
  final bool active;

  const GreenRoundedButton({
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
        Color(0xFF8DD3C8),
        Color(0xFF5CA496),
      ],
    );
  }
}
