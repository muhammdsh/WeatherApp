import 'package:weather/app+injection/di.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/resources/colors.dart';

class SplashView extends StatefulWidget {
  final AnimationController animationController;

  const SplashView({Key key, @required this.animationController})
      : super(key: key);

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  Widget build(BuildContext context) {
    final _introductionanimation =
        Tween<Offset>(begin: Offset(0, 0), end: Offset(0.0, -1.0))
            .animate(CurvedAnimation(
      parent: widget.animationController,
      curve: const Interval(
        0.0,
        0.2,
        curve: Curves.fastOutSlowIn,
      ),
    ));
    return SlideTransition(
      position: _introductionanimation,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.7 ,
              width: MediaQuery.of(context).size.width * 0.9,
              child: SvgPicture.asset(
                'lib/assets/shop.svg',
                fit: BoxFit.fitWidth,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Text(
                "Weather App",
                style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 64, right: 64),
              child: Text(
                "Lorem ipsum dolor sit amet,consectetur adipiscing elit,sed do eiusmod tempor incididunt ut labore",
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 38,
            ),
            Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).padding.bottom + 66),
              child: InkWell(
                onTap: () {
                  widget.animationController.animateTo(0.2, duration: Duration(milliseconds: 1000));
                },
                child: Container(
                  height: 58,
                  padding: EdgeInsets.only(
                    left: 56.0,
                    right: 56.0,
                    top: 16,
                    bottom: 16,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(38.0),
                    color: locator<AppThemeColors>().secondaryColor,
                  ),
                  child: Text(
                    "Let's begin with Weather App",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
