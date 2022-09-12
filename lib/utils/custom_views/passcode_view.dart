import 'package:flutter_beconsent_sdk/theme/app_theme.dart';
import 'package:flutter_beconsent_sdk/utils/custom_views/passcode/circle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shake_animated/flutter_shake_animated.dart';
typedef CompleteCallback = void Function(String text);

class PassCodeView extends StatelessWidget {
  late BuildContext context;
  PasscodeController? controller;
  CircleUIConfig? circleUIConfig;
  late CircleUIConfig circleUIErrConfig;
  int? passwordDigits = 6;
  bool autoPlay = false;
  bool error = false;
  String? passcode;
  String? errorMessage;
  CompleteCallback? completeCallback;

  PassCodeView(
      {Key? key,
      this.circleUIConfig,
      this.passwordDigits,
      this.controller,
      this.errorMessage,
      this.passcode,
      this.completeCallback})
      : super(key: key);

  String enteredPasscode = '';

  @override
  Widget build(BuildContext context) {
    circleUIErrConfig = CircleUIConfig(
        borderWidth: 1,
        borderColor: AppTheme.colorBitchRed,
        circleSize: circleUIConfig!.circleSize,
        fillColor: AppTheme.colorBitchRed);
    this.context = context;
    controller?.setView(this);
    return ShakeWidget(
      duration: const Duration(milliseconds: 3000),
      shakeConstant: ShakeHorizontalConstant2(),
      autoPlay: autoPlay,
      child: _builder(),
    );
  }

  void setPassCode(String text) {
    error = false;
    enteredPasscode = text;
    (context as Element).markNeedsBuild();
    if (enteredPasscode.length == passwordDigits) {
      if (passcode != null) {
        if (enteredPasscode != passcode) {
          autoPlay = true;
          delayStopShake();
        }else{
          completeCallback?.call(enteredPasscode);
        }
      } else {
        completeCallback?.call(enteredPasscode);
      }
    }
  }

  Future<void> delayStopShake() async {
    await Future.delayed(const Duration(milliseconds: 400));
    autoPlay = false;
    error = true;
    (context as Element).markNeedsBuild();
  }

  _builder() => Column(
        children: [
          Text(
            (error) ? errorMessage! : "",
            style: AppTheme.themeData.textTheme.bodyText1
                ?.copyWith(color: AppTheme.colorBitchRed),
          ),
          const SizedBox(
            height: 16,
          ),
          SizedBox(
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _buildCircles(),
            ),
          )
        ],
      );

  List<Widget> _buildCircles() {
    var list = <Widget>[];
    var config = error ? circleUIErrConfig : circleUIConfig;
    var extraSize = 0.0; //animation.value;
    for (int i = 0; i < passwordDigits!; i++) {
      list.add(
        Container(
          margin: const EdgeInsets.all(8),
          child: Circle(
            filled: i < enteredPasscode.length,
            circleUIConfig: config!,
            extraSize: extraSize,
          ),
        ),
      );
    }
    return list;
  }
}

class PasscodeController {
  PassCodeView? view;

  void setView(PassCodeView view) {
    this.view = view;
  }

  void setPassCode(String text) {
    debugPrint("setPassCode1 : " + text);
    view?.setPassCode(text);
  }
}
