import 'package:flutter/material.dart';
import 'package:wuchers_garage/utilities/auth.dart';
import 'package:wuchers_garage/widgets/settings_field_input.dart';

class ChangeEmail extends StatelessWidget {
  ChangeEmail({Key? key}) : super(key: key);

  final Authentication _authenticate = Authentication();

  //controllers
  final TextEditingController _emailController = TextEditingController();

  //keys
  final _changeEmailKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return GestureDetector(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.only(
            top: 10.0,
            bottom: 8.0,
          ),
          child: Text(
            'Change email',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: mediaQuery.textScaleFactor * 15.0,
            ),
          ),
        ),
      ),
      onTap: () {
        showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: const Text(
                'Change email',
                textAlign: TextAlign.center,
              ),
              elevation: 2.0,
              content: Form(
                key: _changeEmailKey,
                child: SettingsFieldInput(
                  label: 'New Email',
                  controller: _emailController,
                  autofocus: true,
                  keyboard: TextInputType.emailAddress,
                  onSub: (_) {
                    if (_changeEmailKey.currentState!.validate()) {
                      _authenticate.updateEmailAddress(_emailController.text);
                      _emailController.clear();
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }
}
