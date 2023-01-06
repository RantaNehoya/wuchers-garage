import 'package:flutter/material.dart';

class SettingsFieldInput extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final FocusNode? focusNode;
  final TextInputType keyboard;
  final bool autofocus;
  final Function(String)? onSub;

  const SettingsFieldInput(
      {Key? key, required this.label, required this.controller, this.focusNode, required this.keyboard, required this.autofocus, required this.onSub})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return TextFormField(
      cursorColor: Theme
          .of(context)
          .primaryColorDark,
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: Theme
              .of(context)
              .primaryColorLight,
          fontSize: mediaQuery.textScaleFactor * 12.0,
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Theme
                .of(context)
                .primaryColorDark,
            width: 2.0,
          ),
        ),
      ),
      controller: controller,
      focusNode: focusNode,
      validator: (input) {
        if (input == null || input.isEmpty) {
          return 'Cannot leave field empty';
        }
        return null;
      },
      keyboardType: keyboard,
      autofocus: autofocus,
      onFieldSubmitted: onSub,
    );
  }
}
