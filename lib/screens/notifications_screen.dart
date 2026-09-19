import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),

      body: ListView(
        children: [

          _notification(
            Icons.work_outline,
            'New Job Request',
            'You received a new electrician job.',
            '5 min ago',
          ),

          _notification(
            Icons.payment,
            'Payment Received',
            'Payment for your completed job was recorded.',
            '1 hour ago',
          ),

          _notification(
            Icons.shield_outlined,
            'Insurance Verified',
            'Your insurance verification status was updated.',
            'Yesterday',
          ),

          _notification(
            Icons.verified,
            'e-Shram Verification',
            'Your e-Shram verification has been updated.',
            'Yesterday',
          ),

          _notification(
            Icons.report_problem_outlined,
            'Complaint Update',
            'Your complaint status has been updated.',
            '2 days ago',
          ),
        ],
      ),
    );
  }

  Widget _notification(
      IconData icon,
      String title,
      String message,
      String time,
      ) {
    return ListTile(
      leading: CircleAvatar(
        child: Icon(icon),
      ),

      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),

      subtitle: Text(message),

      trailing: Text(
        time,
        style: const TextStyle(
          color: Colors.grey,
          fontSize: 11,
        ),
      ),
    );
  }
}