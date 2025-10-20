import 'package:flutter/material.dart';
import 'package:mp2_assignment/view_models/event_view_model.dart';
import 'package:mp2_assignment/view_models/memo_view_model.dart';
import 'package:mp2_assignment/view_models/task_view_model.dart';

class MemoBox extends StatelessWidget {
  final MemoViewModel memo;

  const MemoBox({super.key, required this.memo});

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
              child: Icon(Icons.mail_outline, size: 56),
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
                      Expanded(
                        child: Text(
                          memo.author,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            height: 1.25,
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      Flexible(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.centerRight,
                          child: Text(
                            memo.createdAtLabel,
                            style: TextStyle(height: 1.25, color: Colors.grey),
                          ),
                        ),
                      ),
                    ],
                  ),

                  //Header
                  Text(
                    memo.tags,
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
                          memo.message,
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

class EventBox extends StatelessWidget {
  final EventViewModel event;

  const EventBox({super.key, required this.event});

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
              child: Icon(Icons.calendar_today, size: 56),
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
                      Expanded(
                        child: Text(
                          event.organizer,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            height: 1.25,
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      Flexible(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.centerRight,
                          child: Text(
                            event.createdAtLabel,
                            style: TextStyle(height: 1.25, color: Colors.grey),
                          ),
                        ),
                      ),
                    ],
                  ),

                  //Header
                  Text(
                    event.title,
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
                          event.description,
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

class TaskBox extends StatelessWidget {
  final TaskViewModel task;

  const TaskBox({super.key, required this.task});

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
              child: Icon(Icons.calendar_today, size: 56),
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
                      Expanded(
                        child: Text(
                          task.assignedTo,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            height: 1.25,
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      Flexible(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.centerRight,
                          child: Text(
                            task.createdAtLabel,
                            style: TextStyle(height: 1.25, color: Colors.grey),
                          ),
                        ),
                      ),
                    ],
                  ),

                  //Header
                  Text(
                    task.title,
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
                          task.description,
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
