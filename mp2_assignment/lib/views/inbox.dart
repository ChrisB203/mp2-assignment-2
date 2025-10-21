import 'package:flutter/material.dart';
import 'package:mp2_assignment/models/email_bundle.dart';
import 'package:mp2_assignment/repositories/email_repositories.dart';
import 'package:mp2_assignment/view_models/emails_list_view_model.dart';
import 'package:mp2_assignment/view_models/memo_view_model.dart';
import 'package:mp2_assignment/view_models/event_view_model.dart';
import 'package:mp2_assignment/view_models/task_view_model.dart';
import 'package:mp2_assignment/views/email_screens.dart';
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

  bool _isItemSelected = false;
  final GlobalKey<NavigatorState> _detailNavKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
    vm = EmailsListViewModel(EmailRepository());
    futureBundle = vm.load();
  }

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    final isLandscape = orientation == Orientation.landscape;

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

            if (isLandscape && _isItemSelected) {
              return Row(
                children: [
                  // LEFT PANE
                  Expanded(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
                          child: _HorizontalInboxHeader(searchBarFlag: true),
                        ),
                        const SizedBox(height: 30),
                        const Divider(height: 1),
                        Expanded(child: _buildList(items, orientation)),
                      ],
                    ),
                  ),

                  // MAIN SPLIT DIVIDER
                  const VerticalDivider(
                    thickness: 1,
                    color: Colors.grey,
                    width: 1,
                  ),

                  // RIGHT PANE — NESTED NAVIGATOR (initially shows placeholder)
                  Expanded(
                    child: Navigator(
                      key: _detailNavKey,
                      onGenerateRoute: (settings) {
                        return MaterialPageRoute(
                          builder: (_) => Container(
                            color: Colors.grey[200],
                            alignment: Alignment.center,
                            child: const Text(
                              'Select an item to view details',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            }

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      isLandscape
                          ? _HorizontalInboxHeader(
                              searchBarFlag: _isItemSelected,
                            )
                          : const _VerticalInboxHeader(),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                const Divider(height: 1),
                Expanded(child: _buildList(items, orientation)),
              ],
            );
          },
        ),
      ),
    );
  }

  void _openDetail(Object vm, Orientation orientation) {
    if (orientation == Orientation.portrait) {
      // normal full-screen nav
      if (vm is MemoViewModel) {
        Navigator.of(
          context,
        ).push(MaterialPageRoute(builder: (_) => MemoScreen(memo: vm)));
      } else if (vm is EventViewModel) {
        Navigator.of(
          context,
        ).push(MaterialPageRoute(builder: (_) => EventScreen(event: vm)));
      } else if (vm is TaskViewModel) {
        Navigator.of(
          context,
        ).push(MaterialPageRoute(builder: (_) => TaskScreen(task: vm)));
      }
      return;
    }

    setState(() {
      _isItemSelected = true;
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final nav = _detailNavKey.currentState;
      if (nav == null) return;

      if (vm is MemoViewModel) {
        nav.pushReplacement(
          MaterialPageRoute(builder: (_) => MemoScreen(memo: vm)),
        );
      } else if (vm is EventViewModel) {
        nav.pushReplacement(
          MaterialPageRoute(builder: (_) => EventScreen(event: vm)),
        );
      } else if (vm is TaskViewModel) {
        nav.pushReplacement(
          MaterialPageRoute(builder: (_) => TaskScreen(task: vm)),
        );
      }
    });
  }

  Widget _buildList(List<InboxItem> items, Orientation orientation) {
    return ListView.separated(
      itemCount: items.length,
      separatorBuilder: (_, __) => const Divider(height: 1),
      itemBuilder: (_, i) {
        final item = items[i];
        switch (item.type) {
          case InboxItemType.memo:
            final memoVM = item.data as MemoViewModel;
            return GestureDetector(
              onTap: () => _openDetail(memoVM, orientation),
              child: EmailBox(
                icon: Icons.mail_outline,
                name: memoVM.author,
                header: memoVM.tags,
                description: memoVM.message,
                date: memoVM.createdAtLabel,
              ),
            );

          case InboxItemType.event:
            final eventVM = item.data as EventViewModel;
            return GestureDetector(
              onTap: () => _openDetail(eventVM, orientation),
              child: EmailBox(
                icon: Icons.calendar_today,
                name: eventVM.organizer,
                header: eventVM.title,
                description: eventVM.description,
                date: eventVM.createdAtLabel,
              ),
            );

          case InboxItemType.task:
            final taskVM = item.data as TaskViewModel;
            return GestureDetector(
              onTap: () => _openDetail(taskVM, orientation),
              child: EmailBox(
                icon: Icons.check_box_outlined,
                name: taskVM.assignedTo,
                header: taskVM.title,
                description: taskVM.description,
                date: taskVM.createdAtLabel,
              ),
            );
        }
      },
    );
  }
}

// Headers

class _HorizontalInboxHeader extends StatelessWidget {
  final bool searchBarFlag;

  const _HorizontalInboxHeader({required this.searchBarFlag});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          const Expanded(child: Text('Inbox', style: TextStyle(fontSize: 30))),
          const SizedBox(width: 20),
          Expanded(
            child: searchBarFlag
                ? const SizedBox.shrink()
                : const SearchBar(
                    hintText: 'Search',
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                  ),
          ),
        ],
      ),
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
