import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_hooks/stacked_hooks.dart';

import '../../app/app.router.dart';
import 'login_viewmodal.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      viewModelBuilder: () => LoginViewModel(),
      builder: (context, model, child) => Scaffold(
        body: Container(
          alignment: Alignment.center,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(children: [
              _Logo(),
              _Version(),
              const SizedBox(height: 40.0),
              const _UserTextField(),
              const SizedBox(height: 30.0),
              const _PasswordTextField(),
              const SizedBox(height: 40.0),
              const _LoginButton(),
              const SizedBox(height: 20.0),
              const _ResetPasswordButton(),
            ]),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, Routes.settingsView),
          child: const Icon(Icons.settings),
        ),
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 80.0),
      constraints: const BoxConstraints(maxWidth: 400.0),
      child: const Image(image: AssetImage('assets/images/logo.png')),
    );
  }
}

class _Version extends ViewModelWidget<LoginViewModel> {
  @override
  Widget build(BuildContext context, LoginViewModel model) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, right: 40.0),
      child: Container(
        alignment: Alignment.centerRight,
        child: Text(
          'version'.tr(args: [model.version]),
          style: const TextStyle(color: Color(0xFF777777)),
        ),
      ),
    );
  }
}

class _UserTextField extends HookViewModelWidget<LoginViewModel> {
  const _UserTextField({Key? key}) : super(key: key, reactive: false);

  @override
  Widget buildViewModelWidget(BuildContext context, LoginViewModel model) {
    return TextField(
      autofocus: true,
      controller: model.usernameTextController,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: 'login.username'.tr(),
        prefixIcon: const Icon(Icons.person),
      ),
    );
  }
}

class _PasswordTextField extends HookViewModelWidget<LoginViewModel> {
  const _PasswordTextField({Key? key}) : super(key: key, reactive: false);

  @override
  Widget buildViewModelWidget(BuildContext context, LoginViewModel model) {
    return TextField(
      controller: model.passwordTextController,
      obscureText: !model.showPassword,
      decoration: InputDecoration(
        labelText: 'login.password'.tr(),
        prefixIcon: const Icon(Icons.lock),
        suffixIcon: IconButton(
          icon: Icon(
            model.showPassword ? Icons.visibility_off : Icons.visibility,
          ),
          onPressed: model.togglePassword,
        ),
      ),
    );
  }
}

class _LoginButton extends ViewModelWidget<LoginViewModel> {
  const _LoginButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, LoginViewModel model) {
    return ElevatedButton(
      onPressed: model.login,
      child: Text('login.login'.tr()),
    );
  }
}

class _ResetPasswordButton extends ViewModelWidget<LoginViewModel> {
  const _ResetPasswordButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, LoginViewModel model) {
    return TextButton(
      child: Text(
        'login.reset_password'.tr(),
        style: TextStyle(color: Theme.of(context).colorScheme.secondary),
      ),
      onPressed: () {},
    );
  }
}
