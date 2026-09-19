import 'package:flutter/material.dart';
import 'cooperative_approval.dart';

class InsuranceChoice extends StatefulWidget {
  final String workerName;
  final String city;
  final String workType;

  const InsuranceChoice({
    super.key,
    required this.workerName,
    required this.city,
    required this.workType,
  });

  @override
  State<InsuranceChoice> createState() => _InsuranceChoiceState();
}

class _InsuranceChoiceState extends State<InsuranceChoice> {
  String? selectedInsurance;

  void continueToApproval() {
    if (selectedInsurance == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select an insurance option'),
        ),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CooperativeApproval(
          workerName: widget.workerName,
          city: widget.city,
          workType: widget.workType,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool wantsInsurance = selectedInsurance == 'Yes';

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),

      appBar: AppBar(
        title: const Text('Insurance & Welfare'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Insurance & Welfare',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                'Choose whether you want insurance and welfare coverage.',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 15,
                ),
              ),

              const SizedBox(height: 25),

              _optionCard(
                title: 'Yes, I want insurance coverage',
                subtitle:
                '10% of eligible earnings from completed jobs will be allocated towards your insurance/welfare contribution.',
                value: 'Yes',
                icon: Icons.shield_outlined,
              ),

              const SizedBox(height: 15),

              _optionCard(
                title: 'No, I do not want insurance coverage',
                subtitle:
                'Continue without selecting the insurance/welfare contribution option.',
                value: 'No',
                icon: Icons.shield_outlined,
              ),

              if (wantsInsurance) ...[
                const SizedBox(height: 20),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(
                            Icons.percent,
                            color: Colors.deepPurple,
                          ),

                          SizedBox(width: 10),

                          Text(
                            '10% Contribution Model',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      const Text(
                        'For every completed job, 10% of the worker’s eligible earnings will be allocated towards the insurance/welfare contribution.',
                        style: TextStyle(
                          color: Colors.grey,
                          height: 1.4,
                        ),
                      ),

                      const SizedBox(height: 15),

                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF5F7FA),
                          borderRadius: BorderRadius.circular(12),
                        ),

                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Example',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            SizedBox(height: 8),

                            Text(
                              'Job earnings: ₹1,000',
                            ),

                            Text(
                              'Insurance/Welfare contribution: ₹100 (10%)',
                            ),

                            Text(
                              'Remaining earnings: ₹900',
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 12),

                      const Text(
                        'The contribution is based on completed job earnings, so workers do not need to make a fixed monthly or yearly payment.',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 13,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ],

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                height: 52,

                child: ElevatedButton(
                  onPressed: continueToApproval,

                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),

                  child: const Text(
                    'Agree & Continue',
                    style: TextStyle(
                      fontSize: 16,
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

  Widget _optionCard({
    required String title,
    required String subtitle,
    required String value,
    required IconData icon,
  }) {
    final bool selected = selectedInsurance == value;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedInsurance = value;
        });
      },

      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(18),

        decoration: BoxDecoration(
          color: Colors.white,

          borderRadius: BorderRadius.circular(16),

          border: Border.all(
            color: selected
                ? Colors.deepPurple
                : Colors.transparent,
            width: 2,
          ),
        ),

        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Icon(
              icon,
              color: selected
                  ? Colors.deepPurple
                  : Colors.grey,
              size: 30,
            ),

            const SizedBox(width: 14),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 13,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),

            Radio<String>(
              value: value,
              groupValue: selectedInsurance,
              onChanged: (value) {
                setState(() {
                  selectedInsurance = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}