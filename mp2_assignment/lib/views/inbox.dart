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
  final Object data;
  const InboxItem({
    required this.type,
    required this.sortKey,
    required this.data,
  });
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
              return Center(
                child: Text('Error: ${snap.error}'),
              ); //I dont care to error handle that much since not required / static json file
            }

            final bundle = snap.data!;
            final memosVM = bundle.memos
                .map((m) => MemoViewModel(memo: m))
                .toList();
            final eventsVM = bundle.events
                .map((e) => EventViewModel(event: e))
                .toList();
            final tasksVM = bundle.tasks
                .map((t) => TaskViewModel(task: t))
                .toList();

            final items = <InboxItem>[
              for (final m in memosVM)
                InboxItem(
                  type: InboxItemType.memo,
                  sortKey: m.createdAt,
                  data: m,
                ),
              for (final e in eventsVM)
                InboxItem(
                  type: InboxItemType.event,
                  sortKey: e.createdAt,
                  data: e,
                ),
              for (final t in tasksVM)
                InboxItem(
                  type: InboxItemType.task,
                  sortKey: t.createdAt,
                  data: t,
                ),
            ]..sort((a, b) => b.sortKey.compareTo(a.sortKey));

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

                  Column(
                    children: [
                      const Divider(height: 1),
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
                              return EventBox(
                                event: item.data as EventViewModel,
                              );
                            case InboxItemType.task:
                              return TaskBox(task: item.data as TaskViewModel);
                          }
                        },
                      ),
                    ],
                  ),
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
