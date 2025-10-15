import 'package:mp2_assignment/models/task.dart';

class TaskViewModel {
  final Task task;

  TaskViewModel({required this.task});

  String get title {
    return task.title;
  }

  String get status {
    return task.status;
  }

  String get priority {
    return task.priority;
  }

  String get assignedTo {
    return task.assignedTo;
  }

  DateTime get dueDate {
    return DateTime.parse(task.dueDate);
  }

  String get description {
    return task.description;
  }

  double get estimateHours {
    return task.estimateHours;
  }

  DateTime get createdAt {
    return DateTime.parse(task.createdAt);
  }

  DateTime? get completedAt {
    final value = task
        .completedAt; //I need to store as NOT a String since it could be null.
    //I was getting errors trying to parse task.completedAt without being in a non-declared variable
    if (value == null) return null;
    return DateTime.parse(value);
  }
}
