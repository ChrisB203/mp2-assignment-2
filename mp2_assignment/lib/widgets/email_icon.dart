import 'package:flutter/material.dart';

class EmailIcon extends StatelessWidget {
  final IconData icon;
  const EmailIcon({super.key, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 75,
      height: 75,
      decoration: BoxDecoration(
        color: Colors.grey[500],
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Icon(icon, size: 56),
    );
  }
}
