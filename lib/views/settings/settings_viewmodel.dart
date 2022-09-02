import 'package:stacked/stacked.dart';

import '../../app/app.locator.dart';
import '../../services/shared_preferences_service.dart';
import 'models/environment.dart' as env;
import 'models/language.dart';

class SettingsViewModel extends BaseViewModel {
  final _prefrence = locator<SharedPreferencesService>();

  Language get language => _prefrence.language;
  set language(value) {
    _prefrence.language = value;
    notifyListeners();
  }

  env.Environment get environment => _prefrence.environment;
  set environment(value) {
    _prefrence.environment = value;
    notifyListeners();
  }

  String get themeMode => _prefrence.themeMode.split('.').last;
  set themeMode(value) {
    _prefrence.themeMode = value;
    notifyListeners();
  }

  bool get darkModeEnabled => _prefrence.darkModeEnabled;
  set darkModeEnabled(value) {
    _prefrence.darkModeEnabled = value;
    notifyListeners();
  }

  String get version => _prefrence.version;
}
