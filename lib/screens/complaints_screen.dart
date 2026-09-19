import 'package:flutter/material.dart';

class ComplaintsScreen extends StatelessWidget {
  const ComplaintsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Complaints'),
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),

        children: [

          const Text(
            'Raise Complaint',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 15),

          DropdownButtonFormField<String>(
            decoration: const InputDecoration(
              labelText: 'Complaint Type',
              border: OutlineInputBorder(),
            ),

            items: const [
              DropdownMenuItem(
                value: 'Payment Issue',
                child: Text('Payment Issue'),
              ),

              DropdownMenuItem(
                value: 'Customer Behaviour',
                child: Text('Customer Behaviour'),
              ),

              DropdownMenuItem(
                value: 'Unsafe Working Condition',
                child: Text(
                  'Unsafe Working Condition',
                ),
              ),

              DropdownMenuItem(
                value: 'Wrong Job Information',
                child: Text(
                  'Wrong Job Information',
                ),
              ),

              DropdownMenuItem(
                value: 'Job Cancellation',
                child: Text(
                  'Job Cancellation',
                ),
              ),

              DropdownMenuItem(
                value: 'Location Problem',
                child: Text(
                  'Location Problem',
                ),
              ),

              DropdownMenuItem(
                value: 'Platform Problem',
                child: Text(
                  'Platform Problem',
                ),
              ),

              DropdownMenuItem(
                value: 'Insurance Issue',
                child: Text(
                  'Insurance Issue',
                ),
              ),
            ],

            onChanged: (value) {},
          ),

          const SizedBox(height: 15),

          DropdownButtonFormField<String>(
            decoration: const InputDecoration(
              labelText: 'Priority',
              border: OutlineInputBorder(),
            ),

            items: const [
              DropdownMenuItem(
                value: 'Normal',
                child: Text('Normal'),
              ),

              DropdownMenuItem(
                value: 'Urgent',
                child: Text('Urgent'),
              ),

              DropdownMenuItem(
                value: 'Emergency',
                child: Text('Emergency'),
              ),
            ],

            onChanged: (value) {},
          ),

          const SizedBox(height: 15),

          const TextField(
            maxLines: 5,

            decoration: InputDecoration(
              labelText: 'Description',
              border: OutlineInputBorder(),
            ),
          ),

          const SizedBox(height: 20),

          SizedBox(
            width: double.infinity,

            child: ElevatedButton(
              onPressed: () {},
              child: const Text('RAISE COMPLAINT'),
            ),
          ),

          const SizedBox(height: 30),

          const Text(
            'My Complaints',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          const Card(
            child: ListTile(
              title: Text('CMP-2026-00128'),
              subtitle: Text(
                'Payment Issue • Under Review',
              ),
              trailing: Icon(
                Icons.pending,
              ),
            ),
          ),
        ],
      ),
    );
  }
}