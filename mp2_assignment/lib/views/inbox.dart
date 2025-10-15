import 'package:flutter/material.dart';
import 'package:mp2_assignment/widgets/email_box.dart';

class Inbox extends StatefulWidget {
  const Inbox({super.key});

  @override
  State<Inbox> createState() => _InboxState();
}

class _InboxState extends State<Inbox> {
  @override
  Widget build(BuildContext context) {
    double wPad = MediaQuery.of(context).size.width * .035;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [

            //Header / Search Bar Section
            Padding(
              padding: EdgeInsetsGeometry.fromLTRB(wPad, 0, wPad, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Inbox', style: TextStyle(fontSize: 30)),
                  SizedBox(height: 10),
                  SearchBar(
                    hintText: 'Search',
                    shape: const WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 30),

            // Listing json elements here

            EmailBox()
          ],
        ),
      ),
    );
  }
}
