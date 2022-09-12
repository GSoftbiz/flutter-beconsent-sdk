import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_beconsent_sdk/routers/routers.dart';
import 'package:flutter_beconsent_sdk/theme/app_theme.dart';

class App extends StatelessWidget {
  const App({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        //BlocProvider(create: (ctx) => AuthenticationBloc()),
        //BlocProvider(create: (ctx) => MainBloc())
      ],
      child: MaterialApp(
        builder: EasyLoading.init(),
        //initialRoute: SplashScreen.route,
        routes: BeConsentRouter.routes,
        theme: AppTheme.themeData,
        title: 'beConsent',
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
      ),
    );
  }
}
