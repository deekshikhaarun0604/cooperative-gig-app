import 'package:flutter/material.dart';
import 'job_details_screen.dart';

class JobsScreen extends StatelessWidget {
  const JobsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Jobs'),
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),

        children: [

          const Text(
            'Active Jobs',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 12),

          _jobCard(
            context,
            'Electrician – Fan Repair',
            'Lakshmi',
            '2.5 km',
            'REQUESTED',
            Colors.orange,
          ),

          _jobCard(
            context,
            'Electrical Wiring',
            'Arun',
            '4.1 km',
            'ACCEPTED',
            Colors.blue,
          ),

          _jobCard(
            context,
            'Switch Repair',
            'Priya',
            '1.8 km',
            'TRAVELLING',
            Colors.deepPurple,
          ),

          const SizedBox(height: 25),

          const Text(
            'Completed',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 12),

          _jobCard(
            context,
            'Ceiling Fan Installation',
            'Kumar',
            '3.2 km',
            'COMPLETED',
            Colors.green,
          ),
        ],
      ),
    );
  }

  Widget _jobCard(
      BuildContext context,
      String service,
      String customer,
      String distance,
      String status,
      Color statusColor,
      ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),

      child: ListTile(
        leading: const CircleAvatar(
          child: Icon(Icons.build),
        ),

        title: Text(
          service,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

        subtitle: Text(
          '$customer • $distance',
        ),

        trailing: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 5,
          ),

          decoration: BoxDecoration(
            color: statusColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),

          child: Text(
            status,
            style: TextStyle(
              color: statusColor,
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const JobDetailsScreen(),
            ),
          );
        },
      ),
    );
  }
}