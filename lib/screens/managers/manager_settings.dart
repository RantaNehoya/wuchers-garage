import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wuchers_garage/providers/employee_provider.dart';
import 'package:wuchers_garage/widgets/change_email.dart';
import 'package:wuchers_garage/widgets/change_name.dart';
import 'package:wuchers_garage/widgets/change_password.dart';
import 'package:wuchers_garage/widgets/constants.dart';
import 'package:wuchers_garage/widgets/generate_pdf.dart';
import 'package:wuchers_garage/widgets/headings.dart';
import 'package:wuchers_garage/widgets/log_out.dart';
import 'package:wuchers_garage/widgets/profile_avatar_block.dart';
import 'package:wuchers_garage/widgets/view_staff_button.dart';

class ManagerProfile extends StatefulWidget {
  const ManagerProfile({Key? key}) : super(key: key);

  @override
  State<ManagerProfile> createState() => _ManagerProfileState();
}

class _ManagerProfileState extends State<ManagerProfile> {
  //controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    //dispose controllers
    _emailController.dispose();
    _nameController.dispose();
    super.dispose();
  }

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
                  employeeProvider: employeeProvider, position: 'Manager'),

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
              const ManageStaff(),

              SizedBox(
                height: size.height * 0.01,
              ),

              //view staff members
              const ViewStaffButton(),
              kDivider,

              //generate report
              const GeneratePDF(),
              kDivider,

              SizedBox(
                height: size.height * 0.02,
              ),

              // const DangerZone(),
              //
              // SizedBox(
              //   height: size.height * 0.01,
              // ),
              //
              // //delete account
              // DeleteAccount(),
              //
              // SizedBox(
              //   height: size.height * 0.03,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
