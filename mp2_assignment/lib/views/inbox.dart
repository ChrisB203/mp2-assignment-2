import 'package:flutter/material.dart';
import 'package:mp2_assignment/widgets/email_box.dart';
import 'package:mp2_assignment/widgets/horizontal_inbox_header.dart';
import 'package:mp2_assignment/widgets/vertical_inbox_header.dart';

class Inbox extends StatefulWidget {
  const Inbox({super.key});

  @override
  State<Inbox> createState() => _InboxState();
}

class _InboxState extends State<Inbox> {
  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              //Header and Search Bar Section
              Padding(
                padding: EdgeInsetsGeometry.fromLTRB(20, 20, 20, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    orientation == Orientation.portrait
                        ? VerticalInboxHeader()
                        : HorizontalInboxHeader(),
                  ],
                ),
              ),

              SizedBox(height: 30),

              // Listing json elements here
              //Single Demo for now
              EmailBox(),
            ],
          ),
        ),
      ),
    );
  }
}
