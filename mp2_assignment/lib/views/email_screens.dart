import 'package:flutter/material.dart';
import 'package:mp2_assignment/view_models/memo_view_model.dart';
import 'package:mp2_assignment/widgets/email_icon.dart';

class MemoScreen extends StatelessWidget {
  final MemoViewModel memo;
  const MemoScreen({super.key, required this.memo});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        titleSpacing: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Text(
            'Inbox',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [_EmailHeader()],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmailHeader extends StatelessWidget {
  const _EmailHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            //Icon Box
            EmailIcon(icon: Icons.mail_outline),

            //Quick Spacer
            SizedBox(width: 20),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Name Row
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Amanda B',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            height: 1.25,
                            fontSize: 20,
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
                              '3:15',
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
                  Row(
                    children: [
                      Text(
                        'To:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(' You'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),

        SizedBox(height: 10),
        Divider(),
        SizedBox(height: 10),
        Text(
          'Dinner Plans',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 15),
        Text(
          'Did you have a specific restaurant in mind for dinner?',
          style: TextStyle(fontSize: 12, color: Colors.grey),
        ),
      ],
    );
  }
}
