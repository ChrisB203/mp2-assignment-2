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
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      appBar: isPortrait ? _inboxAppBar(context) : null,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 0),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
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
              const SizedBox(height: 10),
            ],
          ),
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
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      appBar: isPortrait ? _inboxAppBar(context) : null,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 0),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _EmailHeader(
                      name: event.organizer,
                      date: event.createdAtLabel,
                      header: event.title,
                      description: event.description,
                      icon: Icons.calendar_today,
                    ),
                    const SizedBox(height: 30),
                    EventPrompt(
                      title: event.title,
                      date: event.startDateFormatted,
                      time: event.startTimeFormatted,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
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
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      appBar: isPortrait ? _inboxAppBar(context) : null,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 0),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
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
                    const SizedBox(height: 30),
                    TaskPrompt(title: task.title),
                  ],
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
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
            EmailIcon(icon: icon),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            height: 1.25,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              date,
                              style: const TextStyle(
                                height: 1.25,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Row(
                    children: [
                      Text('To:', style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(' You'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        const Divider(),
        const SizedBox(height: 10),
        Text(
          header,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            height: 1,
          ),
        ),
        const SizedBox(height: 15),
        Text(description, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }
}

class EventPrompt extends StatelessWidget {
  final String title;
  final String date;
  final String time;
  const EventPrompt({
    super.key,
    required this.title,
    required this.date,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: Colors.grey[300],
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            Divider(color: Colors.grey[600], thickness: 1, height: 2),
            const SizedBox(height: 5),
            Row(children: [const Text('Date: ', style: TextStyle(fontWeight: FontWeight.bold)), Text(date)]),
            const SizedBox(height: 5),
            Row(children: [const Text('Time: ', style: TextStyle(fontWeight: FontWeight.bold)), Text(time)]),
            const SizedBox(height: 5),
            const Row(children: [Text('Repeats: ', style: TextStyle(fontWeight: FontWeight.bold)), Text('Weekly')]),
          ],
        ),
      ),
    );
  }
}

class TaskPrompt extends StatelessWidget {
  final String title;
  const TaskPrompt({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: Colors.grey[300],
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            ),
            Divider(color: Colors.grey[600], thickness: 1, height: 2),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                _CardButton(label: 'Mark as Complete'),
                _CardButton(label: 'Add to To-Do List'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _CardButton extends StatelessWidget {
  final String label;
  const _CardButton({required this.label});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 30,
        width: 150,
        decoration: BoxDecoration(
          color: Colors.grey[500],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(child: Text(label, style: const TextStyle(fontSize: 10))),
      ),
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
