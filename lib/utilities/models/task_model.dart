class TaskData {
  String title;
  String description;
  String date;
  String priority;
  String? assignedTo;
  String? assignedBy;

  TaskData(
      {required this.title,
      required this.description,
      required this.date,
      required this.priority,
      this.assignedTo,
      this.assignedBy});
}
