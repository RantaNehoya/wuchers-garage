import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:wuchers_garage/providers/employee_provider.dart';

class ConfirmTaskScreen extends StatelessWidget {
  ConfirmTaskScreen({Key? key}) : super(key: key);
  static const confirm = 'confirm_screen';

  final _taskCollection = FirebaseFirestore.instance.collection('tasks');

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    final routeArgs =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    EmployeeProvider setEmployee = Provider.of<EmployeeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColorDark,
        title: const Text('Confirm Task'),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(
          20.0,
        ),
        child: TextButton(
          child: const Text('SAVE'),
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(
              vertical: 20.0,
            ),
            foregroundColor: Colors.white,
            backgroundColor: Theme.of(context).primaryColorDark,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                15.0,
              ),
            ),
          ),
          onPressed: () {
            _taskCollection.add(
              {
                'title': routeArgs['title'],
                'desc': routeArgs['desc'],
                'date': routeArgs['date'],
                'priority': routeArgs['priority'],
                'assigned_to': routeArgs['assigned_to'],
                'assigned_by': routeArgs['assigned_by'],
              },
            );
            setEmployee.setSelectedEmployee('');
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Title: ${routeArgs['title']}',
              style: TextStyle(
                fontSize: mediaQuery.textScaleFactor * 30.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Description: ${routeArgs['desc']}',
              style: TextStyle(
                fontSize: mediaQuery.textScaleFactor * 15.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              'Due Date: ${DateFormat.yMMMd().format(
                DateTime.parse(
                  routeArgs['date'],
                ),
              )}',
              style: TextStyle(
                  fontSize: mediaQuery.textScaleFactor * 15.0,
                  fontWeight: FontWeight.normal,
                  fontStyle: FontStyle.italic),
            ),
            Text(
              'Priority: ${routeArgs['priority']}',
              style: TextStyle(
                fontSize: mediaQuery.textScaleFactor * 15.0,
              ),
            ),
            Text(
              'Assigned to: ${routeArgs['assigned_to']}',
              style: TextStyle(
                fontSize: mediaQuery.textScaleFactor * 15.0,
              ),
            ),
            Text(
              'Assigned by: ${routeArgs['assigned_by']}',
              style: TextStyle(
                fontSize: mediaQuery.textScaleFactor * 15.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
