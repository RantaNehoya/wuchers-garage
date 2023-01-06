import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wuchers_garage/widgets/headings.dart';
import 'package:wuchers_garage/providers/employee_provider.dart';
import 'package:wuchers_garage/widgets/change_name.dart';
import 'package:wuchers_garage/widgets/change_password.dart';
import 'package:wuchers_garage/widgets/constants.dart';
import 'package:wuchers_garage/widgets/log_out.dart';
import 'package:wuchers_garage/widgets/profile_avatar_block.dart';
import 'package:wuchers_garage/widgets/delete_account.dart';
import 'package:wuchers_garage/widgets/change_email.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    EmployeeProvider employeeProvider = Provider.of<EmployeeProvider>(context);
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              ProfileAvatarBlock(
                  employeeProvider: employeeProvider, position: 'Staff'),

              SizedBox(
                height: size.height * 0.02,
              ),

              //change name
              ChangeName(),

              kDivider,

              //change email
              ChangeEmail(),
              kDivider,

              //change password
              ChangePassword(),

              kDivider,

              //log out
              Logout(),
              kDivider,

              SizedBox(
                height: size.height * 0.02,
              ),

              //manage staff
              // const DangerZone(),
              //
              // SizedBox(
              //   height: size.height * 0.01,
              // ),
              //
              // //delete account
              // DeleteAccount(),
            ],
          ),
        ),
      ),
    );
  }
}
