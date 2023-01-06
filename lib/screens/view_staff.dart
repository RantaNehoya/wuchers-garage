import 'package:flutter/material.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:wuchers_garage/providers/employee_provider.dart';
import 'package:wuchers_garage/widgets/constants.dart';

class ViewStaffScreen extends StatefulWidget {
  const ViewStaffScreen({Key? key}) : super(key: key);
  static const viewStaff = 'view_staff';

  @override
  State<ViewStaffScreen> createState() => _ViewStaffScreenState();
}

class _ViewStaffScreenState extends State<ViewStaffScreen> {
  final _staffCollection =
      FirebaseFirestore.instance.collection('staff').orderBy('name');

  @override
  Widget build(BuildContext context) {
    EmployeeProvider employeeProvider = Provider.of<EmployeeProvider>(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColorDark,
          title: const Text(
            'Current Staff',
          ),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_outlined),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: _staffCollection.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return kProgressIndicator;
            }

            if (snapshot.hasError) {
              return kErrorMessage;
            }

            if (!snapshot.hasData) {
              return kNoEmployees;
            }

            return ListView.builder(
              itemCount: snapshot.data!.size,
              itemBuilder: (context, index) {
                var staff = snapshot.data!.docs[index];
                return ListTile(
                  title: Text('${staff['name']}'),
                  subtitle: Text(
                    staff['isManager'] ? 'Manager' : 'Employee',
                  ),
                  leading: Image(
                    fit: BoxFit.contain,
                    width: 50.0,
                    image: staff['photoUrl'] == ''
                        ? const AssetImage('assets/images/unknown.png')
                        : FileImage(File(staff['photoUrl'])) as ImageProvider,
                  ),
                  trailing: Visibility(
                    visible: employeeProvider.getCurrentEmployeeUID ==
                        'zXs0A1f7GjXNdoZg0sVBK0blobF2',
                    child: Switch(
                      value: staff['isManager'],
                      activeColor: Theme.of(context).primaryColorDark,
                      inactiveThumbColor: Theme.of(context).primaryColorLight,
                      onChanged: (selected) async {
                        setState(
                          () {
                            staff.reference.update(
                              {
                                'isManager': selected,
                              },
                            );
                          },
                        );
                      },
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
