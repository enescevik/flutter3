import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../apis/models/user/user.dart';
import '../views/settings/models/environment.dart' as env;
import '../views/settings/models/language.dart';

@lazySingleton
class SharedPreferencesService {
  static PackageInfo? _packageInfo;
  static SharedPreferences? _localStorage;
  static SharedPreferencesService? _instance;

  static Future<SharedPreferencesService> getInstance() async {
    if (_instance == null) {
      _packageInfo = await PackageInfo.fromPlatform();
      _localStorage = await SharedPreferences.getInstance();
      _instance = SharedPreferencesService();
    }

    return Future.value(_instance);
  }

  String get version => _packageInfo?.version ?? '';

  String get packageName => _packageInfo?.packageName ?? '';

  bool get isDebug => !kReleaseMode;

  User? currentUser;

  Language? _language;
  Language get language => _language ??= LanguageModel.languages.firstWhere(
      (e) => e.id == _localStorage?.getInt('languageId'),
      orElse: () => LanguageModel.languages.first);
  set language(Language value) {
    _language = value;
    _localStorage?.setInt('languageId', value.id);
  }

  env.Environment? _environment;
  env.Environment get environment =>
      _environment ??= env.EnvironmentModel.environments.firstWhere(
          (e) => e.id == _localStorage?.getInt('environmentId'),
          orElse: () => env.EnvironmentModel.environments.first);
  set environment(env.Environment value) {
    _environment = value;
    _localStorage?.setInt('environmentId', value.id);
  }

  String? _themeMode;
  String get themeMode => _themeMode ??=
      _localStorage!.getString('themeMode') ?? 'ThemeMode.system';
  set themeMode(String? value) {
    _themeMode = value;
    _localStorage!.setString('themeMode', value ?? 'ThemeMode.system');
  }

  bool? _darkModeEnabled;
  bool get darkModeEnabled =>
      _darkModeEnabled ??= _localStorage!.getBool('darkModeEnabled') ?? false;
  set darkModeEnabled(bool value) {
    _darkModeEnabled = value;
    _localStorage?.setBool('darkModeEnabled', value);
  }
}
