import 'package:intl/intl.dart';
import 'package:mp2_assignment/models/memo.dart';

class MemoViewModel {
  final MemoModel memo;
  static final DateFormat _format = DateFormat('M/d/yyyy');

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

  String get createdAtLabel {
    return _format.format(createdAt);
  }

  String get tags {
    final eachTag = memo.tags.map((t) {
      if (t.isEmpty) return t;
      final capitalLetter = t[0].toUpperCase();
      final rest = t.length > 1
          ? t.substring(1)
          : ''; //Technically don't need to check this since we're using premade JSON but good practice
      return '$capitalLetter$rest';
    });
    return eachTag.join(' ');
  }
}
