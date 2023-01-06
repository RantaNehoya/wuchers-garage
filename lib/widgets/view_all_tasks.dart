import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:wuchers_garage/widgets/listtile_richtext.dart';

class ViewTasks extends StatelessWidget {
  final AsyncSnapshot<QuerySnapshot<Object?>> snapshot;

  const ViewTasks({Key? key, required this.snapshot}) : super(key: key);

  Color _priority(String priority) {
    if (priority == 'Low') {
      return Colors.green.withOpacity(0.3);
    } else if (priority == 'Medium') {
      return Colors.orange.withOpacity(0.3);
    } else {
      return Colors.red.withOpacity(0.3);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        snapshot.data!.size,
        (index) {
          var doc = snapshot.data!.docs[index];
          return Slidable(
            actionPane: const SlidableDrawerActionPane(),
            actionExtentRatio: 0.25,
            child: ListTile(
              tileColor: _priority(doc['priority']),
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
                      DateTime.parse(doc['date']),
                    ),
                  ),
                ),
              ),
              title: Text(
                doc['title'],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
              subtitle: Text(
                doc['desc'],
              ),
              trailing: FittedBox(
                child: Column(
                  children: [
                    ListTileRichText(
                      title: 'Assigned To:\n',
                      subtitle: doc['assigned_to'],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.005,
                    ),
                    ListTileRichText(
                      title: 'Assigned by:\n',
                      subtitle: doc['assigned_by'],
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              IconSlideAction(
                caption: 'Delete',
                color: Colors.red,
                icon: Icons.delete,
                onTap: () {
                  doc.reference.delete();
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
