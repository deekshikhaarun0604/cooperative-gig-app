import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'insurance_choice.dart';

class CertificationVerification extends StatefulWidget {
  final String workerName;
  final String city;
  final String workType;

  const CertificationVerification({
    super.key,
    required this.workerName,
    required this.city,
    required this.workType,
  });

  @override
  State<CertificationVerification> createState() =>
      _CertificationVerificationState();
}

class _CertificationVerificationState
    extends State<CertificationVerification> {
  String? certificateFileName;

  Future<void> uploadCertificate() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
    );

    if (result != null && result.files.isNotEmpty) {
      setState(() {
        certificateFileName = result.files.single.name;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Certificate uploaded successfully'),
        ),
      );
    }
  }

  void continueToInsurance() {
    if (certificateFileName == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please upload your certificate first'),
        ),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => InsuranceChoice(
          workerName: widget.workerName,
          city: widget.city,
          workType: widget.workType,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool certificateUploaded = certificateFileName != null;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),

      appBar: AppBar(
        title: const Text('Certificate Verification'),
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
                'Upload Your Certificate',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                'Upload your skill certificate for cooperative verification.',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 15,
                ),
              ),

              const SizedBox(height: 30),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: certificateUploaded
                        ? Colors.green
                        : Colors.transparent,
                    width: 1.5,
                  ),
                ),

                child: Column(
                  children: [
                    Icon(
                      certificateUploaded
                          ? Icons.check_circle
                          : Icons.upload_file_outlined,
                      size: 55,
                      color: certificateUploaded
                          ? Colors.green
                          : Colors.deepPurple,
                    ),

                    const SizedBox(height: 15),

                    Text(
                      certificateUploaded
                          ? 'Certificate Uploaded'
                          : 'No Certificate Uploaded',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: certificateUploaded
                            ? Colors.green
                            : Colors.black,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      certificateUploaded
                          ? certificateFileName!
                          : 'PDF, JPG, JPEG or PNG',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 13,
                      ),
                    ),

                    const SizedBox(height: 20),

                    SizedBox(
                      width: double.infinity,
                      height: 48,

                      child: OutlinedButton.icon(
                        onPressed: uploadCertificate,
                        icon: const Icon(Icons.upload_file),
                        label: Text(
                          certificateUploaded
                              ? 'Change Certificate'
                              : 'Upload Certificate',
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                height: 52,

                child: ElevatedButton(
                  onPressed: continueToInsurance,

                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),

                  child: const Text(
                    'Continue',
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
}