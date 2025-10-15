import 'package:flutter/material.dart';

class VerticalInboxHeader extends StatelessWidget {
  const VerticalInboxHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Inbox', style: TextStyle(fontSize: 30)),
        const SizedBox(height: 10),
        SearchBar(
          hintText: 'Search',
          shape: const WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
        ),
      ],
    );
  }
}
