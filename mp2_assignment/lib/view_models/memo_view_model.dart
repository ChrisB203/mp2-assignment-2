import 'package:mp2_assignment/models/memo.dart';

class MemoViewModel {
  final MemoModel memo;

  MemoViewModel({required this.memo});

  String get message {
    return memo.message;
  }

  String get author {
    return memo.author;
  }

  DateTime get createdAt {
    return DateTime.parse(memo.createdAt);
  }

  String get tags {
    return memo.tags.join(', ');
  }
}
