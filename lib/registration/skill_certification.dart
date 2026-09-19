import 'package:flutter/material.dart';
import 'certification_verification.dart';

class SkillCertification extends StatefulWidget {
  final String workerName;
  final String city;
  final String workType;

  const SkillCertification({
    super.key,
    required this.workerName,
    required this.city,
    required this.workType,
  });

  @override
  State<SkillCertification> createState() => _SkillCertificationState();
}

class _SkillCertificationState extends State<SkillCertification> {
  String? selectedSkill;
  String? selectedCertification;

  void continueToVerification() {
    if (selectedSkill == null || selectedCertification == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select your skill and certification'),
        ),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CertificationVerification(
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
        title: const Text('Skill Certification'),
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
                'Skill & Certification',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                'Provide your primary skill and relevant certification details.',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 15,
                ),
              ),

              const SizedBox(height: 30),

              const Text(
                'Primary Skill',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 8),

              DropdownButtonFormField<String>(
                value: selectedSkill,
                decoration: InputDecoration(
                  hintText: 'Select your skill',
                  prefixIcon: const Icon(Icons.build_outlined),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                ),
                items: const [
                  DropdownMenuItem(
                    value: 'Electrician',
                    child: Text('Electrician'),
                  ),
                  DropdownMenuItem(
                    value: 'Plumber',
                    child: Text('Plumber'),
                  ),
                  DropdownMenuItem(
                    value: 'Carpenter',
                    child: Text('Carpenter'),
                  ),
                  DropdownMenuItem(
                    value: 'Painter',
                    child: Text('Painter'),
                  ),
                  DropdownMenuItem(
                    value: 'Cleaner',
                    child: Text('Cleaner'),
                  ),
                  DropdownMenuItem(
                    value: 'Driver',
                    child: Text('Driver'),
                  ),
                  DropdownMenuItem(
                    value: 'Gardener',
                    child: Text('Gardener'),
                  ),
                  DropdownMenuItem(
                    value: 'Technician',
                    child: Text('Technician'),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    selectedSkill = value;
                  });
                },
              ),

              const SizedBox(height: 25),

              const Text(
                'Certification',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 8),

              DropdownButtonFormField<String>(
                value: selectedCertification,
                decoration: InputDecoration(
                  hintText: 'Select certification',
                  prefixIcon: const Icon(
                    Icons.workspace_premium_outlined,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                ),
                items: const [
                  DropdownMenuItem(
                    value: 'PMKVY',
                    child: Text('PMKVY'),
                  ),
                  DropdownMenuItem(
                    value: 'ITI',
                    child: Text('ITI'),
                  ),
                  DropdownMenuItem(
                    value: 'Government Skill Certificate',
                    child: Text('Government Skill Certificate'),
                  ),
                  DropdownMenuItem(
                    value: 'Other',
                    child: Text('Other'),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    selectedCertification = value;
                  });
                },
              ),

              const SizedBox(height: 25),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: Colors.deepPurple,
                    ),

                    SizedBox(width: 12),

                    Expanded(
                      child: Text(
                        'Your certification details will be verified before you are approved as a worker.',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 35),

              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: continueToVerification,
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
}