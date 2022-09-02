import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../app/app.locator.dart';
import '../../app/app.router.dart';

class HomeView extends StatelessWidget {
  final _navigationService = locator<NavigationService>();

  HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Boilerplate'),
      ),
      body: const Center(
        child: Text('...'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.settings),
        onPressed: () => _navigationService.navigateTo(Routes.settingsView),
      ),
    );
  }
}
