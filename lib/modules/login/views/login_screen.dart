/*
import 'dart:ui';

import 'package:country_calling_code_picker/picker.dart';
import 'package:flutter_beconsent_sdk/images/images.dart';
import 'package:flutter_beconsent_sdk/theme/app_dimension.dart';
import 'package:flutter_beconsent_sdk/theme/app_theme.dart';
import 'package:flutter_beconsent_sdk/utils/helper/alert_dialog_helper.dart';
import 'package:flutter_beconsent_sdk/utils/custom_views/f_button.dart';
import 'package:flutter_beconsent_sdk/utils/helper/textfield_helper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';
import 'package:formz/formz.dart';
class LoginScreen extends StatefulWidget {
  static const String route = '/login';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Country? country;

  @override
  void initState() {
    _initCountry();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        switch (state.status) {
          case FormzStatus.submissionInProgress:
            EasyLoading.show(status: 'common.loading'.tr());
            break;
          case FormzStatus.submissionSuccess:
            EasyLoading.dismiss();
            if(state.event is LoginEventLoginSocial){
              //Navigator.pushNamed(context, UpdateMeScreen.route);
            }
            if(state.event is LoginEventRequestOTP){
              */
/*Navigator.of(context).pushNamed(VerifyOTPScreen.route,
                  arguments:
                  VerifyOTPScreenArguments(state.otpRef, state.phoneNumber));*//*

            }

            break;
          case FormzStatus.submissionFailure:
            EasyLoading.dismiss();
            showAlertDialog(context, null, state.error?.message);
            break;
          default:
            EasyLoading.dismiss();
            break;
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                  child: _content(),
                  padding: const EdgeInsets.only(
                      left: AppDimension.spaceL,
                      right: AppDimension.spaceL,
                      top: AppDimension.spaceM,
                      bottom: AppDimension.spaceM)),
            ),
          ],
        )),
      ),
    );
  }

  _content() {
    return Column(
      children: [
        Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
               Image.asset(const AssetImage("assets/images/logo.png").assetName, package: 'flutter_beconsent_sdk',)
              ,
              ],
            )),
        Expanded(
            flex: 1,
            child: Column(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    (country != null)
                        ? Flexible(
                            flex: 0,
                            child: Container(
                              padding: const EdgeInsets.only(
                                  left: AppDimension.spaceM,
                                  right: AppDimension.spaceM),
                              height: 49,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1,
                                    color: AppTheme.colorTextFieldBorder,
                                  ),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(30))),
                              child: GestureDetector(
                                onTap: () async {
                                  final country = await showCountryPickerSheet(
                                    context,
                                  );
                                  if (country != null) {
                                    setState(() {
                                      this.country = country;
                                    });
                                  }
                                },
                                child: Row(
                                  children: [
                                    Image.asset(
                                      country!.flag,
                                      package: countryCodePackageName,
                                      height: 20,
                                    ),
                                    const SizedBox(
                                      width: AppDimension.spaceS,
                                    ),
                                    Text(
                                      country!.callingCode,
                                      style: AppTheme
                                          .themeData.textTheme.bodyText2,
                                    ),
                                    const Icon(
                                        Icons.keyboard_arrow_down_rounded)
                                  ],
                                ),
                              ),
                            ))
                        : const SizedBox(),
                    const SizedBox(
                      width: AppDimension.spaceM,
                    ),
                    Flexible(
                        flex: 1,
                        child: SizedBox(
                          height: 49,
                          child: TextFieldHelper.createRound30(context,
                              hint: "กรอกเบอร์โทรศัพท์",
                              keyboardType: TextInputType.number,
                              maxLength: 10, onChanged: (value) {
                            BlocProvider.of<LoginBloc>(context)
                                .add(LoginEventPhoneNumberChanged(value));
                          }),
                        ))
                  ],
                ),
                const SizedBox(height: AppDimension.spaceL),
                FButton(
                    title: "เข้าสู่ระบบ",
                    roundRadius: AppDimension.roundL,
                    onPressed: () {
                      BlocProvider.of<LoginBloc>(context)
                          .add(LoginEventRequestOTP(country!.callingCode));
                    })
              ],
            )),
        Expanded(
            flex: 2,
            child: Column(
              children: [
                Flexible(
                    child: Row(
                  children: [
                    Flexible(
                        child: Container(
                      height: 1,
                      color: AppTheme.colorTextFieldBorder,
                    )),
                    const SizedBox(width: AppDimension.spaceS),
                    Flexible(
                        flex: 0,
                        child: Text(
                          "หรือเชื่อมต่อกับโซเชียลมีเดียอื่น",
                          style: AppTheme.themeData.textTheme.bodyText2
                              ?.copyWith(color: Colors.grey),
                        )),
                    const SizedBox(width: AppDimension.spaceS),
                    Flexible(
                        child: Container(
                      height: 1,
                      color: AppTheme.colorTextFieldBorder,
                    )),
                  ],
                )),
                const SizedBox(
                  height: 64,
                ),
                FButton(
                    icon: SvgPicture.asset(LoginImages.icApple),
                    title: "ดำเนินการต่อด้วย Apple",
                    roundRadius: AppDimension.roundL,
                    backgroundColor: Colors.black,
                    onPressed: () {
                      BlocProvider.of<LoginBloc>(context)
                          .add(LoginEventLoginSocial(TypeSocial.APPLE));
                    }),
                const SizedBox(
                  height: AppDimension.spaceM,
                ),
                FButton(
                    icon: SvgPicture.asset(LoginImages.icGoogle),
                    title: "ดำเนินการต่อด้วย Google",
                    roundRadius: AppDimension.roundL,
                    borderColor: AppTheme.colorTextFieldBorder,
                    backgroundColor: Colors.white,
                    textStyle: AppTheme.themeData.textTheme.bodyText2,
                    onPressed: () {
                      BlocProvider.of<LoginBloc>(context)
                          .add(LoginEventLoginSocial(TypeSocial.GOOGLE));
                    }),
                const SizedBox(
                  height: AppDimension.spaceM,
                ),
                FButton(
                    icon: SvgPicture.asset(LoginImages.icFacebook),
                    title: "ดำเนินการต่อด้วย Facebook",
                    roundRadius: AppDimension.roundL,
                    backgroundColor: AppTheme.colorFacebook,
                    onPressed: () {
                      BlocProvider.of<LoginBloc>(context)
                          .add(LoginEventLoginSocial(TypeSocial.FACEBOOK));
                    })
              ],
            )),
      ],
    );
  }

  void _initCountry() async {
    final country = await getDefaultCountry(context);
    setState(() {
      this.country = country;
    });
  }


}
*/
