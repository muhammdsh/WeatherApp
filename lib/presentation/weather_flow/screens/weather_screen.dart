import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weather/core/localization/app_lang.dart';

import '../../../app+injection/di.dart';
import '../../../core/resources/colors.dart';
import '../../../core/resources/constants.dart';
import '../../home_flow/screens/search_location_screen.dart';
import '../bloc/weather_bloc.dart';
import '../widgets/main_weather.dart';
import '../widgets/weather_daily_widget.dart';
import '../widgets/weather_hourly_idget.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({Key key}) : super(key: key);

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final bloc = locator<WeatherBloc>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<WeatherBloc, WeatherState>(
        bloc: bloc,
        builder: (context, state) {
          return NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverAppBar(
                    floating: true,
                    pinned: true,
                    // leadingWidth: ScreensHelper.fromWidth(100) ,
                    title: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6.0),
                      child: Row(
                        children: [
                          Text(
                              state.status == WeatherPageStatus.init
                                  ? TranslationsKeys.welcome.tr(context)
                                  : state.location.name,
                              style: TextStyle(
                                  fontSize: 85.sp,
                                  fontWeight: FontWeight.w400)),
                          SvgPicture.asset(ImagesKeys.mainLocation),
                        ],
                      ),
                    ),
                    backgroundColor: locator<AppThemeColors>().backgroundColor,
                    //title: ,
                    // pinned: true,
                    elevation: 0,
                    leading: const SizedBox(),
                    leadingWidth: 0,
                    centerTitle: false,
                    // leading: SizedBox(),
                  )
                ];
              },
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    children: [
                      ScreenUtil().setVerticalSpacing(50),

                       if(state.status == WeatherPageStatus.init)
                        const Text("Please Select Location First"),
                       if(state.status == WeatherPageStatus.loading)
                         const CustomCircularProgressIndicator(),
                       if(state.status == WeatherPageStatus.success)
                         Column(
                           children: [
                             MainWeather(
                                 image: ImagesKeys.mainIcon,
                                 temp: state?.daily?.first?.tavg?.toString(),
                                 status: state?.hourly?.first?.status),
                             SizedBox(
                               height: 500.sp,
                               child: ListView.builder(
                                 padding: EdgeInsets.symmetric(vertical: 80.sp),
                                 itemCount: state?.hourly?.length,
                                 scrollDirection: Axis.horizontal,
                                 itemBuilder: (context, index) {
                                   return Padding(
                                     padding:
                                     EdgeInsetsDirectional.only(end: 55.sp),
                                     child: WeatherHourlyWidget(
                                       image: state?.hourly[index].image,
                                       hour: state?.hourly[index].time?.toString(),
                                       temp: state?.hourly[index].temp?.toString(),
                                     ),
                                   );
                                 },
                               ),
                             ),
                             ScreenUtil().setVerticalSpacing(10),
                             ListView.builder(
                               physics: const NeverScrollableScrollPhysics(),
                               padding: EdgeInsets.zero,
                               shrinkWrap: true,
                               itemCount: state?.daily?.length,
                               itemBuilder: (context, index) {
                                 return Padding(
                                   padding: EdgeInsets.only(bottom: 54.0.sp),
                                   child: WeatherDailyWidget(
                                     date: state?.daily[index].time.toString(),
                                     image: ImagesKeys.partiallyCloudy,
                                     maxVal: state?.daily[index].tmax.toString(),
                                     minVal: state?.daily[index].tmin.toString(),
                                     status: "Partially cloudy",
                                   ),
                                 );
                               },
                             ),
                           ],
                         ),
                    ],
                  ),
                ),
              ));
        },
      ),
    );
  }
}




