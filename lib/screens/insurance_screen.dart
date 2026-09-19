import 'package:flutter/material.dart';

class InsuranceScreen extends StatelessWidget {
  const InsuranceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Insurance & Welfare'),
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),

        children: [

          Container(
            padding: const EdgeInsets.all(20),

            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),

            child: const Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,

              children: [

                Icon(
                  Icons.shield,
                  size: 40,
                ),

                SizedBox(height: 12),

                Text(
                  'Insurance Active',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 6),

                Text(
                  'Your insurance information and welfare options.',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          _item(
            context,
            Icons.description_outlined,
            'Policy Information',
          ),

          _item(
            context,
            Icons.account_balance_wallet_outlined,
            'Contribution History',
          ),

          _item(
            context,
            Icons.assignment_outlined,
            'Insurance Claims',
          ),

          _item(
            context,
            Icons.volunteer_activism_outlined,
            'Welfare / Schemes',
          ),

          _item(
            context,
            Icons.event_outlined,
            'Expiry & Renewal',
          ),
        ],
      ),
    );
  }

  Widget _item(
      BuildContext context,
      IconData icon,
      String title,
      ) {
    return Card(
      child: ListTile(
        leading: Icon(icon),

        title: Text(title),

        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 16,
        ),

        onTap: () {},
      ),
    );
  }
}