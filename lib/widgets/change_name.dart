import 'package:flutter/material.dart';
import 'package:wuchers_garage/utilities/auth.dart';
import 'package:wuchers_garage/widgets/settings_field_input.dart';

class ChangeName extends StatelessWidget {
  ChangeName({Key? key}) : super(key: key);

  final Authentication _authenticate = Authentication();

  //controllers
  final TextEditingController _nameController = TextEditingController();

  //keys
  final _changeNameKey = GlobalKey<FormState>();

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
            'Change name',
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
                'Change name',
                textAlign: TextAlign.center,
              ),
              elevation: 2.0,
              content: Form(
                key: _changeNameKey,
                child: SettingsFieldInput(
                  label: 'User Name',
                  controller: _nameController,
                  autofocus: true,
                  keyboard: TextInputType.name,
                  onSub: (_) {
                    if (_changeNameKey.currentState!.validate()) {
                      _authenticate.updateDisplayName(_nameController.text);
                      _nameController.clear();
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
