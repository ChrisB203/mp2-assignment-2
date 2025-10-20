// models/email_bundle.dart
import 'package:mp2_assignment/models/memo.dart';
import 'package:mp2_assignment/models/event.dart';
import 'package:mp2_assignment/models/task.dart';

class EmailBundle {
  final List<MemoModel> memos;
  final List<EventModel> events;
  final List<TaskModel> tasks;

  EmailBundle({
    required this.memos,
    required this.events,
    required this.tasks,
  });
}
