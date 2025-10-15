import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class EmailRepository {
  final String assetPath;
  EmailRepository({this.assetPath = 'assets/mp2.json'});

  Future<Map<String, dynamic>> fetchEmails() async {
    final raw = await rootBundle.loadString(assetPath);
    final decoded = jsonDecode(raw);
    if (decoded is Map<String, dynamic>) return decoded;
    throw const FormatException('Top-level JSON is not an object');
  }
}
