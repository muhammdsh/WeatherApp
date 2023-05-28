import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:simple_progress_indicators/simple_progress_indicators.dart';

import '../../../app+injection/di.dart';
import '../../../core/resources/colors.dart';
import '../screens/weather_screen.dart';

class WeatherDailyWidget extends StatelessWidget {
  const WeatherDailyWidget(
      {Key key, this.status, this.date, this.image, this.maxVal, this.minVal})
      : super(key: key);
  final String date;
  final String minVal;
  final String maxVal;
  final String image;
  final String status;

  String formatDateString(String dateString) {
    DateTime currentDate = DateTime.now();
    DateTime myDate = DateTime.parse(dateString);
    final tomorrow =
    DateTime(currentDate.year, currentDate.month, currentDate.day + 1);
    final comparingDate = DateTime(myDate.year, myDate.month, myDate.day);

    String dateText = '';

    if (myDate.year == currentDate.year &&
        myDate.month == currentDate.month &&
        myDate.day == currentDate.day) {
      dateText = 'Today';
    } else if (tomorrow == comparingDate) {
      dateText = 'Tomorrow';
    } else {
      DateFormat formatter = DateFormat('E, d MMM');
      dateText = formatter.format(myDate);
    }

    return dateText;
  }

  @override
  Widget build(BuildContext context) {
    double randomValue = 0.3 + Random().nextDouble() * 0.5;
    final formatDate = formatDateString(date);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CustomSvgContainer(
          image: image,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              formatDate,
              style: TextStyle(
                fontSize: 50.sp,
                fontWeight: FontWeight.w300,
              ),
            ),
            Text(
              status,
              style: TextStyle(
                fontSize: 40.sp,
                color: locator<AppThemeColors>().editingGray,
                fontWeight: FontWeight.w300,
              ),
            )
          ],
        ),
        SizedBox(
          width: 400.sp,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "$minVal°",
                    style: TextStyle(
                      fontSize: 50.sp,
                      fontWeight: FontWeight.w300,
                      color: const Color(0xff85B0E2),
                    ),
                  ),
                  Text(
                    "$maxVal°",
                    style: TextStyle(
                      fontSize: 50.sp,
                      fontWeight: FontWeight.w300,
                    ),
                  )
                ],
              ),
              ProgressBar(
                value: randomValue,
                width: 400.sp,
                height: 2.8,
                backgroundColor: const Color(0xffC1CCDD),
                gradient: const LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Color(0xff85B0E2),
                      Color(0xff133154),
                      Color(0xff133154)
                    ]),
              ),
            ],
          ),
        )
      ],
    );
  }
}


class CustomSvgContainer extends StatelessWidget {
  const CustomSvgContainer({
    Key key,
    @required this.image,
    this.padding = 10,
    this.borderRadius = 12,
    this.color,
  }) : super(key: key);

  final String image;
  final double padding;
  final double borderRadius;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final appThemeColors = locator<AppThemeColors>();
    return Container(
      height: 180.sp,
      width: 180.sp,
      padding: EdgeInsets.all(padding.sp),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        color: color ?? appThemeColors.primaryColor,
      ),
      child: Center(
        child: SvgPicture.asset(
          image,
          //  height: 30.sp,
          //color: appThemeColors.white,
        ),
      ),
    );
  }
}
