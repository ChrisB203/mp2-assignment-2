import 'package:flutter/material.dart';
import 'package:mp2_assignment/views/inbox.dart';
import 'package:mp2_assignment/widgets/email_screens.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Inbox(),
    );
  }
}
