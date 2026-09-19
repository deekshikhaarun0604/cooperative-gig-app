import 'package:flutter/material.dart';
import 'screens/insurance_screen.dart';
import 'screens/notifications_screen.dart';
import 'screens/feedback_screen.dart';
import 'screens/complaints_screen.dart';
import 'login/worker_login.dart';
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Worker'),
      ),

      body: ListView(
        children: [

          const ListTile(
            leading: CircleAvatar(
              child: Icon(Icons.person),
            ),

            title: Text(
              'Darshan Arun',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),

            subtitle: Text(
              'Verified Electrician',
            ),
          ),

          const Divider(),

          _item(
            context,
            Icons.person_outline,
            'Profile',
                () {},
          ),

          _item(
            context,
            Icons.workspace_premium_outlined,
            'Skills & Certifications',
                () {},
          ),

          _item(
            context,
            Icons.badge_outlined,
            'e-Shram',
                () {},
          ),

          _item(
            context,
            Icons.shield_outlined,
            'Insurance & Welfare',
                () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const InsuranceScreen(),
                ),
              );
            },
          ),

          _item(
            context,
            Icons.star_outline,
            'Ratings',
                () {},
          ),

          _item(
            context,
            Icons.feedback_outlined,
            'Feedback',
                () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const FeedbackScreen(),
                ),
              );
            },
          ),

          _item(
            context,
            Icons.report_problem_outlined,
            'Complaints',
                () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const ComplaintsScreen(),
                ),
              );
            },
          ),

          _item(
            context,
            Icons.notifications_outlined,
            'Notifications',
                () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const NotificationsScreen(),
                ),
              );
            },
          ),

          const Divider(),

          _item(
            context,
            Icons.language,
            'Language',
                () {},
          ),

          _item(
            context,
            Icons.settings_outlined,
            'Account Settings',
                () {},
          ),

          _item(
            context,
            Icons.logout,
            'Log Out',
                () {Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const WorkerLogin(),
                  ),
                      (route) => false,
                );},
          ),
        ],
      ),
    );
  }

  Widget _item(
      BuildContext context,
      IconData icon,
      String title,
      VoidCallback onTap,
      ) {
    return ListTile(
      leading: Icon(icon),

      title: Text(title),

      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 16,
      ),

      onTap: onTap,
    );
  }
}