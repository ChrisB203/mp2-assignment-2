class Task {
  final String id;
  final String title;
  final String status;
  final String priority;
  final String assignedTo;
  final String dueDate;
  final String description;
  final double estimateHours;
  final String createdAt;
  final List<String>? blockedBy;
  final String? completedAt;

  Task({
    required this.id,
    required this.title,
    required this.status,
    required this.priority,
    required this.assignedTo,
    required this.dueDate,
    required this.description,
    required this.estimateHours,
    required this.createdAt,
    this.blockedBy,
    this.completedAt,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    final blocked = json['blocked_by'] as List<dynamic>?;
    return Task(
      id: json['id'] as String,
      title: json['title'] as String,
      status: json['status'] as String,
      priority: json['priority'] as String,
      assignedTo: json['assigned_to'] as String,
      dueDate: json['due_date'] as String,
      description: json['description'] as String,
      estimateHours: (json['estimate_hours'] as num).toDouble(),
      createdAt: json['created_at'] as String,
      blockedBy: blocked?.map((e) => e as String).toList(),
      completedAt: json['completed_at'] as String?,
    );
  }
}
