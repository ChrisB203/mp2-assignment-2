import 'package:flutter/material.dart';

class HorizontalInboxHeader extends StatelessWidget {
  const HorizontalInboxHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      //If horizontal
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: Text('Inbox', style: TextStyle(fontSize: 30))),
        const SizedBox(width: 20),
        Expanded(
          flex: 1,
          child: SearchBar(
            hintText: 'Search',
            shape: const WidgetStatePropertyAll(
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
