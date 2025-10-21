import 'package:intl/intl.dart';
import 'package:mp2_assignment/models/event.dart';

class EventViewModel {
  final EventModel event;
  static final DateFormat _format = DateFormat('MMM d, yyyy h:mm a');

  EventViewModel({required this.event});

  DateTime get startTime {
    return DateTime.parse(event.startTime);
  }

  String get startDateFormatted {
    final date = DateTime.parse(event.startTime);
    return DateFormat('EEEE, MMMM d , yyyy').format(date);
  }

  String get startTimeFormatted {
    final date = DateTime.parse(event.startTime);
    return DateFormat('h:mm a').format(date);
  }

  DateTime get endTime {
    return DateTime.parse(event.endTime);
  }

  String get title {
    return event.title;
  }

  String get location {
    return event.location;
  }

  String get description {
    return event.description;
  }

  String get organizer {
    return event.organizer;
  }

  List<AttendeeModel> get attendees {
    return event.attendees;
  }

  String get createdAtLabel {
    return _format.format(createdAt);
  }

  DateTime get createdAt {
    return DateTime.parse(event.createdAt);
  }
}
