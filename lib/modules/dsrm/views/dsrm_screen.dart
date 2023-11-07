import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:country_calling_code_picker/country.dart';
import 'package:country_calling_code_picker/picker.dart';
import 'package:flutter_beconsent_sdk/core/localization/language_service.dart';
import 'package:flutter_beconsent_sdk/core/user_session/user_session.dart';
import 'package:flutter_beconsent_sdk/di/injector.dart';
import 'package:flutter_beconsent_sdk/modules/consent/beconsent.dart';
import 'package:flutter_beconsent_sdk/modules/consent/models/get_consent_detail_response.dart';
import 'package:flutter_beconsent_sdk/modules/dsrm/bloc/dsrm_bloc.dart';
import 'package:flutter_beconsent_sdk/modules/dsrm/models/create_dsrm_body.dart';
import 'package:flutter_beconsent_sdk/modules/dsrm/models/drsm_form_response.dart';
import 'package:flutter_beconsent_sdk/theme/app_dimension.dart';
import 'package:flutter_beconsent_sdk/theme/app_theme.dart';
import 'package:flutter_beconsent_sdk/utils/custom_views/f_button.dart';
import 'package:flutter_beconsent_sdk/utils/custom_views/f_textfield.dart';
import 'package:flutter_beconsent_sdk/utils/helper/alert_dialog_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:formz/formz.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

class DSRMScreen extends StatefulWidget {
  static const String route = '/dsrm';

  DSRMScreen({Key? key}) : super(key: key);

  State<DSRMScreen> createState() => _DSRMScreenState();
}

class _DSRMScreenState extends State<DSRMScreen> {
  final TextEditingController _additionalRequestOptionCtr =
      TextEditingController();
  final TextEditingController _requestDetailCtr = TextEditingController();
  final TextEditingController _idFirstNameCtr = TextEditingController();
  final TextEditingController _idLastNameCtr = TextEditingController();
  final TextEditingController _idEmailCtr = TextEditingController();
  final TextEditingController _idPhoneNumberCtr = TextEditingController();

  final TextEditingController _guardianFirstNameCtr = TextEditingController();
  final TextEditingController _guardianLastNameCtr = TextEditingController();
  final TextEditingController _guardianEmailCtr = TextEditingController();
  final TextEditingController _guardianPhoneNumberCtr = TextEditingController();
  final UserSession _userSession = Injector.instance.userSession;
  DSRMState? _state;
  String? _locale;
  SimpleFontelicoProgressDialog? _dialog;
  Country? _country1;
  Country? _country2;
  bool _guardianChecked = false;
  RightRequests? _rightRequest;
  Map<int, Map<int, bool>> _rightOptionsCheck = {};

  @override
  void initState() {
    _initCountry();
  }

