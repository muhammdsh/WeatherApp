import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather/app+injection/di.dart';
import 'package:weather/core/blocs/application_bloc/app_bloc.dart';
import 'package:weather/core/helper/extensions/material_color_converter.dart';
import 'package:weather/core/localization/app_lang.dart';
import 'package:weather/core/mediators/communication_types/AppStatus.dart';
import 'package:weather/core/resources/colors.dart';
import 'package:weather/core/resources/constants.dart';
import 'package:weather/presentation/custom_widgets/text_translation.dart';
import 'package:weather/presentation/root_flow/screens/root_page.dart';

import '../core/resources/constants.dart';
import '../presentation/introduction/introduction_animation_screen.dart';
import '../presentation/startup_flow/screens/splash_screen.dart';

class App extends StatefulWidget {
  const App({Key key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final appBloc = locator<AppBloc>();

  @override
  void initState() {
    super.initState();
    appBloc.add(LaunchAppEvent());

  }

  @override
  void dispose() {
    appBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => appBloc,
      child: BlocBuilder<AppBloc, AppState>(
        buildWhen: (previousState, state) {

          return previousState.cart == state.cart;
        },
        builder: (context, state) {
          if (locator.isRegistered<AppThemeColors>()) {
            locator.unregister<AppThemeColors>();
          }
          locator.registerFactory<AppThemeColors>(
              () => ThemeFactory.colorModeFactory(state.appThemeMode));

          return ScreenUtilInit(
              designSize: const Size(1170, 2532),
              minTextAdapt: true,
              splitScreenMode: true,
              child: state.appStatus == Status.startup
                  ?  SplashPage()
                  : state.isFirstTime
                      ? IntroductionAnimationScreen()
                      : RootPageWidget(),
              builder: (context, child) {
                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: 'Weather',
                  theme: ThemeData(
                    backgroundColor: locator<AppThemeColors>().backgroundColor,
                    scaffoldBackgroundColor: locator<AppThemeColors>().backgroundColor,

                    primarySwatch: locator<AppThemeColors>()
                        .primaryColor
                        .toMaterialColor(),
                    fontFamily: state.isEnglish ? "Poppins" : "cocon",
                    brightness: Brightness.light,
                  ),
                  darkTheme: ThemeData(
                    primarySwatch: locator<AppThemeColors>()
                        .primaryColor
                        .toMaterialColor(),
                    scaffoldBackgroundColor: locator<AppThemeColors>().backgroundColor,
                    brightness: Brightness.dark,
                  ),
                  themeMode: ThemeFactory.currentTheme(state.appThemeMode),
                //  theme: CupertinoThemeData(
                      // scaffoldBackgroundColor:
                      //     locator<AppThemeColors>().backgroundColor,
                      // primaryColor: locator<AppThemeColors>().primaryColor,
                      // barBackgroundColor: locator<AppThemeColors>().backgroundColor,
                      // primaryContrastingColor:locator<AppThemeColors>().backgroundColor ,
                      // textTheme: CupertinoTextThemeData(
                      //     textStyle: TextStyle(
                      //   fontFamily: state.isEnglish ? "Poppins" : "cocon",
                      // ))),

                  locale: LocalizationManager.localeFactory(state.language),
                  localizationsDelegates:
                      LocalizationManager.createLocalizationsDelegates,
                  supportedLocales: LocalizationManager.createSupportedLocals,
                  home: child,
                );
              });
        },
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool data = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.only(top: 150),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextButton(
                  onPressed: () {
                    context.read<AppBloc>().changeLanguage(
                        data ? AppLanguages.en : AppLanguages.ar);
                    data = !data;
                  },
                  child: TextTranslation(TranslationsKeys.changeLanguage),
                ),
                TextButton(
                  onPressed: () {
                    context.read<AppBloc>().changeTheme();
                  },
                  child: TextTranslation(TranslationsKeys.changeTheme),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
