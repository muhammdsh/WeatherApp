import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:weather/core/api/auth_interceptor.dart';
import 'package:weather/core/blocs/application_bloc/app_bloc.dart';
import 'package:weather/core/mediators/bloc_hub/concrete_hub.dart';
import 'package:weather/core/mediators/bloc_hub/hub.dart';
import 'package:weather/core/mediators/bloc_hub/members_key.dart';
import 'package:weather/core/services/image_picker_service.dart';
import 'package:weather/core/services/location_service.dart';
import 'package:weather/core/services/session_manager.dart';
import 'package:weather/core/services/theme_store.dart';
import 'package:weather/core/services/user_store.dart';
import 'package:weather/core/usecases/app_theme_usecases.dart';
import 'package:weather/core/usecases/check_first_initialize_usecase.dart';
import 'package:weather/data/datasources/auth_data_source/auth_data_source_impl.dart';
import 'package:weather/data/datasources/product_data_source/weather_data_source.dart';
import 'package:weather/data/datasources/product_data_source/weather_data_source_impl.dart';
import 'package:weather/data/repositories/auth_repository_impl.dart';
import 'package:weather/data/repositories/weather_reposotory_impl.dart';
import 'package:weather/domain/repositories/weather_repository.dart';
import 'package:weather/domain/usecases/auth_use_cases.dart';
import 'package:weather/domain/usecases/getLocationUseCase.dart';
import 'package:weather/domain/usecases/image_picker_use_cases.dart';
import 'package:weather/domain/usecases/weather_usecases.dart';
import 'package:weather/presentation/fa%C3%A7ades/app_facade.dart';
import 'package:weather/presentation/home_flow/blocs/location_bloc.dart';

import '../core/services/init_app_store.dart';
import '../presentation/root_flow/bloc/root_bloc.dart';
import '../presentation/root_flow/screens/root_page.dart';
import '../presentation/weather_flow/bloc/weather_bloc.dart';

final locator = GetIt.instance;

Future<void> setUpLocator() async {
  locator.registerLazySingleton<BlocHub>(() => ConcreteHub());

  locator.registerLazySingleton<ThemeStore>(() => ThemeStore());

  locator.registerLazySingleton<InitAppStore>(() => InitAppStore());

  locator.registerLazySingleton<SetAppThemeUseCase>(
      () => SetAppThemeUseCase(locator<ThemeStore>()));

  locator.registerLazySingleton<GetAppThemeUseCase>(
      () => GetAppThemeUseCase(locator<ThemeStore>()));

  locator.registerLazySingleton<CheckFirstInitUseCase>(
      () => CheckFirstInitUseCase(locator<InitAppStore>()));

  locator.registerLazySingleton<SetFirstTimeUseCase>(
      () => SetFirstTimeUseCase(locator<InitAppStore>()));
 locator.registerLazySingleton<AuthDataSourceImpl>(() => AuthDataSourceImpl());

  locator.registerLazySingleton<SessionManager>(() => SessionManager());
  locator.registerFactory<Dio>(() => Dio());

  locator.registerLazySingleton<AuthInterceptor>(
      () => AuthInterceptor(locator<SessionManager>(), locator<Dio>()));

  locator.registerLazySingleton<UserStore>(() => UserStore());

  locator.registerLazySingleton<AuthRepositoryImpl>(() => AuthRepositoryImpl(
      authDataSource: locator<AuthDataSourceImpl>(),
      sessionManager: locator<SessionManager>(),
      userStore: locator<UserStore>()));



  locator.registerLazySingleton<CheckLoginStatusUseCase>(
      () => CheckLoginStatusUseCase(
            authRepository: locator<AuthRepositoryImpl>(),
          ));

  locator.registerLazySingleton<AppUiFacade>(() => AppUiFacade(
        setAppThemeUseCase: locator<SetAppThemeUseCase>(),
        getAppThemeUseCase: locator<GetAppThemeUseCase>(),
        checkFirstInitUseCase: locator<CheckFirstInitUseCase>(),
        setFirstTimeUseCase: locator<SetFirstTimeUseCase>(),

        checkLoginStatusUseCase: locator<CheckLoginStatusUseCase>(),
      ));

  locator.registerLazySingleton<LoginUseCase>(
      () => LoginUseCase(authRepository: locator<AuthRepositoryImpl>()));
  locator.registerLazySingleton<VerifyOTPUseCase>(
      () => VerifyOTPUseCase(authRepository: locator<AuthRepositoryImpl>()));
  locator.registerLazySingleton<LogoutUseCase>(
      () => LogoutUseCase(authRepository: locator<AuthRepositoryImpl>()));



  locator.registerLazySingleton<AppBloc>(
      () => AppBloc(appUiFacade: locator<AppUiFacade>()));

  locator.registerLazySingleton<ImagePickerService>(() => ImagePickerService());

  locator.registerLazySingleton<GetImageFromCameraUseCase>(
      () => GetImageFromCameraUseCase(locator<ImagePickerService>()));

  locator.registerLazySingleton<GetImageFromGalleryUseCase>(
      () => GetImageFromGalleryUseCase(locator<ImagePickerService>()));

  locator
      .registerLazySingleton<WeatherDataSource>(() => WeatherDataSourceImpl());

  locator.registerLazySingleton<WeatherRepository>(
      () => WeatherRepositoryImpl(locator<WeatherDataSource>()));

  locator.registerLazySingleton<GetHourlyUseCase>(
      () => GetHourlyUseCase(locator<WeatherRepository>()));

  locator.registerLazySingleton<GetDailyUseCase>(
      () => GetDailyUseCase(locator<WeatherRepository>()));

  locator.registerLazySingleton(() => LocationService());
  locator.registerLazySingleton(
      () => GetLocationUseCase(locator<LocationService>()));
  locator
      .registerLazySingleton(() => LocationBloc(locator<GetLocationUseCase>()));

  locator.registerLazySingleton(() => NavigationController());
  locator.registerLazySingleton(() => RootBloc());
  locator.registerLazySingleton(() =>
      WeatherBloc(locator<GetHourlyUseCase>(), locator<GetDailyUseCase>()));

  locator<BlocHub>().registerByName(locator<AppBloc>(), MembersKeys.appBloc);
  locator<BlocHub>().registerByName(locator<RootBloc>(), MembersKeys.rootBloc);
  locator<BlocHub>()
      .registerByName(locator<WeatherBloc>(), MembersKeys.weatherBloc);
  locator<BlocHub>()
      .registerByName(locator<LocationBloc>(), MembersKeys.locationBloc);
}
