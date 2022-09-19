import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_beconsent_sdk/di/injector.dart';
import 'package:flutter_beconsent_sdk/modules/consent/bloc/consent_bloc.dart';
import 'package:flutter_beconsent_sdk/modules/consent/views/consent_screen.dart';
import 'package:flutter_beconsent_sdk/modules/dsrm/bloc/dsrm_bloc.dart';
import 'package:flutter_beconsent_sdk/modules/dsrm/views/dsrm_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DSRMManager {
  Future<void> show(BuildContext context) async {
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
