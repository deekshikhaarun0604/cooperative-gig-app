import 'package:flutter/material.dart';
import 'customer_location_screen.dart';

class JobDetailsScreen extends StatefulWidget {
  const JobDetailsScreen({super.key});

  @override
  State<JobDetailsScreen> createState() => _JobDetailsScreenState();
}

class _JobDetailsScreenState extends State<JobDetailsScreen> {

  String currentStatus = 'REQUESTED';

  final List<String> statuses = [
    'REQUESTED',
    'ACCEPTED',
    'WORKER_TRAVELLING',
    'ARRIVED',
    'SERVICE_IN_PROGRESS',
    'COMPLETED',
  ];

  void updateStatus() {
    int currentIndex = statuses.indexOf(currentStatus);

    if (currentIndex < statuses.length - 1) {
      setState(() {
        currentStatus = statuses[currentIndex + 1];
      });
    }
  }

  String getActionText() {
    switch (currentStatus) {
      case 'REQUESTED':
        return 'Accept Job';

      case 'ACCEPTED':
        return 'Start Travelling';

      case 'WORKER_TRAVELLING':
        return 'Mark as Arrived';

      case 'ARRIVED':
        return 'Start Service';

      case 'SERVICE_IN_PROGRESS':
        return 'Complete Job';

      case 'COMPLETED':
        return 'Job Completed';

      default:
        return 'Continue';
    }
  }

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

            ...statuses.map(
                  (status) => _status(status),
            ),

            const SizedBox(height: 20),

            // SHOW LOCATION AFTER ACCEPTING/TRAVELLING
            if (currentStatus == 'WORKER_TRAVELLING' ||
                currentStatus == 'ARRIVED')
              SizedBox(
                width: double.infinity,
                height: 52,
                child: OutlinedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                        const CustomerLocationScreen(),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.location_on_outlined,
                  ),
                  label: const Text(
                    'View Customer Location',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

            const SizedBox(height: 15),

            // REJECT BUTTON ONLY BEFORE ACCEPTING
            if (currentStatus == 'REQUESTED')
              SizedBox(
                width: double.infinity,
                height: 50,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Reject Job'),
                ),
              ),

            const SizedBox(height: 10),

            // MAIN ACTION BUTTON
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: currentStatus == 'COMPLETED'
                    ? null
                    : updateStatus,
                child: Text(
                  getActionText(),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
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

          Expanded(
            child: Column(
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
          ),
        ],
      ),
    );
  }

  Widget _status(String status) {

    int statusIndex = statuses.indexOf(status);
    int currentIndex = statuses.indexOf(currentStatus);

    bool completed = statusIndex < currentIndex;
    bool active = statusIndex == currentIndex;

    return ListTile(
      leading: Icon(
        completed || active
            ? Icons.check_circle
            : Icons.circle_outlined,

        color: completed || active
            ? Colors.green
            : Colors.grey,
      ),

      title: Text(
        status,
        style: TextStyle(
          fontWeight:
          active ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}