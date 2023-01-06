import 'package:flutter/material.dart';

class ManageStaff extends StatelessWidget {
  const ManageStaff({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);

    return Text(
      'Manage Staff',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: mediaQuery.textScaleFactor * 20.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class DangerZone extends StatelessWidget {
  const DangerZone({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);

    return Text(
      'Danger Zone',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: mediaQuery.textScaleFactor * 20.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
