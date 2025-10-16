class AttendeeModel {
  final String name;
  final String email;
  final String response;

  AttendeeModel({required this.name, required this.email, required this.response});

  factory AttendeeModel.fromJson(Map<String, dynamic> json) {
    return AttendeeModel(
      name: json['name'] as String,
      email: json['email'] as String,
      response: json['response'] as String,
    );
  }
}

class EventModel {
  final String id;
  final String title;
  final String startTime;
  final String endTime;
  final String location;
  final String description;
  final String organizer;
  final List<AttendeeModel> attendees;
  final String createdAt;

  EventModel({
    required this.id,
    required this.title,
    required this.startTime,
    required this.endTime,
    required this.location,
    required this.description,
    required this.organizer,
    required this.attendees,
    required this.createdAt,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    final rawAttendees = json['attendees'] as List<dynamic>? ?? const [];
    return EventModel(
      id: json["id"],
      title: json["title"],
      startTime: json["start_time"],
      endTime: json["end_time"],
      location: json["location"],
      description: json["description"],
      organizer: json["organizer"],
      attendees: rawAttendees
          .map((e) => AttendeeModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: json["created_at"],
    );
  }
}
