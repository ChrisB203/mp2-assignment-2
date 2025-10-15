import 'package:mp2_assignment/models/event.dart';
import 'package:mp2_assignment/models/memo.dart';
import 'package:mp2_assignment/models/task.dart';
import 'package:mp2_assignment/repositories/email_repositories.dart';

class EmailsListViewModel {
  final EmailRepository repo;
  EmailsListViewModel(this.repo);

  Future<List<Memo>> fetchMemos() async {
    final map = await repo.fetchEmails();
    final list = map['memos'] as List<dynamic>? ?? const [];
    return list.map((e) => Memo.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<List<Event>> fetchEvents() async {
    final map = await repo.fetchEmails();
    final list = map['events'] as List<dynamic>? ?? const [];
    return list.map((e) => Event.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<List<Task>> fetchTasks() async {
    final map = await repo.fetchEmails();
    final list = map['tasks'] as List<dynamic>? ?? const [];
    return list.map((e) => Task.fromJson(e as Map<String, dynamic>)).toList();
  }
}
