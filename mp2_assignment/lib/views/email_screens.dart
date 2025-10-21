import 'package:flutter/material.dart';
import 'package:mp2_assignment/view_models/event_view_model.dart';
import 'package:mp2_assignment/view_models/memo_view_model.dart';
import 'package:mp2_assignment/view_models/task_view_model.dart';
import 'package:mp2_assignment/widgets/email_icon.dart';

class MemoScreen extends StatelessWidget {
  final MemoViewModel memo;
  const MemoScreen({super.key, required this.memo});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _inboxAppBar(context),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _EmailHeader(
                    name: memo.author,
                    date: memo.createdAtLabel,
                    header: memo.tags,
                    description: memo.message,
                    icon: Icons.mail_outline,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EventScreen extends StatelessWidget {
  final EventViewModel event;
  const EventScreen({super.key, required this.event});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _inboxAppBar(context),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _EmailHeader(
                    name: event.organizer,
                    date: event.createdAtLabel,
                    header: event.organizer,
                    description: event.description,
                    icon: Icons.calendar_today,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TaskScreen extends StatelessWidget {
  final TaskViewModel task;
  const TaskScreen({super.key, required this.task});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _inboxAppBar(context),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _EmailHeader(
                    name: task.assignedTo,
                    date: task.createdAtLabel,
                    header: task.title,
                    description: task.description,
                    icon: Icons.check_box_outlined,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmailHeader extends StatelessWidget {
  final String name;
  final String date;
  final String header;
  final String description;
  final IconData icon;

  const _EmailHeader({
    required this.name,
    required this.date,
    required this.header,
    required this.description,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            //Icon Box
            EmailIcon(icon: icon),
            //Quick Spacer
            SizedBox(width: 20),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Name Row
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            height: 1.25,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              date,
                              style: TextStyle(
                                height: 1.25,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'To:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(' You'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),

        SizedBox(height: 10),
        Divider(),
        SizedBox(height: 10),
        Text(
          header,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, height: 1),
        ),
        SizedBox(height: 15),
        Text(description, style: TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }
}

AppBar _inboxAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: Colors.grey[300],
    titleSpacing: 0,
    leading: IconButton(
      icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
      onPressed: () => Navigator.pop(context),
    ),
    title: GestureDetector(
      onTap: () => Navigator.pop(context),
      child: const Text('Inbox', style: TextStyle(fontWeight: FontWeight.w600)),
    ),
  );
}
