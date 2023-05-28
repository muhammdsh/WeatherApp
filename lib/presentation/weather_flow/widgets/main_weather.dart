import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../../../app+injection/di.dart';
import '../../../core/resources/colors.dart';

class MainWeather extends StatelessWidget {
  const MainWeather(
      {Key key, this.status, this.date, this.feels, this.temp, this.image})
      : super(key: key);

  final String date;
  final String temp;
  final String status;
  final String feels;
  final String image;

  @override
  Widget build(BuildContext context) {
    DateTime dateTime =
    DateTime.now(); // Replace this with your DateTime object
    String formattedDateTime = DateFormat('E, d MMM, HH:mm').format(dateTime);
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(60.sp),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: locator<AppThemeColors>().primaryColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                formattedDateTime,
                style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: 48.sp,
                ),
              ),
              Text(
                "$temp°",
                style: TextStyle(
                  fontSize: 160.sp,
                  fontWeight: FontWeight.w300,
                ),
              ),
              Text(
                status,
                style: TextStyle(
                  fontSize: 50.sp,
                  fontWeight: FontWeight.w300,
                ),
              ),
              Text(
                "feels Like $temp°",
                style: TextStyle(
                  fontSize: 50.sp,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
          SvgPicture.asset(image)
        ],
      ),
    );
  }
}
