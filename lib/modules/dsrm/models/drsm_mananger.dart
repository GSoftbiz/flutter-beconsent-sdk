import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_beconsent_sdk/core/localization/language_service.dart';
import 'package:flutter_beconsent_sdk/di/injector.dart';
import 'package:flutter_beconsent_sdk/modules/consent/bloc/consent_bloc.dart';
import 'package:flutter_beconsent_sdk/modules/consent/views/consent_screen.dart';
import 'package:flutter_beconsent_sdk/modules/dsrm/bloc/dsrm_bloc.dart';
import 'package:flutter_beconsent_sdk/modules/dsrm/views/dsrm_screen.dart';
import 'package:flutter_beconsent_sdk/theme/app_dimension.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../theme/app_theme.dart';

class DSRMManager {
  Future<void> show(BuildContext context) async {
    if(Injector.instance.userSession.collectionChannel == ""){
      return await AwesomeDialog(
        context: context,
        dialogType: DialogType.warning,
        animType: AnimType.bottomSlide,
        title: LanguageService.get("consent_needed"),
        dismissOnTouchOutside: true,
        headerAnimationLoop: false,
        dismissOnBackKeyPress: true,
        onDismissCallback: (s) {},
        btnOkColor: AppTheme.themeData.primaryColor,
        btnOkOnPress: () {},
        padding: const EdgeInsets.all(AppDimension.spaceM),
      ).show();
    }


    return await showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return Middle();
          });
        });


  }
}

class Middle extends StatelessWidget {
  Middle({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: BlocProvider<DSRMBloc>(
        create: (context) =>
            DSRMBloc(
                authenticationRepository:
                Injector.instance.authenticationRepository,
                userSession: Injector.instance.userSession),
        child: Padding(padding: const EdgeInsets.all(0),
          child: DSRMScreen(),),
      ),
    );
  }
}
