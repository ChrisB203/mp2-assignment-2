import 'package:flutter/material.dart';

// Data bundle + repo
import 'package:mp2_assignment/models/email_bundle.dart';
import 'package:mp2_assignment/repositories/email_repositories.dart';

// View models
import 'package:mp2_assignment/view_models/emails_list_view_model.dart';
import 'package:mp2_assignment/view_models/memo_view_model.dart';
import 'package:mp2_assignment/view_models/event_view_model.dart';
import 'package:mp2_assignment/view_models/task_view_model.dart';
import 'package:mp2_assignment/widgets/email_boxes.dart';

enum InboxItemType { memo, event, task }

class InboxItem {
  final InboxItemType type;
  final DateTime sortKey;
  final Object data; // MemoViewModel | EventViewModel | TaskViewModel
  const InboxItem({required this.type, required this.sortKey, required this.data});
}

class Inbox extends StatefulWidget {
  const Inbox({super.key});

  @override
  State<Inbox> createState() => _InboxState();
}

class _InboxState extends State<Inbox> {
  late final EmailsListViewModel vm;
  late final Future<EmailBundle> futureBundle;

  @override
  void initState() {
    super.initState();
    vm = EmailsListViewModel(EmailRepository());
    futureBundle = vm.load();
  }

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;

    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<EmailBundle>(
          future: futureBundle,
          builder: (context, snap) {
            if (snap.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snap.hasError) {
              return Center(child: Text('Error: ${snap.error}'));
            }

            final bundle = snap.data!;
            final memosVM = bundle.memos.map((m) => MemoViewModel(memo: m)).toList();
            final eventsVM = bundle.events.map((e) => EventViewModel(event: e)).toList();
            final tasksVM = bundle.tasks.map((t) => TaskViewModel(task: t)).toList();

            final items = <InboxItem>[
              for (final m in memosVM)
                InboxItem(type: InboxItemType.memo, sortKey: m.createdAt, data: m),
              for (final e in eventsVM)
                InboxItem(type: InboxItemType.event, sortKey: e.startTime, data: e),
              for (final t in tasksVM)
                InboxItem(
                  type: InboxItemType.task,
                  sortKey: t.completedAt ?? DateTime.fromMillisecondsSinceEpoch(0),
                  data: t,
                ),
            ]..sort((a, b) => b.sortKey.compareTo(a.sortKey)); // newest first

            return SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        orientation == Orientation.portrait
                            ? const _VerticalInboxHeader()
                            : const _HorizontalInboxHeader(),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Unified list
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: items.length,
                    separatorBuilder: (_, __) => const Divider(height: 1),
                    itemBuilder: (_, i) {
                      final item = items[i];
                      switch (item.type) {
                        case InboxItemType.memo:
                          return MemoBox(memo: item.data as MemoViewModel);
                        case InboxItemType.event:
                          return EventBox(event: item.data as EventViewModel);
                        case InboxItemType.task:
                          return TaskBox(task: item.data as TaskViewModel);
                      }
                    },
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

// Headers

class _HorizontalInboxHeader extends StatelessWidget {
  const _HorizontalInboxHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Expanded(child: Text('Inbox', style: TextStyle(fontSize: 30))),
        const SizedBox(width: 20),
        const Expanded(
          flex: 1,
          child: SearchBar(
            hintText: 'Search',
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _VerticalInboxHeader extends StatelessWidget {
  const _VerticalInboxHeader();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Inbox', style: TextStyle(fontSize: 30)),
        SizedBox(height: 10),
        SearchBar(
          hintText: 'Search',
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
        ),
      ],
    );
  }
}

// Helpers

String _timeAgo(DateTime dt) {
  final now = DateTime.now();
  final diff = now.difference(dt);
  if (diff.inSeconds < 60) return 'just now';
  if (diff.inMinutes < 60) return '${diff.inMinutes}m';
  if (diff.inHours < 24) return '${diff.inHours}h';
  if (diff.inDays < 7) return '${diff.inDays}d';
  final y = dt.year.toString().padLeft(4, '0');
  final m = dt.month.toString().padLeft(2, '0');
  final d = dt.day.toString().padLeft(2, '0');
  return '$y-$m-$d';
}

// Boxes (inline, not reused elsewhere)

// class _MemoBox extends StatelessWidget {
//   final MemoViewModel memo;
//   const _MemoBox({super.key, required this.memo});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 100,
//       width: double.infinity,
//       decoration: BoxDecoration(
//         border: const Border(top: BorderSide(color: Colors.grey, width: 2)),
//         color: const Color.fromARGB(255, 231, 231, 231),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
//         child: Row(
//           children: [
//             Container(
//               width: 75,
//               height: 75,
//               decoration: BoxDecoration(
//                 color: Colors.grey[500],
//                 borderRadius: const BorderRadius.all(Radius.circular(20)),
//               ),
//               child: const Icon(Icons.mail_outline, size: 56),
//             ),
//             const SizedBox(width: 20),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     children: [
//                       Expanded(
//                         child: Text(
//                           memo.author,
//                           maxLines: 1,
//                           overflow: TextOverflow.ellipsis,
//                           style: const TextStyle(
//                             fontWeight: FontWeight.bold,
//                             height: 1.25,
//                           ),
//                         ),
//                       ),
//                       const SizedBox(width: 8),
//                       Text(
//                         _timeAgo(memo.createdAt.toLocal()),
//                         style: const TextStyle(height: 1.25, color: Colors.grey),
//                       ),
//                     ],
//                   ),
//                   if (memo.tags.isNotEmpty)
//                     Text(
//                       memo.tags,
//                       maxLines: 1,
//                       overflow: TextOverflow.ellipsis,
//                       style: const TextStyle(height: 1, fontSize: 12),
//                     ),
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Expanded(
//                         child: Text(
//                           memo.message,
//                           maxLines: 2,
//                           overflow: TextOverflow.ellipsis,
//                           style: const TextStyle(
//                             fontSize: 12,
//                             color: Colors.grey,
//                             height: 1.25,
//                           ),
//                         ),
//                       ),
//                       Icon(Icons.arrow_forward_ios, size: 20, color: Colors.grey[500], weight: 5),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class _EventBox extends StatelessWidget {
//   final EventViewModel event;
//   const _EventBox({super.key, required this.event});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 100,
//       width: double.infinity,
//       decoration: BoxDecoration(
//         border: const Border(top: BorderSide(color: Colors.grey, width: 2)),
//         color: const Color.fromARGB(255, 231, 231, 231),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
//         child: Row(
//           children: [
//             Container(
//               width: 75,
//               height: 75,
//               decoration: BoxDecoration(
//                 color: Colors.grey[500],
//                 borderRadius: const BorderRadius.all(Radius.circular(20)),
//               ),
//               child: const Icon(Icons.calendar_today, size: 56),
//             ),
//             const SizedBox(width: 20),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     children: [
//                       Expanded(
//                         child: Text(
//                           event.organizer,
//                           maxLines: 1,
//                           overflow: TextOverflow.ellipsis,
//                           style: const TextStyle(
//                             fontWeight: FontWeight.bold,
//                             height: 1.25,
//                           ),
//                         ),
//                       ),
//                       const SizedBox(width: 8),
//                       Text(
//                         _timeAgo(event.startTime.toLocal()),
//                         style: const TextStyle(height: 1.25, color: Colors.grey),
//                       ),
//                     ],
//                   ),
//                   Text(
//                     event.title,
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                     style: const TextStyle(height: 1),
//                   ),
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Expanded(
//                         child: Text(
//                           event.description,
//                           maxLines: 2,
//                           overflow: TextOverflow.ellipsis,
//                           style: const TextStyle(
//                             fontSize: 12,
//                             color: Colors.grey,
//                             height: 1.25,
//                           ),
//                         ),
//                       ),
//                       Icon(Icons.arrow_forward_ios, size: 20, color: Colors.grey[500], weight: 5),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class _TaskBox extends StatelessWidget {
//   final TaskViewModel task;
//   const _TaskBox({super.key, required this.task});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 100,
//       width: double.infinity,
//       decoration: BoxDecoration(
//         border: const Border(top: BorderSide(color: Colors.grey, width: 2)),
//         color: const Color.fromARGB(255, 231, 231, 231),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
//         child: Row(
//           children: [
//             Container(
//               width: 75,
//               height: 75,
//               decoration: BoxDecoration(
//                 color: Colors.grey[500],
//                 borderRadius: const BorderRadius.all(Radius.circular(20)),
//               ),
//               child: const Icon(Icons.check_box_outlined, size: 56),
//             ),
//             const SizedBox(width: 20),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     children: [
//                       Expanded(
//                         child: Text(
//                           task.priority,
//                           maxLines: 1,
//                           overflow: TextOverflow.ellipsis,
//                           style: const TextStyle(
//                             fontWeight: FontWeight.bold,
//                             height: 1.25,
//                           ),
//                         ),
//                       ),
//                       const SizedBox(width: 8),
//                       Text(
//                         task.completedAt != null
//                             ? _timeAgo(task.completedAt!.toLocal())
//                             : '',
//                         style: const TextStyle(height: 1.25, color: Colors.grey),
//                       ),
//                     ],
//                   ),
//                   Text(
//                     task.title,
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                     style: const TextStyle(height: 1),
//                   ),
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Expanded(
//                         child: Text(
//                           task.description,
//                           maxLines: 2,
//                           overflow: TextOverflow.ellipsis,
//                           style: const TextStyle(
//                             fontSize: 12,
//                             color: Colors.grey,
//                             height: 1.25,
//                           ),
//                         ),
//                       ),
//                       Icon(Icons.arrow_forward_ios, size: 20, color: Colors.grey[500], weight: 5),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
