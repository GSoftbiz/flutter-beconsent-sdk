import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_beconsent_sdk/core/localization/language_service.dart';
import 'package:flutter_beconsent_sdk/modules/consent/bloc/consent_bloc.dart';
import 'package:flutter_beconsent_sdk/modules/consent/models/get_consent_detail_response.dart';
import 'package:flutter_beconsent_sdk/theme/app_dimension.dart';
import 'package:flutter_beconsent_sdk/theme/app_theme.dart';
import 'package:flutter_beconsent_sdk/utils/custom_views/f_button.dart';
import 'package:flutter_beconsent_sdk/utils/helper/alert_dialog_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:formz/formz.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';
import 'package:url_launcher/url_launcher.dart';

class ConsentScreen extends StatefulWidget {
  static const String route = '/consent';
  bool? forceShow;

  ConsentScreen({Key? key, this.forceShow}) : super(key: key);

  State<ConsentScreen> createState() => _ConsentScreenState();
}

class _ConsentScreenState extends State<ConsentScreen> {
  late BuildContext _context;
  SimpleFontelicoProgressDialog? _dialog;
  GetConsentDetailResponse? _consentDetail;
  bool _allChecked = true;
  Map<int, bool> _purposeChecked = {};
  String? _locale;
  FToast? fToast;

