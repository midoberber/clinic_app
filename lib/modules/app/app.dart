import 'package:clinic_app/pages/auth/login/login_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:meta/meta.dart';
import 'package:provider/provider.dart';
import 'package:clinic_app/locale/localizations.dart';
import 'package:clinic_app/modules/app/app_entity.dart';
import 'package:clinic_app/modules/graphql/with_gql.dart';
import 'package:clinic_app/pages/user/user_info.dart';
import 'package:clinic_app/pages/index.dart';
import 'package:clinic_app/pages/landing/landing.dart';

import 'app_model.dart';
import 'app_repository.dart';
import 'app_theme.dart';

class ClinicApp extends StatelessWidget {
  final AppRepository repository;

  ClinicApp({
    @required this.repository,
  });

  @override
  Widget build(BuildContext context) {
    imageCache.clear();

    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => AppStateModel(repository: repository)..load(),
          ),
        ],
        child: Selector<AppStateModel, AppState>(
            selector: (_, model) => model.state,
            builder: (context, state, _) {
              var currentPage;
              switch (state) {
                case AppState.unauthenticated:
                  currentPage = LoginPage();
                  break;
                case AppState.not_completed:
                  currentPage = UserInfo();
                  break;
                case AppState.authenticated:
                  currentPage = MainPage();
                  break;
                default:
                  currentPage = Center(
                    child: CircularProgressIndicator(),
                  );
              }

              return WithGraphQl(
                child: Selector<AppStateModel, SpecificLocalizationDelegate>(
                    selector: (_, model) => model.specificLocalizationDelegate,
                    builder: (context, specificLocalizationDelegate, _) {
                      return MaterialApp(
                          theme: ClinicAppTheme.theme,
                          localizationsDelegates: [
                            GlobalMaterialLocalizations.delegate,
                            GlobalWidgetsLocalizations.delegate,
                            GlobalCupertinoLocalizations.delegate,
                            DefaultCupertinoLocalizations.delegate,
                            specificLocalizationDelegate
                          ],
                          supportedLocales: [Locale('en'), Locale('ar')],
                          locale: specificLocalizationDelegate.overriddenLocale,
                          debugShowCheckedModeBanner: false,
                          onGenerateTitle: (context) =>
                              AppLocalizations.of(context).appTitle,
                          routes: {
                            // put our new route here ...
                            // '/': (context) => currentPage,
                          },
                          home: currentPage);
                    }),
                token: repository.loadAppData().token ?? "",
              );
            }));
  }
}
