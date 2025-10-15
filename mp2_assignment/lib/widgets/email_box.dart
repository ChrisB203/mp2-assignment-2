import 'package:flutter/material.dart';

class EmailBox extends StatefulWidget {
  const EmailBox({super.key});

  @override
  State<EmailBox> createState() => _EmailBoxState();
}

class _EmailBoxState extends State<EmailBox> {
  @override
  Widget build(BuildContext context) {
    double wPad = MediaQuery.of(context).size.width * .035;
    return Container(
      height: 100,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey, width: 2)),
        color: Colors.grey[200],
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(wPad, 10, wPad, 10),
        child: Row(
          children: [
            //Icon Box
            Container(
              width: 75,
              height: 75,
              decoration: BoxDecoration(
                color: Colors.grey[500],
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Icon(
                Icons.mail_outline,
                size: 56,
              ), //Icons.mail_outline, Icons.calendar_today, Icons.check_box_outlined
            ),

            //End Icon Box
            SizedBox(width: 20),
            //Column Subset
            Expanded(
              child: Column(
                children: [
                  Row(
                    children: [
                      Text('name'),
                      Spacer(),
                      Text('time'),
                    ],
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
