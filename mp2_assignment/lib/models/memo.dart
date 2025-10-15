class Memo {
  final String id;
  final String message;
  final String author;
  final String createdAt;
  final String tags;

  Memo({
    required this.id,
    required this.message,
    required this.author,
    required this.createdAt,
    required this.tags,
  });

  factory Memo.fromJson(Map<String, dynamic> json) {
    return Memo(
      id: json["id"],
      message: json["message"],
      author: json["author"],
      createdAt: json["created_at"],
      tags: json["tags"],
    );
  }
}
