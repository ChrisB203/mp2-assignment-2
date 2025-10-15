class Event {
  final String id;
  final String title;
  final String startTime;
  final String endTime;
  final String location;
  final String description;
  final String organizer;
  final String attendees;
  final String createdAt;

  Event({
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

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json["id"],
      title: json["title"],
      startTime: json["start_time"],
      endTime: json["end_time"],
      location: json["location"],
      description: json["description"],
      organizer: json["organizer"],
      attendees: json["attendees"],
      createdAt: json["created_at"],
    );
  }
}
