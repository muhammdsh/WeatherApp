import 'package:flutter/material.dart';

enum AppThemeMode {
  dark, light
}

abstract class AppThemeColors {

  Color get primaryColor;

  Color get grey;

  Color get editingGray;

  Color get backgroundColor;

  Color get white;

  Color get black;

  Color get secondaryColor;

  Color get accentColor;

  Color get transparent;

}
class LightModeColors extends AppThemeColors {

  @override
  Color get primaryColor => const Color(0xffffffff);

  @override
  Color get backgroundColor => const Color(0xffF3F4F7);

  @override
  Color get grey => const Color(0xffE2E2E2);

  @override
  Color get white => Colors.white;

  @override
  Color get black => Colors.black;

  @override
  Color get secondaryColor => const  Color(0xff3078FB);

  @override
  Color get accentColor => const Color(0xffe6e6e6);

  @override
  Color get editingGray => const Color(0xff8491A4);

  @override
  Color get transparent => Colors.transparent;


}

class DarkModeColors extends AppThemeColors {

  @override
  Color get primaryColor => const Color(0xff1E3760);

  @override
  Color get backgroundColor => const Color(0xff132842);

  @override
  Color get grey => Colors.grey;

  @override
  Color get white => Colors.white;

  @override
  Color get black => Colors.black;

  @override
  Color get secondaryColor => const  Color(0xffE7B315);

  @override
  Color get accentColor => const Color(0xffe6e6e6);

  @override
  Color get editingGray => const Color(0xff8491A4);

  @override
  Color get transparent => Colors.transparent;

}

class ThemeFactory {

  static AppThemeColors colorModeFactory(AppThemeMode appThemeMode) {
    switch (appThemeMode) {
      case AppThemeMode.light:
        return LightModeColors();
      case AppThemeMode.dark:
        return DarkModeColors();
      default:
        return LightModeColors();
    }
  }

  static ThemeMode currentTheme(AppThemeMode appThemeMode) {
    return appThemeMode == AppThemeMode.dark? ThemeMode.dark : ThemeMode.light;
  }

}

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}
