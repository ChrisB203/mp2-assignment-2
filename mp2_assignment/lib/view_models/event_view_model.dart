import 'package:mp2_assignment/models/event.dart';

class EventViewModel {
  final Event event;

  EventViewModel({required this.event});

  DateTime get startTime {
    return DateTime.parse(event.startTime);
  }

  DateTime get endTime {
    return DateTime.parse(event.endTime);
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

  List<Attendee> get attendees {
    return event.attendees;
  }

  DateTime get createdAt {
    return DateTime.parse(event.createdAt);
  }
}
