import 'package:flutter/material.dart';
import 'package:wuchers_garage/utilities/models/task_model.dart';

class TaskProvider with ChangeNotifier {
  final TaskData _taskData = TaskData(
    title: '',
    priority: '',
    description: '',
    date: '',
    assignedTo: '',
    assignedBy: '',
  );
  final List<TaskData> _taskListData = [];
  final List<TaskData> _assignedTasks = [];

  TaskData get getTaskData => _taskData;

  List<TaskData> get getTaskListData => [..._taskListData];

  List<TaskData> get getAssignedTasks => [..._assignedTasks];

  void setTaskData(TaskData taskData) {
    _taskData.title = taskData.title;
    _taskData.date = taskData.date;
    _taskData.description = taskData.description;
    _taskData.priority = taskData.priority;
    _taskData.assignedTo = taskData.assignedTo;
    _taskData.assignedBy = taskData.assignedBy;
  }

  void addToTaskListData(TaskData taskData) {
    _taskListData.add(
      taskData,
    );
    notifyListeners();
  }

  void addToAssignedTasks(TaskData taskData) {
    _assignedTasks.add(
      taskData,
    );
    notifyListeners();
  }
}
