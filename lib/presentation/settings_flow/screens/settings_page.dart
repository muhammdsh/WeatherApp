import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_down_button/pull_down_button.dart';
import 'package:weather/core/blocs/application_bloc/app_bloc.dart';
import 'package:weather/core/resources/constants.dart';
import 'package:weather/presentation/custom_widgets/text_translation.dart';
import 'package:weather/presentation/weather_flow/bloc/weather_bloc.dart';

import '../../../app+injection/di.dart';
import '../../../core/localization/app_lang.dart';
import '../../../core/resources/colors.dart';

enum Degree { c, f }

enum Wind { ms, kmh }

enum Pressure { mmHg, hPa }

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  Degree degreeGroup = Degree.c;
  Wind windGroup = Wind.ms;
  Pressure pressureGroup = Pressure.mmHg;
  AppLanguages languagesGroup = AppLanguages.en;

  bool switcher = true;
  String selectedTheme = "Light";

  final degree = {Degree.c: const Text("°C"), Degree.f: const Text("°F")};

  final wind = {Wind.ms: Text("m/s"), Wind.kmh: Text("Km/h")};

  final pressure = {Pressure.mmHg: Text("mmHg"), Pressure.hPa: Text("hPa")};

  final language = {
    AppLanguages.en: TextTranslation(TranslationsKeys.english),
    AppLanguages.ar: TextTranslation(TranslationsKeys.arabic)
  };

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(

      builder: (context, state) {
        print(' locator<WeatherBloc>().state.unit: ${ locator<WeatherBloc>().state.unit}');

        return NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                // leadingWidth: ScreensHelper.fromWidth(100) ,
                title: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6.0),
                  child: TextTranslation(TranslationsKeys.settings,
                      style: TextStyle(
                          fontSize: 85.sp, fontWeight: FontWeight.w400)),
                ),
                backgroundColor: locator<AppThemeColors>().backgroundColor,
                //title: ,
                pinned: true,
                elevation: 0,
                leading: const SizedBox(),
                leadingWidth: 0,
                centerTitle: false,
                // leading: SizedBox(),
              )
            ];
          },
          body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  color: locator<AppThemeColors>().primaryColor,
                  height: 540.sp,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 24.0, vertical: 50.sp),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CustomSegmentedControlRow(
                          title: TranslationsKeys.degree.tr(context),
                          onValueChanged: (value) {
                            degreeGroup = value;

                            locator<WeatherBloc>().setLocation(
                                unit:
                                    value == Degree.c ? 'metric' : 'imperial');
                            setState(() {});
                          },
                          groupValue:
                              locator<WeatherBloc>().state.unit == 'metric'
                                  ? Degree.c
                                  : Degree.f,
                          children: degree,
                        ),
                        CustomSegmentedControlRow(
                          title: TranslationsKeys.wind.tr(context),
                          onValueChanged: (value) {
                            windGroup = value;
                            setState(() {});
                          },
                          groupValue: windGroup,
                          children: wind,
                        ),
                        CustomSegmentedControlRow(
                          title: TranslationsKeys.pressure.tr(context),
                          onValueChanged: (value) {
                            pressureGroup = value;
                            setState(() {});
                          },
                          groupValue: pressureGroup,
                          children: pressure,
                        ),
                      ],
                    ),
                  ),
                ),
                ScreenUtil().setVerticalSpacing(80),
                Container(
                  color: locator<AppThemeColors>().primaryColor,
                  height: 540.sp,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 24.0, vertical: 50.sp),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CustomSegmentedControlRow(
                          title: TranslationsKeys.changeLanguage.tr(context),
                          onValueChanged: (value) {
                            print('ssssss: $value');
                            locator<AppBloc>().changeLanguage(value);

                            //  setState(() {});
                          },
                          groupValue: locator<AppBloc>().state.language,
                          children: language,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextTranslation(
                              TranslationsKeys.changeTheme,
                              style: TextStyle(fontSize: 56.sp),
                            ),
                            Row(
                              children: [
                                PullDownButton(
                                  position: PullDownMenuPosition.over,
                                  itemBuilder: (context) => [
                                    PullDownMenuItem.selectable(
                                      title: TranslationsKeys.light.tr(context),
                                      icon: CupertinoIcons.sun_max_fill,
                                      iconColor: Colors.amber,
                                      selected: state.appThemeMode !=
                                          AppThemeMode.dark,
                                      onTap: () {
                                        selectedTheme =
                                            TranslationsKeys.light.tr(context);
                                        locator<AppBloc>().changeTheme(
                                            appThemeMode: AppThemeMode.light);
                                      },
                                    ),
                                    PullDownMenuItem.selectable(
                                      title: TranslationsKeys.dark.tr(context),
                                      icon: CupertinoIcons.moon_fill,
                                      iconColor: Colors.deepPurpleAccent,
                                      selected: state.appThemeMode ==
                                          AppThemeMode.dark,
                                      onTap: () {
                                        selectedTheme =
                                            TranslationsKeys.dark.tr(context);
                                        locator<AppBloc>().changeTheme(
                                            appThemeMode: AppThemeMode.dark);
                                      },
                                    ),
                                  ],
                                  buttonBuilder: (context, showMenu) =>
                                      CupertinoButton(
                                    onPressed: showMenu,
                                    padding: EdgeInsets.zero,
                                    child: TextTranslation(
                                      state.appThemeMode == AppThemeMode.dark
                                          ? TranslationsKeys.dark
                                          : TranslationsKeys.light,
                                      style: TextStyle(
                                          color: locator<AppThemeColors>()
                                              .secondaryColor),
                                    ),
                                  ),
                                ),
                                ScreenUtil().setHorizontalSpacing(38)
                              ],
                            ),
                            // SizedBox(width: 2,)
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextTranslation(
                              TranslationsKeys.showDetails,
                              style: TextStyle(fontSize: 56.sp),
                            ),
                            Row(
                              children: [
                                Container(
                                  height: 36,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.0),
                                    border: Border.all(
                                        color: locator<AppThemeColors>()
                                            .secondaryColor),
                                    //  color: locator<AppThemeColors>().secondaryColor,
                                  ),
                                  child: CupertinoSwitch(
                                      activeColor: locator<AppThemeColors>()
                                          .primaryColor,
                                      thumbColor: locator<AppThemeColors>()
                                          .secondaryColor,
                                      trackColor: locator<AppThemeColors>()
                                          .primaryColor,
                                      value: switcher,
                                      onChanged: (value) {
                                        switcher = value;
                                        setState(() {});
                                      }),
                                ),
                                ScreenUtil().setHorizontalSpacing(33),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ]),
        );
      },
    );
  }
}

class CustomSegmentedControlRow<T> extends StatefulWidget {
  const CustomSegmentedControlRow({
    Key key,
    @required this.title,
    @required this.children,
    @required this.groupValue,
    @required this.onValueChanged,
  }) : super(key: key);

  final String title;
  final Map<T, Widget> children;
  final T groupValue;
  final ValueChanged<T> onValueChanged;

  @override
  _CustomSegmentedControlRowState createState() =>
      _CustomSegmentedControlRowState();
}

class _CustomSegmentedControlRowState extends State<CustomSegmentedControlRow> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          //  width: 240.sp,
          child: Text(
            widget.title,
            style: TextStyle(fontSize: 56.sp),
          ),
        ),
        Expanded(
          child: CupertinoSegmentedControl(
            selectedColor: locator<AppThemeColors>().secondaryColor,
            unselectedColor: locator<AppThemeColors>().white,
            borderColor: locator<AppThemeColors>().secondaryColor,
            children: widget.children,
            groupValue: widget.groupValue,
            onValueChanged: widget.onValueChanged,
          ),
        ),
      ],
    );
  }
}
