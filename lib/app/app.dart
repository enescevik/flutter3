import 'package:flutter3/apis/authenticate_api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

import '../services/shared_preferences_service.dart';
import '../views/home/home_view.dart';
import '../views/login/login_view.dart';
import '../views/settings/settings_view.dart';

@StackedApp(routes: [
  MaterialRoute(page: LoginView, initial: true),
  MaterialRoute(page: HomeView),
  CustomRoute(
    page: SettingsView,
    transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
  ),
], dependencies: [
  Singleton(classType: SharedPreferences),
  Singleton(classType: DialogService),
  Singleton(classType: SnackbarService),
  Singleton(classType: BottomSheetService),
  Singleton(classType: NavigationService),
  LazySingleton(classType: AuthenticateApi),
  Presolve(
    classType: SharedPreferencesService,
    presolveUsing: SharedPreferencesService.getInstance,
  ),
])
class App {}
