import 'package:mp2_assignment/models/email_bundle.dart';
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

  Future<EmailBundle> load() async {
    final map = await repo.fetchEmails();

    final memosJson = map['memos'] as List<dynamic>? ?? const [];
    final eventsJson = map['events'] as List<dynamic>? ?? const [];
    final tasksJson = map['tasks'] as List<dynamic>? ?? const [];

    final memos = memosJson
        .map((e) => MemoModel.fromJson(e as Map<String, dynamic>))
        .toList();

    final events = eventsJson
        .map((e) => EventModel.fromJson(e as Map<String, dynamic>))
        .toList();

    final tasks = tasksJson
        .map((e) => TaskModel.fromJson(e as Map<String, dynamic>))
        .toList();

    return EmailBundle(memos: memos, events: events, tasks: tasks);
  }

  Future<List<MemoViewModel>> memos() async {
    final bundle = await load();
    return bundle.memos.map((m) => MemoViewModel(memo: m)).toList();
  }

  Future<List<EventViewModel>> events() async {
    final bundle = await load();
    return bundle.events.map((e) => EventViewModel(event: e)).toList();
  }

  Future<List<TaskViewModel>> tasks() async {
    final bundle = await load();
    return bundle.tasks.map((t) => TaskViewModel(task: t)).toList();
  }
}
