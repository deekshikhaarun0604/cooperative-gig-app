import 'package:flutter/material.dart';
import 'eshram_proof.dart';

class EShramStatus extends StatefulWidget {
  final String workerName;
  final String city;
  final String workType;

  const EShramStatus({
    super.key,
    required this.workerName,
    required this.city,
    required this.workType,
  });

  @override
  State<EShramStatus> createState() => _EShramStatusState();
}

class _EShramStatusState extends State<EShramStatus> {
  String? selectedStatus;

  void continueToProof() {
    if (selectedStatus == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select your e-Shram status'),
        ),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => EShramProof(
          hasEShram: selectedStatus == 'Yes',

          // Pass worker details forward
          workerName: widget.workerName,
          city: widget.city,
          workType: widget.workType,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),

      appBar: AppBar(
        title: const Text('e-Shram Status'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'e-Shram Registration',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                'Tell us whether you already have an e-Shram registration.',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 15,
                ),
              ),

              const SizedBox(height: 35),

              const Text(
                'Do you have an e-Shram registration?',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 15),

              _statusOption(
                title: 'Yes, I have e-Shram',
                value: 'Yes',
                icon: Icons.verified_user_outlined,
              ),

              const SizedBox(height: 15),

              _statusOption(
                title: 'No, I do not have e-Shram',
                value: 'No',
                icon: Icons.person_add_alt_1,
              ),

              const SizedBox(height: 35),

              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: continueToProof,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text(
                    'Continue',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _statusOption({
    required String title,
    required String value,
    required IconData icon,
  }) {
    final isSelected = selectedStatus == value;

    return InkWell(
      onTap: () {
        setState(() {
          selectedStatus = value;
        });
      },
      borderRadius: BorderRadius.circular(14),

      child: Container(
        padding: const EdgeInsets.all(18),

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected
                ? Colors.deepPurple
                : Colors.transparent,
            width: 2,
          ),
        ),

        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.deepPurple,
              size: 30,
            ),

            const SizedBox(width: 15),

            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            Radio<String>(
              value: value,
              groupValue: selectedStatus,
              onChanged: (newValue) {
                setState(() {
                  selectedStatus = newValue;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}