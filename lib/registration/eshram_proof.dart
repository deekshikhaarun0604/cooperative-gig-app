import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'document_verification.dart';

class EShramProof extends StatefulWidget {
  final bool hasEShram;

  // Worker details
  final String workerName;
  final String city;
  final String workType;

  const EShramProof({
    super.key,
    required this.hasEShram,
    required this.workerName,
    required this.city,
    required this.workType,
  });

  @override
  State<EShramProof> createState() => _EShramProofState();
}

class _EShramProofState extends State<EShramProof> {
  final TextEditingController eshramNumberController =
  TextEditingController();

  String? uploadedFileName;

  Future<void> pickEShramProof() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
    );

    if (result != null && result.files.isNotEmpty) {
      setState(() {
        uploadedFileName = result.files.single.name;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('e-Shram proof uploaded successfully'),
        ),
      );
    }
  }

  void continueToVerification() {
    if (widget.hasEShram &&
        eshramNumberController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter your e-Shram number'),
        ),
      );
      return;
    }

    if (widget.hasEShram && uploadedFileName == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please upload your e-Shram proof'),
        ),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => DocumentVerification(
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
        title: const Text('e-Shram Verification'),
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
                'e-Shram Details',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              Text(
                widget.hasEShram
                    ? 'Enter your e-Shram registration details.'
                    : 'You need to complete e-Shram registration before continuing.',
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 15,
                ),
              ),

              const SizedBox(height: 30),

              if (widget.hasEShram) ...[
                const Text(
                  'e-Shram Number',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                TextField(
                  controller: eshramNumberController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Enter e-Shram number',
                    prefixIcon: const Icon(
                      Icons.badge_outlined,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                const Text(
                  'e-Shram Proof',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: uploadedFileName != null
                          ? Colors.green
                          : Colors.transparent,
                      width: 1.5,
                    ),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        uploadedFileName != null
                            ? Icons.check_circle
                            : Icons.upload_file_outlined,
                        size: 45,
                        color: uploadedFileName != null
                            ? Colors.green
                            : Colors.deepPurple,
                      ),

                      const SizedBox(height: 10),

                      Text(
                        uploadedFileName != null
                            ? 'Proof Uploaded'
                            : 'Upload e-Shram proof',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: uploadedFileName != null
                              ? Colors.green
                              : Colors.black,
                        ),
                      ),

                      const SizedBox(height: 5),

                      Text(
                        uploadedFileName != null
                            ? uploadedFileName!
                            : 'PDF, JPG, JPEG or PNG',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 13,
                        ),
                      ),

                      const SizedBox(height: 15),

                      OutlinedButton.icon(
                        onPressed: pickEShramProof,
                        icon: const Icon(Icons.upload),
                        label: Text(
                          uploadedFileName != null
                              ? 'Change Document'
                              : 'Upload Document',
                        ),
                      ),
                    ],
                  ),
                ),
              ] else ...[
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Column(
                    children: [
                      Icon(
                        Icons.info_outline,
                        size: 45,
                        color: Colors.deepPurple,
                      ),

                      SizedBox(height: 12),

                      Text(
                        'e-Shram registration required',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),

                      SizedBox(height: 8),

                      Text(
                        'Please complete your e-Shram registration and provide the required proof before proceeding.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],

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

  @override
  void dispose() {
    eshramNumberController.dispose();
    super.dispose();
  }
}