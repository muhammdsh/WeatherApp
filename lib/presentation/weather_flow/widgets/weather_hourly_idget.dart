import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../../../app+injection/di.dart';
import '../../../core/resources/colors.dart';


class WeatherHourlyWidget extends StatelessWidget {
  const WeatherHourlyWidget({Key key, this.image, this.temp, this.hour})
      : super(key: key);

  final String image;
  final String hour;
  final String temp;

  @override
  Widget build(BuildContext context) {
    DateFormat formatter = DateFormat('HH:mm');
    final dateText = formatter.format(DateTime(DateTime.parse(hour).year,DateTime.parse(hour).month, DateTime.parse(hour).day, DateTime.parse(hour).hour));

    final time = DateTime.parse(hour).hour == DateTime.now().hour
        ? "Now"
        : dateText;



    return Column(
      children: [
        Container(
          height: 180.sp,
          width: 180.sp,
          padding: EdgeInsets.all(10.sp),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: locator<AppThemeColors>().primaryColor,
          ),
          child: Center(
            child: SvgPicture.asset(image),
          ),
        ),
        ScreenUtil().setVerticalSpacing(10.sp),
        Center(
          child: Text(
            time.toString(),
            style: TextStyle(
              color: locator<AppThemeColors>().editingGray,
              fontSize: 46.sp,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
        Center(
          child: Text(
            "$temp°",
            style: TextStyle(
              fontSize: 50.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}
