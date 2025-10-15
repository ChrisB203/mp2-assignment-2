import 'package:flutter/material.dart';

class EmailBox extends StatefulWidget {
  const EmailBox({super.key});

  @override
  State<EmailBox> createState() => _EmailBoxState();
}

class _EmailBoxState extends State<EmailBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey, width: 2)),
        color: const Color.fromARGB(255, 231, 231, 231),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
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

            //Quick Spacer
            SizedBox(width: 20),

            //Non Icon Section
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Name Row
                  Row(
                    children: [
                      Text(
                        'Name',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          height: 1.25,
                        ),
                      ),
                      Spacer(),
                      Text(
                        'time',
                        style: TextStyle(height: 1.25, color: Colors.grey),
                      ),
                    ],
                  ),

                  //Header
                  Text('Header', style: TextStyle(height: 1)),

                  //Body Row
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          'This kas  l aslkgjaslkgjsaflnaslk sfjlkasf asfkjfalfjlkaasfkjfalfjlka ',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                            height: 1.25,
                          ),
                        ),
                        //arrow_forward_ios
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 20,
                        color: Colors.grey[500],
                        weight: 5,
                      ),
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
