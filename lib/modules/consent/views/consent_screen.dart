import 'package:flutter_beconsent_sdk/modules/consent/bloc/consent_bloc.dart';
import 'package:flutter_beconsent_sdk/modules/consent/models/ConsentDetail.dart';
import 'package:flutter_beconsent_sdk/theme/app_dimension.dart';
import 'package:flutter_beconsent_sdk/utils/helper/alert_dialog_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:formz/formz.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

class ConsentScreen extends StatefulWidget {
  static const String route = '/consent';

  const ConsentScreen({Key? key}) : super(key: key);

  @override
  State<ConsentScreen> createState() => _ConsentScreenState();
}

class _ConsentScreenState extends State<ConsentScreen> {
  SimpleFontelicoProgressDialog? _dialog;
  ConsentDetail? _consentDetail;

  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    _dialog ??= SimpleFontelicoProgressDialog(
        context: context, barrierDimisable: false);
    if (_consentDetail == null) {
      BlocProvider.of<ConsentBloc>(context).add(ConsentEventGetConsentDetail());
    }
    return BlocListener<ConsentBloc, ConsentState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        switch (state.status) {
          case FormzStatus.submissionInProgress:
            _dialog?.show(
                message: 'Loading...',
                type: SimpleFontelicoProgressDialogType.normal);
            break;
          case FormzStatus.submissionSuccess:
            _dialog?.hide();
            if (state.event is ConsentEventGetConsentDetail) {
              setState(() {
                _consentDetail = state.consentDetail;
              });
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
      child: (_consentDetail == null)
          ? const SizedBox()
          : Container(

              child: Scaffold(
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
            ),
    );
  }

  //Image.asset(const AssetImage("assets/images/logo.png").assetName, package: 'flutter_beconsent_sdk',)
  _content() {
    return Column(
      children: [
        TextButton(
            onPressed: () {
              BlocProvider.of<ConsentBloc>(context)
                  .add(ConsentEventGetConsentDetail());
            },
            child: Text("Hello"))
      ],
    );
  }
}
