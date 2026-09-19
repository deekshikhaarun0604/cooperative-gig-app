import 'package:flutter/material.dart';
import 'worker_activated.dart';

class CooperativeApproval extends StatefulWidget {
  final String workerName;
  final String city;
  final String workType;

  const CooperativeApproval({
    super.key,
    required this.workerName,
    required this.city,
    required this.workType,
  });

  @override
  State<CooperativeApproval> createState() => _CooperativeApprovalState();
}

class _CooperativeApprovalState extends State<CooperativeApproval> {
  bool submitted = false;
  bool adminApproved = false;

  void submitForApproval() {
    setState(() {
      submitted = true;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Application submitted for cooperative review'),
      ),
    );
  }

  void simulateAdminApproval() {
    setState(() {
      adminApproved = true;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Cooperative administrator approved the worker'),
      ),
    );
  }

  Widget statusCard({
    required String title,
    required String subtitle,
    required IconData icon,
  }) {
    Color statusColor;
    IconData statusIcon;
    String statusText;

    if (!submitted) {
      statusColor = Colors.grey;
      statusIcon = Icons.radio_button_unchecked;
      statusText = 'Not Submitted';
    } else if (!adminApproved) {
      statusColor = Colors.orange;
      statusIcon = Icons.pending_outlined;
      statusText = 'Pending Review';
    } else {
      statusColor = Colors.green;
      statusIcon = Icons.verified;
      statusText = 'Verified';
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: statusColor.withOpacity(0.5),
          width: 1.5,
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.deepPurple,
            size: 32,
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
                  subtitle,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  statusText,
                  style: TextStyle(
                    color: statusColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            statusIcon,
            color: statusColor,
            size: 27,
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
        title: const Text('Cooperative Approval'),
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
                'Worker Approval',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                'Your submitted details will be reviewed by the cooperative administrator.',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 15,
                ),
              ),

              const SizedBox(height: 30),

              const Text(
                'Verification Status',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 15),

              statusCard(
                title: 'Documents',
                subtitle: 'Aadhaar, bank and address proof',
                icon: Icons.description_outlined,
              ),

              const SizedBox(height: 15),

              statusCard(
                title: 'Skill Certification',
                subtitle: 'Submitted skill and certificate details',
                icon: Icons.workspace_premium_outlined,
              ),

              const SizedBox(height: 25),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                ),

                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      submitted
                          ? (adminApproved
                          ? Icons.check_circle
                          : Icons.pending_actions)
                          : Icons.admin_panel_settings_outlined,
                      color: adminApproved
                          ? Colors.green
                          : Colors.deepPurple,
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Administrator Review',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),

                          const SizedBox(height: 8),

                          Text(
                            !submitted
                                ? 'Submit your application for cooperative administrator review.'
                                : adminApproved
                                ? 'Your application has been approved by the cooperative administrator.'
                                : 'Your application is currently waiting for administrator review.',
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 13,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              if (!submitted)
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: submitForApproval,

                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      foregroundColor: Colors.white,

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),

                    child: const Text(
                      'Submit for Approval',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

              if (submitted && !adminApproved) ...[
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),

                  decoration: BoxDecoration(
                    color: Colors.orange.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(12),
                  ),

                  child: const Row(
                    children: [
                      Icon(
                        Icons.hourglass_top,
                        color: Colors.orange,
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'Waiting for cooperative administrator approval.',
                          style: TextStyle(
                            color: Colors.orange,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: OutlinedButton(
                    onPressed: simulateAdminApproval,
                    child: const Text(
                      'Simulate Admin Approval',
                    ),
                  ),
                ),
              ],

              if (submitted && adminApproved) ...[
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),

                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(12),
                  ),

                  child: const Row(
                    children: [
                      Icon(
                        Icons.verified,
                        color: Colors.green,
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'All verification steps are approved.',
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => WorkerActivated(
                            workerName: widget.workerName,
                            city: widget.city,
                            workType: widget.workType,
                          ),
                        ),
                      );
                    },

                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      foregroundColor: Colors.white,

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),

                    child: const Text(
                      'Continue to Activation',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}