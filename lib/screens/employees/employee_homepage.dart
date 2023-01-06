import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:wuchers_garage/providers/task_provider.dart';
import 'package:wuchers_garage/utilities/models/task_model.dart';
import 'package:wuchers_garage/widgets/assigned_tasks.dart';
import 'package:wuchers_garage/widgets/constants.dart';
import 'package:wuchers_garage/widgets/garage_appbar.dart';
import 'package:wuchers_garage/widgets/tasks_calendar.dart';

class EmployeeHomepage extends StatelessWidget {
  EmployeeHomepage({Key? key}) : super(key: key);

  final _currentUser = FirebaseAuth.instance.currentUser!.displayName;

  final _taskCollection =
      FirebaseFirestore.instance.collection('tasks').orderBy(
            'date',
          );

  @override
  Widget build(BuildContext context) {
    TaskProvider taskProvider =
        Provider.of<TaskProvider>(context, listen: false);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: const GarageAppBar(
          tabLabels: [
            'Assigned Tasks',
            'Calendar',
          ],
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: _taskCollection.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return kProgressIndicator;
            }

            if (snapshot.hasError) {
              return kErrorMessage;
            }

            if (!snapshot.hasData) {
              return kDateNow;
            }

            for (var doc in snapshot.data!.docs) {
              taskProvider.getAssignedTasks.clear();
              if (_currentUser == doc['assigned_to']) {
                WidgetsBinding.instance.addPostFrameCallback(
                  (_) {
                    taskProvider.addToAssignedTasks(
                      TaskData(
                        title: doc['title'],
                        date: doc['date'],
                        description: doc['desc'],
                        priority: doc['priority'],
                        assignedBy: doc['assigned_by'],
                        assignedTo: doc['assigned_to'],
                      ),
                    );
                  },
                );
              }
            }

            return TabBarView(
              children: [
                AssignedTasks(taskProvider: taskProvider, snapshot: snapshot),
                TasksCalendar(snapshot: snapshot),
              ],
            );
          },
        ),
      ),
    );
  }
}
