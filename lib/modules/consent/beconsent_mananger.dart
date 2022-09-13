import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_beconsent_sdk/configs/app_configs.dart';
import 'package:flutter_beconsent_sdk/di/injector.dart';
import 'package:flutter_beconsent_sdk/modules/consent/bloc/consent_bloc.dart';
import 'package:flutter_beconsent_sdk/modules/consent/views/consent_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

class BeConsentManager {
  Future<void> show(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {

            return Middle();
            /*return const AlertDialog(
                content: Middle(),
                insetPadding:
                    EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
                contentPadding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(0.0))));*/
          });
        });
  }
}

class Middle extends StatelessWidget {
  const Middle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: BlocProvider<ConsentBloc>(
        create: (context) =>
            ConsentBloc(
                authenticationRepository:
                Injector.instance.authenticationRepository,
                userSession: Injector.instance.userSession),
        child: const Padding(padding: EdgeInsets.all(0),
          child: ConsentScreen(),),
      ),
    );


  }
}