  @override
  void initState() {
    super.initState();
    fToast ??= FToast();
    fToast?.init(context);
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    if (_locale == null) {
      _locale = Localizations.localeOf(context).languageCode;
      LanguageService.language = _locale!;
    }
    _dialog ??=
        SimpleFontelicoProgressDialog(context: context, barrierDimisable: true);
    if (_consentDetail == null) {
      BlocProvider.of<ConsentBloc>(context).add(ConsentEventGetConsentDetail());
    }
    return BlocListener<ConsentBloc, ConsentState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        switch (state.status) {
          case FormzStatus.submissionInProgress:
            if (state.event is! ConsentEventGetMyConsent) {
              _dialog?.show(
                  message: 'Loading...',
                  type: SimpleFontelicoProgressDialogType.normal);
            }

            break;
          case FormzStatus.submissionSuccess:
            _dialog?.hide();
            if (state.event is ConsentEventGetConsentDetail) {
              BlocProvider.of<ConsentBloc>(context)
                  .add(ConsentEventGetMyConsent());
            }

            if (state.event is ConsentEventSubmitConsent) {
              _toastSuccess();
              Navigator.pop(context);
              /*
              AwesomeDialog(
                context: context,
                dialogType: DialogType.success,
                animType: AnimType.bottomSlide,
                //title: LanguageService.success,
                dismissOnTouchOutside: false,
                headerAnimationLoop: false,
                dismissOnBackKeyPress: false,
                width: 260,
                isDense: false,
                autoHide: const Duration(seconds: 2),
                onDismissCallback: (s) {
                  Navigator.pop(context);
                },
                padding: const EdgeInsets.only(bottom: AppDimension.spaceM),
              ).show();

               */
            }

            if (state.event is ConsentEventGetMyConsent) {
              if (state.hasNewVersion() || widget.forceShow == true) {
                //show my consent
                setState(() {
                  _consentDetail = state.consentDetail;
                  _consentDetail?.purposes?.forEach((element) {
                    _purposeChecked[element.id] = false;
                  });
                  state.consented?.purposes?.forEach((element) {
                    _purposeChecked[element.id] = true;
                  });
                  updateAllChecked();
                });
              } else {
                //hide
                Navigator.pop(context);
              }
            }
            break;
          case FormzStatus.submissionFailure:
            _dialog?.hide();
            //show if not found my consent
            if (state.event is ConsentEventGetMyConsent) {
              setState(() {
                _consentDetail = state.consentDetail;
                _consentDetail?.purposes?.forEach((element) {
                  _purposeChecked[element.id] = true;
                });
              });
            } else {
              showAlertDialog(context, null, state.error?.message);
            }

            break;
          default:
            _dialog?.hide();
            break;
        }
      },
      child: (_consentDetail == null)
          ? const SizedBox()
          : Scaffold(
              backgroundColor: Colors.white,
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
                            child: Padding(
                                child: _content(),
                                padding: const EdgeInsets.only(
                                    left: AppDimension.spaceL,
                                    right: AppDimension.spaceL,
                                    top: AppDimension.spaceL,
                                    bottom: AppDimension.spaceL)),
                          ),
                        ],
                      )),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: AppDimension.spaceL,
                        right: AppDimension.spaceL,
                        top: AppDimension.spaceM,
                        bottom: AppDimension.spaceL),
                    child: Row(
                      children: [
                        Expanded(
                            flex: 1,
                            child: FButton(
                              title: LanguageService.decline_additions ?? "",
                              backgroundColor: Colors.grey.shade400,
                              textStyle: const TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.white),
                              roundRadius: 30,
                              onPressed: () {
                                setState(() {
                                  var i = 0;
                                  _consentDetail?.purposes?.forEach((element) {
                                    if (!element.primary) {
                                      _purposeChecked[element.id] = false;
                                      i++;
                                    }
                                  });
                                  if (_consentDetail?.purposes?.length == i) {
                                    _allChecked = false;
                                  }
                                });
                                BlocProvider.of<ConsentBloc>(context).add(
                                    ConsentEventSubmitConsent(_purposeChecked));
                              },
                            )),
                        const SizedBox(
                          width: AppDimension.spaceL,
                        ),
                        Expanded(
                            flex: 1,
                            child: FButton(
                              title: LanguageService.save_settings ?? "",
                              textStyle: const TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.white),
                              roundRadius: 30,
                              onPressed: () {
                                BlocProvider.of<ConsentBloc>(context).add(
                                    ConsentEventSubmitConsent(_purposeChecked));
                              },
                            ))
                      ],
                    ),
                  )
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
        Text(
          _consentDetail!.getTitle(_context),
          style: AppTheme.themeData.textTheme.headline5,
        ),
        const SizedBox(
          height: AppDimension.spaceS,
        ),
        Text(_consentDetail!.getDesc(_context)),
        const SizedBox(
          height: AppDimension.spaceM,
        ),
        _line(),
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
                flex: 1,
                child: Text(
                  LanguageService.accept_all ?? "",
                  style: AppTheme.themeData.textTheme.headline5,
                )),
            Switch(
                value: _allChecked,
                activeColor: AppTheme.themeData.primaryColor,
                onChanged: (checked) {
                  setState(() {
                    _allChecked = checked;
                    _consentDetail?.purposes?.forEach((element) {
                      if (!element.primary) {
                        _purposeChecked[element.id] = _allChecked;
                      }
                    });
                  });
                })
          ],
        ),
        _line(),
        Column(
          children: _purposeWidgets(),
        ),
        _consentDetail?.showPrivacyPolicyLink == true
            ? Container(
                padding:
                    const EdgeInsets.symmetric(vertical: AppDimension.spaceM),
                child: RichText(
                    text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                        text: "${LanguageService.policy_footer} ",
                        style: const TextStyle(color: Colors.black)),
                    TextSpan(
                        text: _consentDetail?.linkPolicy,
                        recognizer: TapGestureRecognizer()
                          ..onTap = () async => {
                                if (_consentDetail?.linkPolicy != null)
                                  {
                                    _launchUrl(Uri.parse('${_consentDetail?.linkPolicy}'))
                                  }
                              },
                        style: const TextStyle(color: Colors.blue)),
                  ],
                )))
            : const SizedBox()
      ],
    );
  }

  Future<void> _launchUrl(Uri url) async {
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  _line() {
    return Container(
      width: double.infinity,
      height: 1,
      color: AppTheme.colorTextFieldBorder,
    );
  }

  List<Widget> _purposeWidgets() {
    List<Widget> items = <Widget>[];
    for (var element in _consentDetail!.purposes) {
      items.add(const SizedBox(
        height: AppDimension.spaceM,
      ));
      items.add(_purposeWidget(element));
      items.add(const SizedBox(
        height: AppDimension.spaceM,
      ));
      items.add(_line());
    }

    return items;
  }

  Widget _purposeWidget(Purposes purposes) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  purposes.getTitle(context),
                  style: AppTheme.themeData.textTheme.headline5,
                ),
                const SizedBox(
                  height: AppDimension.spaceS,
                ),
                Text(
                  purposes.getDesc(context),
                )
              ],
            )),
        Switch(
            value: _purposeChecked[purposes.id] ?? false,
            activeColor: AppTheme.themeData.primaryColor,
            onChanged: (purposes.primary)
                ? null
                : (checked) {
                    setState(() {
                      _purposeChecked[purposes.id] = checked;
                      updateAllChecked();
                    });
                  })
      ],
    );
  }

  void updateAllChecked() {
    _allChecked = true;
    _consentDetail?.purposes?.forEach((element) {
      if (_purposeChecked[element.id] == false) {
        _allChecked = false;
        return;
      }
    });
  }


  _toastSuccess() {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.black,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.check_circle,
            color: Colors.white,
          ),
          const SizedBox(
            width: AppDimension.spaceS,
          ),
          Text(
            "${LanguageService.success}",
            style: AppTheme.themeData.textTheme.headline5
                ?.copyWith(color: Colors.white),
          ),
        ],
      ),
    );
    fToast?.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: const Duration(seconds: 2),
    );
  }
}
