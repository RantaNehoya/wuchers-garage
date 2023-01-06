import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_clean_calendar/flutter_clean_calendar.dart';
import 'package:provider/provider.dart';
import 'package:wuchers_garage/providers/task_provider.dart';
import 'package:wuchers_garage/utilities/models/task_model.dart';

class TasksCalendar extends StatelessWidget {
  final AsyncSnapshot<QuerySnapshot<Object?>> snapshot;

  const TasksCalendar({Key? key, required this.snapshot}) : super(key: key);

  void _addValueToMap<Key, Value>(
          Map<Key, List<Value>> map, Key key, Value value) =>
      map.update(key, (list) => list..add(value), ifAbsent: () => [value]);

  Map<DateTime, List<CleanCalendarEvent>> _getCalendarEvents(
      BuildContext context, List<QueryDocumentSnapshot<Object?>> docs) {
    Map<DateTime, List<CleanCalendarEvent>> dueDates = {};
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        TaskProvider taskProvider =
            Provider.of<TaskProvider>(context, listen: false);
        for (var doc in docs) {
          DateTime fb = DateTime.parse(doc['date']);

          if (!taskProvider.getTaskListData.contains(doc['desc'])) {
            taskProvider.addToTaskListData(
              TaskData(
                title: doc['title'],
                date: doc['date'],
                description: doc['desc'],
                priority: doc['priority'],
                assignedBy: doc['assigned_by'],
                assignedTo: doc['assigned_to'],
              ),
            );
          }

          _addValueToMap(
            dueDates,
            DateTime(fb.year, fb.month, fb.day),
            CleanCalendarEvent(
              doc['title'],
              startTime: DateTime(fb.year, fb.month, fb.day, 8, 0),
              endTime: DateTime(fb.year, fb.month, fb.day, 12, 0),
              description: doc['desc'],
              color: Theme.of(context).primaryColorDark,
            ),
          );
        }
      },
    );

    return dueDates;
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return Calendar(
      startOnMonday: true,
      isExpandable: true,
      isExpanded: true,
      hideTodayIcon: true,
      eventColor: Colors.grey,
      bottomBarArrowColor: Colors.grey,
      events: _getCalendarEvents(context, snapshot.data!.docs),
      dayOfWeekStyle: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w800,
        fontSize: mediaQuery.textScaleFactor * 11.0,
      ),
    );
  }
}
