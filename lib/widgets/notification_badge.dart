
import 'package:flutter/material.dart';

class NotificationBadge extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: Color(0xFF1d425d),
        shape: BoxShape.circle,
      ),
    );
  }
}