import 'package:flutter/material.dart';
import 'package:wuchers_garage/utilities/auth.dart';
import 'package:wuchers_garage/screens/login_screen.dart';

class Logout extends StatelessWidget {
  Logout({Key? key}) : super(key: key);

  final Authentication _authenticate = Authentication();

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
            'Log out',
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
              elevation: 2.0,
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    OutlinedButton(
                      onPressed: () {
                        _authenticate.logOut();

                        //navigate to login screen
                        Navigator.of(context).pop();

                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          LoginScreen.login,
                          (Route<dynamic> route) => false,
                        );
                      },
                      child: Text(
                        'Yes',
                        style: TextStyle(
                          color: Theme.of(context).primaryColorDark,
                        ),
                      ),
                    ),
                    OutlinedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'No',
                        style: TextStyle(
                          color: Theme.of(context).primaryColorDark,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
              content: const Text(
                'Do you wish to log out?',
                textAlign: TextAlign.center,
              ),
            );
          },
        );
      },
    );
  }
}
