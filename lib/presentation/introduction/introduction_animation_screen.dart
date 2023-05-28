import 'package:weather/app+injection/di.dart';
import 'package:weather/core/blocs/application_bloc/app_bloc.dart';
import 'package:weather/core/mediators/communication_types/AppStatus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/presentation/root_flow/screens/root_page.dart';
import '../../core/resources/colors.dart';
import 'components/center_next_button.dart';
import 'components/future_of_shopping.dart';
import 'components/get_everything_view.dart';
import 'components/splash_view.dart';
import 'components/the_one_stop_view.dart';
import 'components/top_back_skip_view.dart';
import 'components/welcome_view.dart';

class IntroductionAnimationScreen extends StatefulWidget {
  const IntroductionAnimationScreen({Key key}) : super(key: key);

  @override
  _IntroductionAnimationScreenState createState() =>
      _IntroductionAnimationScreenState();
}

class _IntroductionAnimationScreenState
    extends State<IntroductionAnimationScreen> with TickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 8));
    _animationController?.animateTo(0.0);
    super.initState();
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(_animationController?.value);
    return Scaffold(
      backgroundColor: locator<AppThemeColors>().backgroundColor,
      body: ClipRect(
        child: Stack(
          children: [
            SplashView(
              animationController: _animationController,
            ),
            GetEverythingView(
              animationController: _animationController,
            ),
            CareView(
              animationController: _animationController,
            ),
            FutureOfShoppingVew(
              animationController: _animationController,
            ),
            WelcomeView(
              animationController: _animationController,
            ),
            TopBackSkipView(
              onBackClick: _onBackClick,
              onSkipClick: _onSkipClick,
              animationController: _animationController,
            ),
            CenterNextButton(
              animationController: _animationController,
              onNextClick:() {  _onNextClick(context);},
            ),
          ],
        ),
      ),
    );
  }

  void _onSkipClick() {
    _animationController?.animateTo(0.8,
        duration: Duration(milliseconds: 1200));
  }

  void _onBackClick() {
    if (_animationController.value >= 0 &&
        _animationController.value <= 0.2) {
      _animationController?.animateTo(0.0, duration: const Duration(milliseconds: 1000));
    } else if (_animationController.value > 0.2 &&
        _animationController.value <= 0.4) {
      _animationController?.animateTo(0.2, duration: const Duration(milliseconds: 1000));
    } else if (_animationController.value > 0.4 &&
        _animationController.value <= 0.6) {
      _animationController?.animateTo(0.4, duration: const Duration(milliseconds: 1000));
    } else if (_animationController.value > 0.6 &&
        _animationController.value <= 0.8) {
      _animationController?.animateTo(0.6, duration: const Duration(milliseconds: 1000));
    } else if (_animationController.value > 0.8 &&
        _animationController.value <= 1.0) {
      _animationController?.animateTo(0.8, duration: const Duration(milliseconds: 1000));
    }
  }

  void _onNextClick(BuildContext context) {
    if (_animationController.value >= 0 &&
        _animationController.value <= 0.2) {
      _animationController?.animateTo(0.4, duration: const Duration(milliseconds: 1000));
    } else if (_animationController.value > 0.2 &&
        _animationController.value <= 0.4) {
      _animationController?.animateTo(0.6, duration: const Duration(milliseconds: 1000));
    } else if (_animationController.value > 0.4 &&
        _animationController.value <= 0.6) {
      _animationController?.animateTo(0.8, duration: const Duration(milliseconds: 1000));
    } else if (_animationController.value > 0.6 &&
        _animationController.value <= 0.8) {

      context.read<AppBloc>().setAppStatus(AppStatus(data: Status.unauthorized), isFirstTime: false);
     // Navigator.of(context).pop();
     // _signUpClick();
    }
  }

  void _signUpClick() {
    Navigator.push(context, MaterialPageRoute(builder: (context)=> RootPageWidget()));
  }
}
