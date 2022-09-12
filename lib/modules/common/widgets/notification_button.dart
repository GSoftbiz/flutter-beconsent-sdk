import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_beconsent_sdk/images/images.dart';

class NotificationButton extends StatelessWidget {
  const NotificationButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      constraints: const BoxConstraints(),
      onPressed: () {},
      icon: SvgPicture.asset(
        CommonImages.buttonNotification,
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}
