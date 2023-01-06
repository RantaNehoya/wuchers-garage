import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:wuchers_garage/providers/employee_provider.dart';
import 'package:wuchers_garage/widgets/constants.dart';

class AssignEmployeesScreen extends StatelessWidget {
  AssignEmployeesScreen({Key? key}) : super(key: key);
  static const assignEmployees = 'assign_employees';

  final _staffCollection = FirebaseFirestore.instance.collection('staff');

  @override
  Widget build(BuildContext context) {
    EmployeeProvider employeeProvider = Provider.of<EmployeeProvider>(context);
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColorDark,
        title: const Text(
          'Assign Employees',
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

          var doc = snapshot.data!.docs;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(
                height: 16.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 10.0,
                ),
                child: Text(
                  'Select an Employee:',
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ),
              Divider(
                color: Theme.of(context).primaryColorLight.withOpacity(0.6),
                endIndent: 16.0,
                thickness: 1.0,
                indent: 16.0,
              ),
              const SizedBox(
                height: 16.0,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: doc.length,
                  itemBuilder: (context, index) {
                    var ref = doc[index];
                    return ListTile(
                      onTap: () =>
                          employeeProvider.setSelectedEmployee(ref['name']),
                      title: Text(
                        ref['name'],
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      leading: Container(
                        padding: const EdgeInsets.all(
                          8.0,
                        ),
                        decoration: (employeeProvider.getSelectedEmployee ==
                                ref['name'])
                            ? BoxDecoration(
                                shape: BoxShape.circle,
                                color: Theme.of(context)
                                    .primaryColorLight
                                    .withOpacity(
                                      0.8,
                                    ),
                              )
                            : BoxDecoration(
                                shape: BoxShape.circle,
                                color: Theme.of(context)
                                    .primaryColorLight
                                    .withOpacity(
                                      0.3,
                                    ),
                              ),
                        child:
                            employeeProvider.getSelectedEmployee == ref['name']
                                ? const Icon(
                                    Icons.check,
                                    color: Colors.white,
                                  )
                                : const Icon(
                                    Icons.account_circle_outlined,
                                  ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(
                  10.0,
                ),
                child: ElevatedButton(
                  child: const Text(
                    'Add Employees',
                  ),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Theme.of(context).primaryColorDark,
                    padding: const EdgeInsets.symmetric(
                      vertical: 20.0,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        15.0,
                      ),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
            ],
          );
        },
      ),
    );
  }
}
