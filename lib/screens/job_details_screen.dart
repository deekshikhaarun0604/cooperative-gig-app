import 'package:flutter/material.dart';

class JobDetailsScreen extends StatelessWidget {
  const JobDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Job Details'),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            const Text(
              'Electrician – Fan Repair',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            _detail(
              Icons.person_outline,
              'Customer',
              'Lakshmi',
            ),

            _detail(
              Icons.location_on_outlined,
              'Distance',
              '2.5 km away',
            ),

            _detail(
              Icons.calendar_today_outlined,
              'Date',
              'Today',
            ),

            _detail(
              Icons.access_time,
              'Time',
              '4:30 PM',
            ),

            _detail(
              Icons.description_outlined,
              'Problem',
              'Ceiling fan is not working.',
            ),

            const SizedBox(height: 25),

            const Text(
              'Job Status',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            _status('REQUESTED', false),
            _status('ACCEPTED', true),
            _status('WORKER_TRAVELLING', false),
            _status('ARRIVED', false),
            _status('SERVICE_IN_PROGRESS', false),
            _status('COMPLETED', false),

            const SizedBox(height: 25),

            Row(
              children: [

                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    child: const Text('Reject'),
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text('Accept Job'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _detail(
      IconData icon,
      String title,
      String value,
      ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),

      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),

      child: Row(
        children: [

          Icon(icon),

          const SizedBox(width: 12),

          Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,

            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 3),

              Text(
                value,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _status(
      String status,
      bool active,
      ) {
    return ListTile(
      leading: Icon(
        active
            ? Icons.check_circle
            : Icons.circle_outlined,

        color: active
            ? Colors.green
            : Colors.grey,
      ),

      title: Text(status),
    );
  }
}