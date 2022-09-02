import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:theme_mode_handler/theme_mode_handler.dart';

import '../../app/app.locator.dart';
import 'models/environment.dart';
import 'models/language.dart';
import 'settings_viewmodel.dart';

class SettingsView extends StatelessWidget {
  final _navigationService = locator<NavigationService>();

  SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SettingsViewModel>.reactive(
      viewModelBuilder: () => SettingsViewModel(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(title: Text('settings.title'.tr())),
        body: SafeArea(
          child: SettingsList(
            sections: [
              SettingsSection(
                title: Text('settings.common'.tr()),
                tiles: [
                  SettingsTile(
                    title: Text('settings.language'.tr()),
                    description: Text(model.language.name),
                    leading: const Icon(Icons.language),
                    onPressed: (context) => _navigationService
                        .navigateToView(_LanguagesView())
                        ?.then((_) => model.notifyListeners()),
                  ),
                  SettingsTile(
                    title: Text('settings.environment.title'.tr()),
                    description: Text(
                        'settings.environment.${model.environment.name}'.tr()),
                    leading: const Icon(Icons.cloud_queue),
                    onPressed: (context) => _navigationService
                        .navigateToView(_EnvironmentsView())
                        ?.then((_) => model.notifyListeners()),
                  ),
                ],
              ),
              SettingsSection(
                title: Text('settings.display.title'.tr()),
                tiles: [
                  SettingsTile(
                    title: Text('settings.display.theme_mode'.tr()),
                    description:
                        Text('settings.display.${model.themeMode}'.tr()),
                    leading: const Icon(Icons.settings_display),
                    onPressed: (context) => _navigationService
                        .navigateToView(_ThemeModeView())
                        ?.then((_) => model.notifyListeners()),
                  ),
                ],
              ),
              CustomSettingsSection(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 22.0, bottom: 8.0),
                      child:
                          Image.asset('assets/images/logo.png', width: 110.0),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 22.0),
                      child: Text(
                        'version'.tr(args: [model.version]),
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Color(0xFF777777)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LanguagesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SettingsViewModel>.reactive(
      viewModelBuilder: () => SettingsViewModel(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(title: Text('settings.common.language'.tr())),
        body: SafeArea(
          child: SettingsList(sections: [
            SettingsSection(
              tiles: LanguageModel.languages.map((language) {
                return SettingsTile(
                  title: Text(language.name),
                  trailing: model.language == language
                      ? const Icon(Icons.check)
                      : const Icon(null),
                  onPressed: (context) {
                    model.language = language;
                    context.setLocale(language.locale);
                  },
                );
              }).toList(),
            ),
          ]),
        ),
      ),
    );
  }
}

class _EnvironmentsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SettingsViewModel>.reactive(
      viewModelBuilder: () => SettingsViewModel(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(title: Text('settings.environment.title'.tr())),
        body: SafeArea(
          child: SettingsList(sections: [
            SettingsSection(
              tiles: EnvironmentModel.environments.map((environment) {
                return SettingsTile(
                  title: Text('settings.environment.${environment.name}'.tr()),
                  trailing: model.environment == environment
                      ? const Icon(Icons.check)
                      : const Icon(null),
                  onPressed: (context) => model.environment = environment,
                );
              }).toList(),
            ),
          ]),
        ),
      ),
    );
  }
}

class _ThemeModeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SettingsViewModel>.reactive(
      viewModelBuilder: () => SettingsViewModel(),
      builder: (context, model, child) => Scaffold(
          appBar: AppBar(title: Text('settings.display.theme_mode'.tr())),
          body: SafeArea(
            child: SettingsList(sections: [
              SettingsSection(
                tiles: ThemeMode.values.map((themeMode) {
                  final mode = '$themeMode'.split('.').last;

                  return SettingsTile(
                    title: Text('settings.display.$mode'.tr()),
                    trailing: model.themeMode == mode
                        ? const Icon(Icons.check)
                        : const Icon(null),
                    onPressed: (context) {
                      model.themeMode = mode;
                      ThemeModeHandler.of(context)?.saveThemeMode(themeMode);
                    },
                  );
                }).toList(),
              ),
            ]),
          )),
    );
  }
}
