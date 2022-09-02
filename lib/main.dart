import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:theme_mode_handler/theme_mode_handler.dart';
import 'package:theme_mode_handler/theme_mode_manager_interface.dart';

import 'app/app.locator.dart';
import 'app/app.router.dart';
import 'app/app_theme.dart';
import 'app/setup_dialog_ui.dart';
import 'services/shared_preferences_service.dart';
import 'views/settings/models/language.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  setupLocator();
  setupDialogUi();

  runApp(EasyLocalization(
    path: 'assets/languages',
    supportedLocales: LanguageModel.languages.map((e) => e.locale).toList(),
    child: const MainApp(),
  ));
}

class AppThemeModeManager implements IThemeModeManager {
  final _preference = locator<SharedPreferencesService>();

  @override
  Future<String> loadThemeMode() async {
    return _preference.themeMode;
  }

  @override
  Future<bool> saveThemeMode(String value) async {
    _preference.themeMode = value;
    return true;
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemeModeHandler(
      manager: AppThemeModeManager(),
      builder: (themeMode) => MaterialApp(
        title: 'title'.tr(),
        locale: context.locale,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: themeMode,
        debugShowCheckedModeBanner: false,
        supportedLocales: context.supportedLocales,
        localizationsDelegates: context.localizationDelegates,
        navigatorKey: StackedService.navigatorKey,
        onGenerateRoute: StackedRouter().onGenerateRoute,
      ),
    );
  }
}
