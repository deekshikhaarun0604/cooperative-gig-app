import 'package:flutter/material.dart';

class FeedbackScreen extends StatelessWidget {
  const FeedbackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feedback'),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,

          children: [

            const Text(
              'Give Feedback',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Category',
                border: OutlineInputBorder(),
              ),

              items: const [
                DropdownMenuItem(
                  value: 'Mobile App',
                  child: Text('Mobile App'),
                ),

                DropdownMenuItem(
                  value: 'Payment',
                  child: Text('Payment'),
                ),

                DropdownMenuItem(
                  value: 'Job Allocation',
                  child: Text('Job Allocation'),
                ),

                DropdownMenuItem(
                  value: 'Training',
                  child: Text('Training'),
                ),

                DropdownMenuItem(
                  value: 'Welfare',
                  child: Text('Welfare'),
                ),

                DropdownMenuItem(
                  value: 'Cooperative',
                  child: Text('Cooperative'),
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
                child: const Text('SUBMIT FEEDBACK'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}