import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weather/app+injection/di.dart';
import 'package:weather/core/helper/screen_util/screen_helper.dart';
import 'package:weather/core/resources/colors.dart';
import 'package:weather/core/resources/constants.dart';
import 'package:weather/presentation/custom_widgets/text_translation.dart';
import 'package:weather/presentation/home_flow/screens/search_location_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: ScreensHelper.fromWidth(100),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 26),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(ImagesKeys.myLocationIcon),
              ScreenUtil().setVerticalSpacing(60),
              TextTranslation(
                TranslationsKeys.rightClothes,
                style: TextStyle(fontSize: 58.sp, fontWeight: FontWeight.w500),
              ),
              ScreenUtil().setVerticalSpacing(60),
              TextTranslation(TranslationsKeys.seeWeather,
                  style: TextStyle(fontSize: 36.sp),
                  textAlign: TextAlign.center),
              ScreenUtil().setVerticalSpacing(60),
              SizedBox(
                width: 220.spMax,
                height: 55.spMax,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const SearchLocationScreen()));
                  },
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      primary: locator<AppThemeColors>().secondaryColor),
                  child: TextTranslation(
                    TranslationsKeys.findLocations,
                    style: TextStyle(color: locator<AppThemeColors>().white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
