import 'package:flutter/material.dart';
import 'package:flutter_beconsent_sdk/modules/consent/bloc/consent_bloc.dart';
import 'package:flutter_beconsent_sdk/modules/consent/views/consent_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_beconsent_sdk/di/injector.dart';

class BeConsentRouter {
  static Map<String, WidgetBuilder> routes = {
    ConsentScreen.route: (context) => BlocProvider<ConsentBloc>(
          create: (context) => ConsentBloc(
              authenticationRepository:
                  Injector.instance.authenticationRepository,
              userSession: Injector.instance.userSession),
          child: ConsentScreen(),
        )
  };
}
