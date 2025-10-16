import 'package:mp2_assignment/models/event.dart';
import 'package:mp2_assignment/models/memo.dart';
import 'package:mp2_assignment/models/task.dart';
import 'package:mp2_assignment/repositories/email_repositories.dart';
import 'package:mp2_assignment/view_models/event_view_model.dart';
import 'package:mp2_assignment/view_models/memo_view_model.dart';
import 'package:mp2_assignment/view_models/task_view_model.dart';

class EmailsListViewModel {
  final EmailRepository repo;
  EmailsListViewModel(this.repo);

  Future<List<MemoViewModel>> fetchMemos() async {
    final map = await repo.fetchEmails();
    final list = map['memos'] as List<dynamic>? ?? const [];
    return list
        .map(
          (e) => MemoViewModel(memo: MemoModel.fromJson(e as Map<String, dynamic>)),
        )
        .toList();
  }

  Future<List<EventViewModel>> fetchEvents() async {
    final map = await repo.fetchEmails();
    final list = map['events'] as List<dynamic>? ?? const [];
    return list
        .map(
          (e) =>
              EventViewModel(event: EventModel.fromJson(e as Map<String, dynamic>)),
        )
        .toList();
  }

  Future<List<TaskViewModel>> fetchTasks() async {
    final map = await repo.fetchEmails();
    final list = map['tasks'] as List<dynamic>? ?? const [];
    return list
        .map(
          (e) => TaskViewModel(task: TaskModel.fromJson(e as Map<String, dynamic>)),
        )
        .toList();
  }
}
