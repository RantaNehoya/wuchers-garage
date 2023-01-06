import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wuchers_garage/providers/employee_provider.dart';
import 'package:wuchers_garage/widgets/account_dialog.dart';
import 'package:wuchers_garage/widgets/change_name.dart';
import 'package:wuchers_garage/widgets/change_password.dart';
import 'package:wuchers_garage/widgets/constants.dart';
import 'package:wuchers_garage/widgets/generate_pdf.dart';
import 'package:wuchers_garage/widgets/headings.dart';
import 'package:wuchers_garage/widgets/log_out.dart';
import 'package:wuchers_garage/widgets/profile_avatar_block.dart';
import 'package:wuchers_garage/widgets/view_staff_button.dart';

class WucherProfile extends StatefulWidget {
  const WucherProfile({Key? key}) : super(key: key);

  @override
  State<WucherProfile> createState() => _WucherProfileState();
}

class _WucherProfileState extends State<WucherProfile> {
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
                employeeProvider: employeeProvider,
                position: 'Owner',
              ),

              SizedBox(
                height: size.height * 0.02,
              ),

              //change name
              ChangeName(),

              kDivider,

              //change password
              ChangePassword(),

              kDivider,

              //log out
              Logout(),
              kDivider,

              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),

              //manage staff
              const ManageStaff(),

              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),

              //add account
              GestureDetector(
                child: const SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: 10.0,
                      bottom: 8.0,
                    ),
                    child: Text(
                      'Add User Account',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15.0,
                      ),
                    ),
                  ),
                ),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return const SingleChildScrollView(
                        child: AccountDialog(),
                      );
                    },
                  );
                },
              ),
              kDivider,

              //view staff members
              const ViewStaffButton(),
              kDivider,

              //generate report
              const GeneratePDF(),
            ],
          ),
        ),
      ),
    );
  }
}
