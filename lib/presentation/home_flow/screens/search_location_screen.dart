import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:weather/app+injection/di.dart';
import 'package:weather/core/helper/extensions/material_color_converter.dart';
import 'package:weather/core/helper/screen_util/screen_helper.dart';
import 'package:weather/core/localization/app_lang.dart';
import 'package:weather/core/resources/colors.dart';
import 'package:weather/core/resources/constants.dart';

import '../../custom_widgets/text_translation.dart';
import '../blocs/location_bloc.dart';

class SearchLocationScreen extends StatefulWidget {
  const SearchLocationScreen({Key key}) : super(key: key);

  @override
  State<SearchLocationScreen> createState() => _SearchLocationScreenState();
}

class _SearchLocationScreenState extends State<SearchLocationScreen> {
  String selectedLocation = "";

  final controller = TextEditingController();

  final bloc = locator<LocationBloc>();

  void clearData() {
    bloc.getLocations("");
    controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  // leadingWidth: ScreensHelper.fromWidth(100) ,
                  title: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6.0),
                    child: TextTranslation(TranslationsKeys.myLocation,
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
            body: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 18),
              child: BlocBuilder<LocationBloc, LocationState>(
                bloc: bloc,
                builder: (context, state) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: CupertinoSearchTextField(
                                controller: controller,
                                onChanged: (value) {
                                  bloc.getLocations(value);
                                },
                                backgroundColor:
                                    locator<AppThemeColors>().primaryColor,
                                placeholder:
                                    TranslationsKeys.findLocations.tr(context),
                                padding: EdgeInsets.symmetric(
                                    vertical: 40.sp, horizontal: 50.sp)),
                          ),
                          if (state.searchAddress.isNotEmpty)
                            CupertinoButton(
                                child: TextTranslation(
                                  TranslationsKeys.cancel,
                                  style: TextStyle(
                                    color: locator<AppThemeColors>()
                                        .secondaryColor,
                                  ),
                                ),
                                onPressed: () {
                                  clearData();
                                })
                        ],
                      ),
                      if (state.status == LocationStatus.initial)
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ScreenUtil().setVerticalSpacing(300),
                            SvgPicture.asset(ImagesKeys.myLocationIconPage),
                            ScreenUtil().setVerticalSpacing(60),
                            TextTranslation(
                              TranslationsKeys.addLocation,
                              style: TextStyle(
                                  fontSize: 58.sp, fontWeight: FontWeight.w500),
                            ),
                            ScreenUtil().setVerticalSpacing(60),
                            TextTranslation(TranslationsKeys.useSearchBar,
                                style: TextStyle(fontSize: 40.sp),
                                textAlign: TextAlign.center),
                            ScreenUtil().setVerticalSpacing(60),
                          ],
                        ),
                      if (state.status == LocationStatus.success)
                        ListView.builder(
                          shrinkWrap: true, // Set shrinkWrap to true
                          padding: EdgeInsets.zero,
                          itemCount: state.data.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              contentPadding: EdgeInsets.zero,
                              title: Text(
                                "${state.data[index].name}, ${state.data[index].country}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.w400),
                              ),
                              onTap: () {
                                bloc.selectAddress(index);
                                clearData();
                                Navigator.of(context).pop();
                              },
                            );
                          },
                        ),
                      if (state.status == LocationStatus.failure)
                        ScreenUtil().setVerticalSpacing(300),
                      if (state.status == LocationStatus.failure)
                        Center(
                          child: Text(state.error),
                        ),
                      if (state.status == LocationStatus.loading)
                        ScreenUtil().setVerticalSpacing(30),
                      if (state.status == LocationStatus.loading)
                        const CustomCircularProgressIndicator(),
                    ],
                  );
                },
              ),
            )));
  }
}

class CustomCircularProgressIndicator extends StatelessWidget {
  const CustomCircularProgressIndicator({
    Key key,
    this.height = 110.0,
    this.width = 110.0,
    this.elevation = 1.0,
  }) : super(key: key);

  final double height;
  final double width;
  final double elevation;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height.sp,
      width: width.sp,
      child: Card(
        elevation: elevation,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(50),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Center(
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(
                locator<AppThemeColors>().secondaryColor.toMaterialColor(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
