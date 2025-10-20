import 'package:flutter/material.dart';
import 'package:mp2_assignment/widgets/email_boxes.dart';

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

              

              // MemoBox(),
            ],
          ),
        ),
      ),
    );
  }
}

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

