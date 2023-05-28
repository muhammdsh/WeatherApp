import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weather/app+injection/di.dart';
import 'package:weather/core/localization/app_lang.dart';
import 'package:weather/core/resources/colors.dart';
import 'package:weather/core/resources/constants.dart';
import 'package:weather/presentation/home_flow/screens/home_screen.dart';

import '../../settings_flow/screens/settings_page.dart';
import '../../weather_flow/screens/weather_screen.dart';
import '../bloc/root_bloc.dart';

enum RootTabs { myLocation, weather, settings }

class NavigationController {
  final List<NavigationItem> _navigationItems = [
    NavigationItem(
      title: TranslationsKeys.myLocation,
      disabledIcon: ImagesKeys.location,
      enabledIcon: ImagesKeys.locationActive,
      page: HomeScreen(),
    ),
    NavigationItem(
      title: TranslationsKeys.weather,
      disabledIcon: ImagesKeys.weather,
      enabledIcon: ImagesKeys.weatherActive,
      page: WeatherPage(),
    ),
    NavigationItem(
      title: TranslationsKeys.settings,
      disabledIcon: ImagesKeys.settings,
      enabledIcon: ImagesKeys.settingsActive,
      page: SettingsPage(),
    ),
  ];

  NavigationItem currentNavigationItem(index) => _navigationItems[index];

  List<BottomNavigationBarItem> bottomNavigationBarItems(context) =>
      _navigationItems
          .map((item) => BottomNavigationBarItem(
                icon: SvgPicture.asset(item.disabledIcon ?? item.enabledIcon),
                activeIcon:
                    SvgPicture.asset(item.enabledIcon ?? item.disabledIcon),
                label: item.title.tr(context),
              ))
          .toList();
}

class NavigationItem {
  final String title;
  final String enabledIcon;
  final String disabledIcon;
  final Widget page;

  NavigationItem(
      {@required this.title,
      this.enabledIcon,
      @required this.disabledIcon,
      @required this.page});
}

class RootPageWidget extends StatefulWidget {
  @override
  _RootPageWidgetState createState() => _RootPageWidgetState();
}

class _RootPageWidgetState extends State<RootPageWidget> {
  final bloc = locator<RootBloc>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RootBloc, RootState>(
      bloc: bloc,
      builder: (context, state) {
        return Scaffold(
          body: locator<NavigationController>()
              .currentNavigationItem(state.currentIndex)
              .page,
          bottomNavigationBar: Theme(
            data: Theme.of(context).copyWith(
              canvasColor: locator<AppThemeColors>().primaryColor,
            ),
            child: BottomNavigationBar(
              selectedItemColor: locator<AppThemeColors>().secondaryColor,
              items: locator<NavigationController>()
                  .bottomNavigationBarItems(context),
              currentIndex: state.currentIndex,
              onTap: (index) {
                bloc.navigateTo(RootTabs.values[index]);
              },
            ),
          ),
        );
      },
    );
  }
}
