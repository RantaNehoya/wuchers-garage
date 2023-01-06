import 'package:flutter/material.dart';
import 'package:wuchers_garage/screens/view_staff.dart';

class ViewStaffButton extends StatelessWidget {
  const ViewStaffButton({Key? key}) : super(key: key);

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
            'View Staff',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: mediaQuery.textScaleFactor * 15.0,
            ),
          ),
        ),
      ),
      onTap: () {
        Navigator.of(context).pushNamed(
          ViewStaffScreen.viewStaff,
        );
      },
    );
  }
}
