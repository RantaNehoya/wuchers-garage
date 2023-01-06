import 'package:flutter/material.dart';
import 'package:wuchers_garage/utilities/auth.dart';
import 'package:wuchers_garage/widgets/settings_field_input.dart';

class AccountDialog extends StatefulWidget {
  const AccountDialog({Key? key}) : super(key: key);

  @override
  State<AccountDialog> createState() => _AccountDialogState();
}

class _AccountDialogState extends State<AccountDialog> {
  //keys
  final _addAccountKey = GlobalKey<FormState>();

  //auth
  final Authentication _authenticate = Authentication();

  //new user
  String _newUserName = '';
  String _newUserEmail = '';
  String _newUserPassword = '';
  bool _isObscure = true;
  bool isManager = false;

  //controllers
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  //focus nodes
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  @override
  void dispose() {
    //dispose controllers
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();

    //dispose focus nodes
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);

    return AlertDialog(
      title: const Text(
        'Add new user',
        textAlign: TextAlign.center,
      ),
      elevation: 2.0,
      content: Form(
        key: _addAccountKey,
        child: Column(
          children: <Widget>[
            SettingsFieldInput(
              label: 'Name and Surname',
              controller: _nameController,
              autofocus: true,
              keyboard: TextInputType.emailAddress,
              onSub: (_) {
                setState(
                  () {
                    FocusScope.of(context).requestFocus(_emailFocusNode);
                  },
                );
              },
            ),

            SettingsFieldInput(
              label: 'Email Address',
              controller: _emailController,
              autofocus: true,
              focusNode: _emailFocusNode,
              keyboard: TextInputType.emailAddress,
              onSub: (_) {
                setState(
                  () {
                    FocusScope.of(context).requestFocus(_passwordFocusNode);
                  },
                );
              },
            ),

            TextFormField(
              cursorColor: Theme.of(context).primaryColorDark,
              controller: _passwordController,
              focusNode: _passwordFocusNode,
              obscureText: _isObscure,
              validator: (input) {
                if (input == null || input.isEmpty) {
                  return 'Cannot leave field empty';
                }
                return null;
              },
              decoration: InputDecoration(
                labelText: 'Password',
                labelStyle: TextStyle(
                  color: Theme.of(context).primaryColorLight,
                  fontSize: mediaQuery.textScaleFactor * 12.0,
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).primaryColorDark,
                    width: 2.0,
                  ),
                ),
                suffixIcon: IconButton(
                  icon: _isObscure
                      ? const Icon(Icons.visibility_outlined)
                      : const Icon(Icons.visibility_off_outlined),
                  color: Theme.of(context).primaryColorDark,
                  onPressed: () {
                    setState(() {
                      _isObscure =
                          _isObscure ? _isObscure = false : _isObscure = true;
                    });
                  },
                ),
              ),
              onFieldSubmitted: (_) {
                setState(() {
                  FocusScope.of(context).unfocus();
                });
              },
            ),

            //manager switch
            SwitchListTile(
              title: const Text('Manager'),
              selected: isManager,
              value: isManager,
              activeColor: Theme.of(context).primaryColorDark,
              inactiveThumbColor: Theme.of(context).primaryColorLight,
              secondary: const Icon(Icons.account_circle_outlined),
              onChanged: (bool value) {
                setState(() {
                  isManager = value;
                });
              },
            ),

            //button
            Padding(
              padding: const EdgeInsets.all(
                30.0,
              ),
              child: SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Theme.of(context).primaryColorLight,
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(
                      10.0,
                    ),
                    child: Text('Create User'),
                  ),
                  onPressed: () async {
                    if (_addAccountKey.currentState!.validate()) {
                      setState(() {
                        _newUserName = _nameController.text;
                        _newUserEmail = _emailController.text;
                        _newUserPassword = _passwordController.text;
                      });

                      String msg = await _authenticate.createUser(
                        ctx: context,
                        email: _newUserEmail,
                        password: _newUserPassword,
                        name: _newUserName,
                        isManager: isManager,
                      );

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          duration: const Duration(
                            seconds: 2,
                          ),
                          content: Text(msg),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );

                      _nameController.clear();
                      _emailController.clear();
                      _passwordController.clear();
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
