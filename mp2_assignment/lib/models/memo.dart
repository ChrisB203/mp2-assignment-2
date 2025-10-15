class Memo {
  final String id;
  final String message;
  final String author;
  final String createdAt;
  final List<String> tags;

  Memo({
    required this.id,
    required this.message,
    required this.author,
    required this.createdAt,
    required this.tags,
  });

  factory Memo.fromJson(Map<String, dynamic> json) {
    final rawTags = json['tags'] as List<dynamic>? ?? const [];
    return Memo(
      id: json['id'] as String,
      message: json['message'] as String,
      author: json['author'] as String,
      createdAt: json['created_at'] as String,
      tags: rawTags.map((e) => e as String).toList(),
    );
  }
}