  void _initCountry() async {
    final country = await getDefaultCountry(context);
    setState(() {
      _country1 = country;
      _country2 = country;
    });
    if (BeConsent.idFirstName != null) {
      _idFirstNameCtr.text = BeConsent.idFirstName!;
    }
    if (BeConsent.idLastName != null) {
      _idLastNameCtr.text = BeConsent.idLastName!;
    }
    if (BeConsent.idEmail != null) {
      _idEmailCtr.text = BeConsent.idEmail!;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_locale == null) {
      _locale = Localizations.localeOf(context).languageCode;
      LanguageService.language = _locale!;
    }
    _dialog ??=
        SimpleFontelicoProgressDialog(context: context, barrierDimisable: true);

    if (_state?.dsrmForm == null) {
      BlocProvider.of<DSRMBloc>(context).add(DSRMEventGetDSRMDetail());
    }

    return BlocListener<DSRMBloc, DSRMState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        _state = state;
        switch (state.status) {
          case FormzStatus.submissionInProgress:
            _dialog?.show(
                message: 'Loading...',
                type: SimpleFontelicoProgressDialogType.normal);
            break;
          case FormzStatus.submissionSuccess:
            _dialog?.hide();
            if (state.event is DSRMEventGetDSRMDetail) {
              setState(() {});
            }
            if (state.event is DSRMEventSubmitted) {
              AwesomeDialog(
                context: context,
                dialogType: DialogType.success,
                animType: AnimType.bottomSlide,
                title: LanguageService.success,
                dismissOnTouchOutside: false,
                headerAnimationLoop: false,
                dismissOnBackKeyPress: false,
                width: 260,
                autoHide: const Duration(seconds: 2),
                onDismissCallback: (s) {
                  Navigator.pop(context);
                },
                padding: const EdgeInsets.only(bottom: AppDimension.spaceM),
              ).show();
            }

            break;
          case FormzStatus.submissionFailure:
            _dialog?.hide();
            showAlertDialog(context, null, state.error?.message);
            break;
          default:
            _dialog?.hide();
            break;
        }
      },
      child: (_state?.dsrmForm == null)
          ? const SizedBox()
          : Scaffold(
              backgroundColor: AppTheme.colorSoftGray,
              body: SafeArea(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    child: const Padding(
                      padding: EdgeInsets.only(
                          top: AppDimension.spaceM,
                          left: AppDimension.spaceL,
                          right: AppDimension.spaceM),
                      child: Icon(Icons.cancel),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  Flexible(
                      flex: 1,
                      child: CustomScrollView(
                        slivers: [
                          SliverFillRemaining(
                            hasScrollBody: false,
                            child: _content(),
                          ),
                        ],
                      )),
                ],
              )),
            ),
    );
  }

  //Image.asset(const AssetImage("assets/images/logo.png").assetName, package: 'flutter_beconsent_sdk',)
  _content() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _block1Title(),
        _block2Identity(),
        _block3Rights(),
        (_rightRequest != null) ? _block4RightOptions() : const SizedBox(),
        (_rightRequest != null) ? _block5Last() : const SizedBox(),
      ],
    );
  }

  _line() {
    return Container(
      width: double.infinity,
      height: 1,
      color: AppTheme.colorTextFieldBorder,
    );
  }

  _block1Title() {
    return Container(
        color: AppTheme.colorSoftGray,
        padding: const EdgeInsets.only(
            left: AppDimension.spaceL,
            right: AppDimension.spaceL,
            top: AppDimension.spaceL,
            bottom: AppDimension.spaceL),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            (BeConsent.logoVisible)
                ? Center(
                    child: Stack(
                    children: [
                      (BeConsent.logo != null)
                          ? Image.asset(
                              AssetImage(BeConsent.logo!).assetName,
                              height: 100,
                            )
                          : Image.asset(
                              const AssetImage("assets/images/logo.png")
                                  .assetName,
                              package: 'flutter_beconsent_sdk',
                              height: 100,
                            )
                    ],
                  ))
                : const SizedBox(),
            (BeConsent.logoVisible)
                ? const SizedBox(
                    height: AppDimension.spaceL,
                  )
                : const SizedBox(),
            Text(
              LanguageService.get("dsrm_title"),
              style: AppTheme.themeData.textTheme.headline5,
            ),
            const SizedBox(
              height: AppDimension.spaceS,
            ),
            Text(
              LanguageService.get("dsrm_desc_1_1"),
              style: AppTheme.themeData.textTheme.bodyText2,
            ),
            Padding(
              padding: const EdgeInsets.only(left: AppDimension.spaceM),
              child: Text(
                LanguageService.get("dsrm_desc_1_2"),
                style: AppTheme.themeData.textTheme.bodyText2,
              ),
            ),
            Text(
              LanguageService.get("dsrm_desc_1_3"),
              style: AppTheme.themeData.textTheme.bodyText2,
            ),
          ],
        ));
  }

  _block2Identity() {
    return Container(
        color: Colors.white,
        padding: const EdgeInsets.only(
            left: AppDimension.spaceL,
            right: AppDimension.spaceL,
            top: AppDimension.spaceL,
            bottom: AppDimension.spaceL),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              LanguageService.get("dsrm_title_2"),
              style: AppTheme.themeData.textTheme.headline5,
            ),
            const SizedBox(
              height: AppDimension.spaceS,
            ),
            Text(
              LanguageService.get("dsrm_desc_2"),
              style: AppTheme.themeData.textTheme.bodyText2,
            ),
            const SizedBox(
              height: AppDimension.spaceM,
            ),
            FTextField(
              controller: _idFirstNameCtr,
              title: LanguageService.get("first_name"),
            ),
            const SizedBox(
              height: AppDimension.spaceS,
            ),
            FTextField(
              controller: _idLastNameCtr,
              title: LanguageService.get("last_name"),
            ),
            const SizedBox(
              height: AppDimension.spaceS,
            ),
            FTextField(
              controller: _idEmailCtr,
              title: LanguageService.get("email"),
            ),
            const SizedBox(
              height: AppDimension.spaceS,
            ),
            FTextField(
              controller: _idPhoneNumberCtr,
              title: LanguageService.get("phone_number"),
            ),
            /*Text(
              LanguageService.get("country"),
              style: AppTheme.themeData.textTheme.bodyText2,
            ),
            const SizedBox(
              height: AppDimension.spaceS,
            ),
            (_country1 != null)
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
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8))),
                      child: GestureDetector(
                        onTap: () async {
                          final country = await showCountryPickerSheet(context,
                              cancelWidget: const SizedBox());
                          if (country != null) {
                            setState(() {
                              _country1 = country;
                            });
                          }
                        },
                        child: Row(
                          children: [
                            Image.asset(
                              _country1!.flag,
                              package: countryCodePackageName,
                              height: 20,
                            ),
                            const SizedBox(
                              width: AppDimension.spaceM,
                            ),
                            Expanded(
                                flex: 1,
                                child: Text(
                                  _country1!.name,
                                  style: AppTheme.themeData.textTheme.bodyText2,
                                )),
                            const Icon(Icons.keyboard_arrow_down_rounded)
                          ],
                        ),
                      ),
                    ))
                : const SizedBox(),
            const SizedBox(
              height: AppDimension.spaceM,
            ),*/
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Checkbox(
                  value: _guardianChecked,
                  onChanged: (c) {
                    setState(() {
                      _guardianChecked = c!;
                    });
                  },
                ),
                Flexible(
                    child: Text(
                  LanguageService.get("dsrm_check_box_desc"),
                  style: AppTheme.themeData.textTheme.bodyText1
                      ?.copyWith(color: AppTheme.colorSlate),
                ))
              ],
            ),
            (_guardianChecked == false)
                ? const SizedBox()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: AppDimension.spaceM,
                      ),
                      Text(
                        LanguageService.get("dsrm_guardian_title"),
                        style: AppTheme.themeData.textTheme.bodyText2,
                      ),
                      const SizedBox(
                        height: AppDimension.spaceM,
                      ),
                      FTextField(
                        controller: _guardianFirstNameCtr,
                        title: LanguageService.get("first_name"),
                      ),
                      const SizedBox(
                        height: AppDimension.spaceS,
                      ),
                      FTextField(
                        controller: _guardianLastNameCtr,
                        title: LanguageService.get("last_name"),
                      ),
                      const SizedBox(
                        height: AppDimension.spaceS,
                      ),
                      FTextField(
                        controller: _guardianEmailCtr,
                        title: LanguageService.get("email"),
                      ),
                      const SizedBox(
                        height: AppDimension.spaceS,
                      ),
                      FTextField(
                        controller: _guardianPhoneNumberCtr,
                        title: LanguageService.get("phone_number"),
                      ),
                      /*
                      Text(
                        LanguageService.get("country"),
                        style: AppTheme.themeData.textTheme.bodyText2,
                      ),
                      const SizedBox(
                        height: AppDimension.spaceS,
                      ),
                      (_country2 != null)
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
                                        Radius.circular(8))),
                                child: GestureDetector(
                                  onTap: () async {
                                    final country =
                                        await showCountryPickerSheet(context,
                                            cancelWidget: const SizedBox());
                                    if (country != null) {
                                      setState(() {
                                        _country2 = country;
                                      });
                                    }
                                  },
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        _country2!.flag,
                                        package: countryCodePackageName,
                                        height: 20,
                                      ),
                                      const SizedBox(
                                        width: AppDimension.spaceM,
                                      ),
                                      Expanded(
                                          flex: 1,
                                          child: Text(
                                            _country2!.name,
                                            style: AppTheme
                                                .themeData.textTheme.bodyText2,
                                          )),
                                      const Icon(
                                          Icons.keyboard_arrow_down_rounded)
                                    ],
                                  ),
                                ),
                              ))
                          : const SizedBox()*/
                    ],
                  )
          ],
        ));
  }

  _block3Rights() {
    return Container(
        padding: const EdgeInsets.only(
            left: AppDimension.spaceL,
            right: AppDimension.spaceL,
            top: AppDimension.spaceL,
            bottom: AppDimension.spaceL),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              LanguageService.get("dsrm_title_3"),
              style: AppTheme.themeData.textTheme.headline5,
            ),
            const SizedBox(
              height: AppDimension.spaceS,
            ),
            Text(
              LanguageService.get("dsrm_desc_3"),
              style: AppTheme.themeData.textTheme.bodyText2,
            ),
            const SizedBox(
              height: AppDimension.spaceS,
            ),
            Column(
              children: _rightsWidgets(),
            )
          ],
        ));
  }

  List<Widget> _rightsWidgets() {
    List<Widget> items = <Widget>[];
    for (var element in _state!.dsrmForm!.rightRequests) {
      items.add(const SizedBox(
        height: AppDimension.spaceS,
      ));
      items.add(_rightWidget(element));
      items.add(const SizedBox(
        height: AppDimension.spaceS,
      ));
    }
    return items;
  }

  _rightWidget(RightRequests rightRequest) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _rightRequest = rightRequest;
        });
      },
      child: Container(
        padding: const EdgeInsets.only(
            left: AppDimension.spaceM, right: AppDimension.spaceM),
        height: 49,
        decoration: BoxDecoration(
            color: (_rightRequest == rightRequest)
                ? AppTheme.themeData.primaryColor?.withAlpha(16)
                : Colors.transparent,
            border: Border.all(
              width: 1,
              color: (_rightRequest == rightRequest)
                  ? AppTheme.themeData.primaryColor
                  : AppTheme.colorTextFieldBorder,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(30))),
        child: GestureDetector(
          onTap: () async {},
          child: Row(
            children: [
              (_rightRequest == rightRequest)
                  ? Icon(Icons.check, color: AppTheme.themeData.primaryColor)
                  : const SizedBox(),
              (_rightRequest == rightRequest)
                  ? const SizedBox(
                      width: AppDimension.spaceS,
                    )
                  : const SizedBox(),
              GestureDetector(
                child: Text(
                  rightRequest.getTitle(context),
                  style: AppTheme.themeData.textTheme.bodyText2?.copyWith(
                      color: (_rightRequest == rightRequest)
                          ? AppTheme.themeData.primaryColor
                          : Colors.black),
                ),
                onTap: () {
                  setState(() {
                    _rightRequest = rightRequest;
                  });
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  _block4RightOptions() {
    return Container(
        color: Colors.white,
        padding: const EdgeInsets.only(
            left: AppDimension.spaceL,
            right: AppDimension.spaceL,
            top: AppDimension.spaceL,
            bottom: AppDimension.spaceL),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              LanguageService.get("dsrm_title_4"),
              style: AppTheme.themeData.textTheme.headline5,
            ),
            const SizedBox(
              height: AppDimension.spaceS,
            ),
            Column(
              children: _rightOptionsWidgets(),
            ),
            (_rightOptionsCheck[_rightRequest!.id]?[-1] == true)
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: AppDimension.spaceS,
                      ),
                      Text(LanguageService.get("other_request"),
                          style: AppTheme.themeData.textTheme.bodyText2
                              ?.copyWith(fontWeight: FontWeight.bold)),
                      FTextField(
                        controller: _additionalRequestOptionCtr,
                        placeholder:
                            LanguageService.get("please_provide_detail"),
                        multiline: true,
                      ),
                      const SizedBox(
                        height: AppDimension.spaceM,
                      )
                    ],
                  )
                : const SizedBox(),
            const SizedBox(
              height: AppDimension.spaceM,
            ),
            Text(
              LanguageService.get("dsrm_desc_4"),
              style: AppTheme.themeData.textTheme.bodyText2,
            ),
            const SizedBox(
              height: AppDimension.spaceS,
            ),
            Text(LanguageService.get("provide_detail"),
                style: AppTheme.themeData.textTheme.headline5),
            FTextField(
              controller: _requestDetailCtr,
              placeholder: LanguageService.get("please_provide_detail"),
              multiline: true,
            ),
            const SizedBox(
              height: AppDimension.spaceL,
            ),
            Text(LanguageService.get("dsrm_desc_4_2"),
                style: AppTheme.themeData.textTheme.bodyText2)
          ],
        ));
  }

  List<Widget> _rightOptionsWidgets() {
    List<Widget> items = <Widget>[];
    var i = 0;
    for (var element in _rightRequest!.options) {
      items.add(const SizedBox(
        height: 12,
      ));
      items.add(_rightOptionWidget(i, element));
      items.add(const SizedBox(
        height: 12,
      ));
      items.add(_line());
      i++;
    }

    items.add(const SizedBox(
      height: 12,
    ));
    items.add(_rightOptionWidget(
        -1,
        Options(
            name: OptionName(
                en: "Please provide details of others request",
                th: "อื่นๆ โปรดระบุ "),
            enable: true)));
    items.add(const SizedBox(
      height: 12,
    ));
    items.add(_line());

    return items;
  }

  _rightOptionWidget(int id, Options option) {
    return Container(
      padding: const EdgeInsets.only(left: 0, right: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Checkbox(
            value: _rightOptionsCheck[_rightRequest!.id]?[id] == true,
            onChanged: (c) {
              setState(() {
                setOptionChecked(_rightRequest!.id, id, c!);
              });
            },
          ),
          Flexible(
              child: GestureDetector(
            child: Text(
              option.getTitle(context),
              style: AppTheme.themeData.textTheme.bodyText2,
            ),
            onTap: () {
              var isChecked =
                  _rightOptionsCheck[_rightRequest!.id]?[id] == true;
              setState(() {
                setOptionChecked(_rightRequest!.id, id, !isChecked);
              });
            },
          ))
        ],
      ),
    );
  }

  void setOptionChecked(int rightId, int optionId, bool checked) {
    var options = _rightOptionsCheck[rightId];
    options ??= {};
    options[optionId] = checked;
    _rightOptionsCheck[rightId] = options;
  }

  _block5Last() {
    return Container(
        color: AppTheme.themeData.primaryColor?.withAlpha(40),
        padding: const EdgeInsets.only(
            left: AppDimension.spaceL,
            right: AppDimension.spaceL,
            top: AppDimension.spaceL,
            bottom: AppDimension.spaceL),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            FButton(
              roundRadius: 30,
              title: LanguageService.get("submit"),
              onPressed: () {
                _submit();
              },
            ),
            Column(
              children: [
                const SizedBox(
                  height: AppDimension.spaceS,
                ),
                (_rightRequest!.hasFeeCharge &&
                        _rightRequest!.feeChargeAmount != null &&
                        _rightRequest!.feeChargeAmount! > 0)
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${LanguageService.get("fee_charge")} :",
                            style: AppTheme.themeData.textTheme.bodyText2
                                ?.copyWith(color: AppTheme.colorSlate),
                          ),
                          Text(
                              "${_rightRequest!.feeChargeAmount} ${LanguageService.get("baht")}",
                              style: AppTheme.themeData.textTheme.bodyText2
                                  ?.copyWith(color: AppTheme.colorFee))
                        ],
                      )
                    : const SizedBox()
              ],
            ),
            const SizedBox(
              height: AppDimension.spaceS,
            ),
            Text(
              LanguageService.get("last"),
              style: AppTheme.themeData.textTheme.bodyText1,
            ),
          ],
        ));
  }

  void _submit() {
    if (_userSession.collectionChannel == "") {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.warning,
        animType: AnimType.bottomSlide,
        title: LanguageService.get("consent_needed"),
        dismissOnTouchOutside: true,
        headerAnimationLoop: false,
        dismissOnBackKeyPress: true,
        //width: 260,
        //autoHide: const Duration(seconds: 2),
        onDismissCallback: (s) {},
        btnOkColor: AppTheme.themeData.primaryColor,
        btnOkOnPress: () {},
        padding: const EdgeInsets.all(AppDimension.spaceM),
      ).show();
      return;
    }
    if(_guardianChecked){
      if(_guardianFirstNameCtr.text.isEmpty){
        showAlertDialog(context, null,LanguageService.get("validate_name"));
        return;
      }
      if(_guardianEmailCtr.text.isEmpty){
        showAlertDialog(context, null,LanguageService.get("validate_email"));
        return;
      }
    }
    List<int> selectedRightRequestOptions = <int>[];
    _rightOptionsCheck[_rightRequest!.id]?.keys?.forEach((element) {
      selectedRightRequestOptions.add(element);
    });
    CreateDSRMBody body = CreateDSRMBody(
        additionalRequestOption: _additionalRequestOptionCtr.text,
        collectionChannel: _userSession.collectionChannel,
        dsrmRequestFormId: _state?.dsrmForm?.dsrmRequestFormId ?? 0,
        dsrmRequestFormUUID: BeConsent.dsrmFormID ?? "",
        dsrmRequestFormVersion: _state?.dsrmForm?.version ?? "",
        identityValidation: IdentityValidation(
            firstName: _idFirstNameCtr.text,
            lastName: _idLastNameCtr.text,
            email: _idEmailCtr.text,
            country: "",
            phoneNumber: _idPhoneNumberCtr.text),
        guardianInformation: GuardianInformation(
            firstName: _guardianFirstNameCtr.text,
            lastName: _guardianLastNameCtr.text,
            email: _guardianEmailCtr.text,
            country: "",
            phoneNumber: _guardianPhoneNumberCtr.text),
        hasGuardian: _guardianChecked,
        requestDetail: _requestDetailCtr.text,
        rightRequestId: _rightRequest?.id ?? 0,
        rightRequestUUID: _rightRequest?.uuid ?? "",
        selectedRightRequestOptions: selectedRightRequestOptions,
        uid: BeConsent.uuid ?? "");
    BlocProvider.of<DSRMBloc>(context).add(DSRMEventSubmitted(body));
  }
}
