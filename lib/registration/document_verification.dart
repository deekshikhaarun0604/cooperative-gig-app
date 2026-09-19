import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'skill_certification.dart';

class DocumentVerification extends StatefulWidget {
  final String workerName;
  final String city;
  final String workType;

  const DocumentVerification({
    super.key,
    required this.workerName,
    required this.city,
    required this.workType,
  });

  @override
  State<DocumentVerification> createState() =>
      _DocumentVerificationState();
}

class _DocumentVerificationState extends State<DocumentVerification> {
  String? aadhaarFile;
  String? bankFile;
  String? addressFile;

  Future<void> pickDocument(String documentType) async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: [
          'pdf',
          'jpg',
          'jpeg',
          'png',
        ],
      );

      if (result == null) {
        return;
      }

      final fileName = result.files.single.name;

      setState(() {
        if (documentType == 'Aadhaar') {
          aadhaarFile = fileName;
        } else if (documentType == 'Bank') {
          bankFile = fileName;
        } else if (documentType == 'Address') {
          addressFile = fileName;
        }
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$documentType selected: $fileName'),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Unable to select file: $e'),
        ),
      );
    }
  }

  void continueToSkills() {
    if (aadhaarFile == null ||
        bankFile == null ||
        addressFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please upload all required documents'),
        ),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SkillCertification(
          workerName: widget.workerName,
          city: widget.city,
          workType: widget.workType,
        ),
      ),
    );
  }

  Widget documentCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required String? fileName,
    required VoidCallback onUpload,
  }) {
    final bool uploaded = fileName != null;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: uploaded ? Colors.green : Colors.transparent,
          width: 1.5,
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 35,
            color: uploaded ? Colors.green : Colors.deepPurple,
          ),

          const SizedBox(width: 15),

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

                const SizedBox(height: 5),

                Text(
                  uploaded ? fileName! : subtitle,
                  style: TextStyle(
                    color: uploaded ? Colors.green : Colors.grey,
                    fontSize: 13,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),

          IconButton(
            onPressed: onUpload,
            icon: Icon(
              uploaded
                  ? Icons.check_circle
                  : Icons.upload_file,
              color: uploaded
                  ? Colors.green
                  : Colors.deepPurple,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),

      appBar: AppBar(
        title: const Text('Document Verification'),
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
                'Verify Your Documents',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                'Upload the required documents for worker verification.',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 15,
                ),
              ),

              const SizedBox(height: 30),

              documentCard(
                title: 'Aadhaar Card',
                subtitle: 'Upload Aadhaar document',
                icon: Icons.badge_outlined,
                fileName: aadhaarFile,
                onUpload: () {
                  pickDocument('Aadhaar');
                },
              ),

              const SizedBox(height: 15),

              documentCard(
                title: 'Bank Account Proof',
                subtitle: 'Upload bank account document',
                icon: Icons.account_balance_outlined,
                fileName: bankFile,
                onUpload: () {
                  pickDocument('Bank');
                },
              ),

              const SizedBox(height: 15),

              documentCard(
                title: 'Address Proof',
                subtitle: 'Upload address proof',
                icon: Icons.home_outlined,
                fileName: addressFile,
                onUpload: () {
                  pickDocument('Address');
                },
              ),

              const SizedBox(height: 30),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
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
                        'Your documents will be reviewed by the cooperative administrator before worker activation.',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: continueToSkills,
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