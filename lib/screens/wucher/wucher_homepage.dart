import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wuchers_garage/widgets/constants.dart';
import 'package:wuchers_garage/widgets/garage_appbar.dart';
import 'package:wuchers_garage/widgets/tasks_calendar.dart';
import 'package:wuchers_garage/widgets/view_all_tasks.dart';

class WucherHomepage extends StatelessWidget {
  WucherHomepage({Key? key}) : super(key: key);

  final _taskCollection =
  FirebaseFirestore.instance.collection('tasks').orderBy(
    'date',
  );
  final _completedTasksCollection =
  FirebaseFirestore.instance.collection('completed_tasks').orderBy(
    'date',
  );

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: const GarageAppBar(
          tabLabels: ['All Tasks', 'Calendar', 'Completed Tasks'],
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream: _completedTasksCollection.snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> compSnapshot) {
              if (compSnapshot.connectionState == ConnectionState.waiting) {
                return kProgressIndicator;
              }

              if (compSnapshot.hasError) {
                return kErrorMessage;
              }

              if (!compSnapshot.hasData) {
                return kDateNow;
              }

              return StreamBuilder<QuerySnapshot>(
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

                  return TabBarView(
                    children: [
                      ViewTasks(snapshot: snapshot),
                      TasksCalendar(snapshot: snapshot),
                      ViewTasks(snapshot: compSnapshot),
                    ],
                  );
                },
              );
            }),
      ),
    );
  }
}
