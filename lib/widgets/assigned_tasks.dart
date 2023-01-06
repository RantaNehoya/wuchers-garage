import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:wuchers_garage/providers/task_provider.dart';
import 'package:wuchers_garage/widgets/listtile_richtext.dart';

class AssignedTasks extends StatelessWidget {
  final TaskProvider taskProvider;
  final AsyncSnapshot<QuerySnapshot<Object?>> snapshot;

  AssignedTasks({Key? key, required this.taskProvider, required this.snapshot})
      : super(key: key);

  final _completedTasksCollection =
      FirebaseFirestore.instance.collection('completed_tasks');

  Color _priority(String priority) {
    if (priority == 'Low') {
      return Colors.green.withOpacity(
        0.3,
      );
    } else if (priority == 'Medium') {
      return Colors.orange.withOpacity(
        0.3,
      );
    } else {
      return Colors.red.withOpacity(
        0.3,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);

    return Column(
      children: List.generate(
        taskProvider.getAssignedTasks.length,
        (index) {
          var task = taskProvider.getAssignedTasks[index];
          return Slidable(
            actionPane: const SlidableDrawerActionPane(),
            actionExtentRatio: 0.25,
            child: ListTile(
              tileColor: _priority(task.priority),
              leading: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    8.0,
                  ),
                  border: Border.all(
                    color: Theme.of(context).primaryColorDark,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(
                    8.0,
                  ),
                  child: ListTileRichText(
                    title: 'Due:\n',
                    subtitle: DateFormat.yMMMd().format(
                      DateTime.parse(
                        task.date,
                      ),
                    ),
                  ),
                ),
              ),
              title: Text(
                task.title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: mediaQuery.textScaleFactor * 20.0,
                ),
              ),
              subtitle: Text(
                task.description,
              ),
              trailing: FittedBox(
                child: ListTileRichText(
                  title: 'Assigned by:\n',
                  subtitle: task.assignedBy!,
                ),
              ),
            ),
            secondaryActions: [
              IconSlideAction(
                caption: 'Mark as Done',
                color: Theme.of(context).primaryColor,
                icon: Icons.check,
                onTap: () {
                  _completedTasksCollection.add(
                    {
                      'title': task.title,
                      'date': task.date,
                      'desc': task.description,
                      'priority': task.priority,
                      'assigned_by': task.assignedBy,
                      'assigned_to': task.assignedTo,
                    },
                  );

                  for (var snap in snapshot.data!.docs) {
                    if (snap['desc'] == task.description) {
                      snap.reference.delete();
                    }
                  }
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
