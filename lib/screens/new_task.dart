import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:provider/provider.dart';
import 'package:wuchers_garage/providers/employee_provider.dart';
import 'package:wuchers_garage/screens/assign_employees.dart';
import 'package:wuchers_garage/screens/confirm_task.dart';
import 'package:wuchers_garage/utilities/models/task_model.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({Key? key}) : super(key: key);
  static const newTask = 'new_task';

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  final _data = TaskData(
    title: '',
    priority: '',
    description: '',
    date: '',
  );
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(DateTime.now().year - 3),
      lastDate: DateTime(DateTime.now().year + 10),
    );

    if (picked != null && picked != selectedDate) {
      setState(
        () {
          _data.date = picked.toString();
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    EmployeeProvider getEmployee = Provider.of<EmployeeProvider>(context);
    MediaQueryData mediaQuery = MediaQuery.of(context);
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColorDark,
        elevation: 0.0,
        title: const Text(
          'New Task',
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(
            15.0,
          ),
          child: Column(
            children: [
              Form(
                child: Container(
                  padding: const EdgeInsets.all(
                    5.0,
                  ),
                  child: Column(
                    children: [
                      GestureDetector(
                        child: Container(
                          padding: const EdgeInsets.all(
                            15.0,
                          ),
                          child: Text(
                            getEmployee.getSelectedEmployee == ''
                                ? 'Assign Employees'
                                : getEmployee.getSelectedEmployee,
                            style: const TextStyle(
                              color: Color(0xfff96060),
                            ),
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(
                              0.2,
                            ),
                            borderRadius: BorderRadius.circular(
                              10.0,
                            ),
                          ),
                        ),
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            AssignEmployeesScreen.assignEmployees,
                          );
                        },
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      TextFormField(
                        controller: _titleController,
                        decoration: InputDecoration(
                          hintText: 'Title',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              10.0,
                            ),
                          ),
                        ),
                        onChanged: (_) {
                          _data.title = _titleController.text;
                        },
                        style: TextStyle(
                          fontSize: mediaQuery.textScaleFactor * 18.0,
                        ),
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      Text(
                        'Description',
                        style: TextStyle(
                          fontSize: mediaQuery.textScaleFactor * 18.0,
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        height: 150,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(
                              15.0,
                            ),
                            topLeft: Radius.circular(
                              15.0,
                            ),
                          ),
                          border: Border.all(
                            color: Colors.grey.withOpacity(
                              0.5,
                            ),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(
                            8.0,
                          ),
                          child: TextFormField(
                            controller: _descController,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Add description here',
                            ),
                            style: TextStyle(
                              fontSize: mediaQuery.textScaleFactor * 18.0,
                            ),
                            onChanged: (_) {
                              _data.description = _descController.text;
                            },
                          ),
                        ),
                      ),
                      Container(
                        height: 50.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(
                              0.2,
                            ),
                            borderRadius: const BorderRadius.only(
                              bottomRight: Radius.circular(
                                15.0,
                              ),
                              bottomLeft: Radius.circular(
                                15.0,
                              ),
                            ),
                            border: Border.all(
                              color: Colors.grey.withOpacity(
                                0.5,
                              ),
                            )),
                        child: Row(
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.attach_file,
                                color: Colors.grey,
                              ),
                              onPressed: () {
                                _pickFile();
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 0.0,
                          padding: const EdgeInsets.all(
                            15.0,
                          ),
                          foregroundColor: const Color(0xfff96060),
                          backgroundColor: Colors.grey.withOpacity(
                            0.2,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              10.0,
                            ),
                          ),
                        ),
                        onPressed: () => _selectDate(context),
                        child: Text(
                          _data.date == ''
                              ? 'Due Date'
                              : DateFormat.yMMMd().format(
                                  DateTime.parse(_data.date),
                                ),
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(
                          8.0,
                        ),
                        child: Center(
                          child: Text(
                            'Level of Priority',
                            style: TextStyle(
                              fontSize: mediaQuery.textScaleFactor * 18,
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          PriorityButton(
                            data: _data,
                            priority: 'Low',
                            priorityColor: Colors.green,
                          ),
                          PriorityButton(
                            data: _data,
                            priority: 'Medium',
                            priorityColor: Colors.orange,
                          ),
                          PriorityButton(
                            data: _data,
                            priority: 'High',
                            priorityColor: Colors.red,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
              ElevatedButton(
                child: const Text(
                  'Add Task',
                ),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      8.0,
                    ),
                  ),
                  foregroundColor: Colors.white,
                  backgroundColor: Theme.of(context).primaryColorDark,
                  padding: EdgeInsets.symmetric(
                    vertical: 15.0,
                    horizontal: size.width * 0.2,
                  ),
                ),
                onPressed: () {
                  _titleController.clear();
                  _descController.clear();

                  Navigator.of(context).pop();
                  Navigator.of(context).pushNamed(
                    ConfirmTaskScreen.confirm,
                    arguments: {
                      'title': _data.title,
                      'desc': _data.description,
                      'date': _data.date == ''
                          ? DateTime.now().toString()
                          : _data.date,
                      'priority': _data.priority,
                      'assigned_to': getEmployee.getSelectedEmployee,
                      'assigned_by': getEmployee.getCurrentEmployee,
                    },
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  void _pickFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    //no file is picked
    if (result == null) return;

    //get file from result object
    final file = result.files.first;

    _openFile(file);
  }

  void _openFile(PlatformFile file) {
    OpenFile.open(file.path);
  }
}

class PriorityButton extends StatelessWidget {
  const PriorityButton({
    Key? key,
    required this.data,
    required this.priority,
    required this.priorityColor,
  }) : super(key: key);

  final TaskData data;
  final String priority;
  final Color priorityColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 80.0,
        width: 100.0,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: priorityColor.withOpacity(
            0.3,
          ),
        ),
        child: Text(
          priority,
          style: TextStyle(
            color: priorityColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      onTap: () {
        data.priority = priority;
      },
    );
  }
}
