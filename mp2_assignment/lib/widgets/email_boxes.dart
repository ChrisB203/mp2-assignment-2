import 'package:flutter/material.dart';
import 'package:mp2_assignment/widgets/email_icon.dart';

class EmailBox extends StatelessWidget {
  final IconData icon;
  final String date;
  final String name;
  final String header;
  final String description;

  const EmailBox({
    super.key,
    required this.icon,
    required this.name,
    required this.header,
    required this.description,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 231, 231, 231),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: Row(
          children: [
            //Icon Box
            EmailIcon(icon: icon),

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
                      Expanded(
                        child: Text(
                          name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            height: 1.25,
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              date,
                              style: TextStyle(
                                height: 1.25,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  //Header
                  Text(
                    header,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(height: 1),
                  ),

                  //Body Row
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                            height: 1.25,
                          ),
                        ),
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
