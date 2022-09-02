import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:stacked_services/stacked_services.dart';

import 'app.locator.dart';

enum DialogType { base, form, loading }

void setupDialogUi() {
  final dialog = locator<DialogService>();

  final builders = {
    DialogType.base: (context, sheetRequest, completer) =>
        _BasicCustomDialog(request: sheetRequest, completer: completer),
    DialogType.form: (context, sheetRequest, completer) =>
        _FormCustomDialog(request: sheetRequest, completer: completer),
    DialogType.loading: (context, sheetRequest, completer) =>
        _LoadingCustomDialog(message: sheetRequest.description),
  };

  dialog.registerCustomDialogBuilders(builders);
}

class _BasicCustomDialog extends StatelessWidget {
  final DialogRequest request;
  final Function(DialogResponse) completer;
  const _BasicCustomDialog(
      {Key? key, required this.request, required this.completer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            request.title ?? '',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
          ),
          const SizedBox(height: 10),
          Text(
            request.description ?? '',
            style: const TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () => completer(DialogResponse(confirmed: true)),
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 10),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.circular(5),
              ),
              child: request.showIconInMainButton ?? false
                  ? const Icon(Icons.check_circle)
                  : Text(request.mainButtonTitle ?? 'close'.tr()),
            ),
          )
        ],
      ),
    );
  }
}

class _FormCustomDialog extends HookWidget {
  final DialogRequest request;
  final Function(DialogResponse) completer;
  const _FormCustomDialog(
      {Key? key, required this.request, required this.completer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = useTextEditingController();
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            request.title ?? '',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
          ),
          const SizedBox(height: 20),
          TextField(controller: controller),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () => completer(DialogResponse(data: [controller.text])),
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 10),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.circular(5),
              ),
              child: request.showIconInMainButton ?? false
                  ? const Icon(Icons.check_circle)
                  : Text(request.mainButtonTitle ?? 'close'.tr()),
            ),
          )
        ],
      ),
    );
  }
}

class _LoadingCustomDialog extends StatelessWidget {
  final String message;
  const _LoadingCustomDialog({Key? key, required this.message})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20.0),
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: Theme.of(context).canvasColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 20.0),
            Text(message, style: Theme.of(context).textTheme.subtitle1),
          ]),
        ),
      ],
    );
  }
}
