import 'package:flutter/material.dart';
import 'common/localization/language_screen.dart';
import 'settings.dart';
import 'screens/jobs_screen.dart';
import 'screens/earnings_screen.dart';
import 'screens/notifications_screen.dart';
import 'screens/skill_development_screen.dart';

class WorkerHome extends StatefulWidget {
  final String workerName;
  final String city;
  final String workType;

  const WorkerHome({
    super.key,
    this.workerName = 'Worker',
    this.city = 'Your City',
    this.workType = 'Worker',
  });

  @override
  State<WorkerHome> createState() => _WorkerHomeState();
}

class _WorkerHomeState extends State<WorkerHome> {
  int currentIndex = 0;

  late final List<Widget> pages;

  @override
  void initState() {
    super.initState();

    pages = [
      WorkerDashboard(
        workerName: widget.workerName,
        city: widget.city,
        workType: widget.workType,
      ),
      const JobsScreen(),
      const EarningsScreen(),
      const SettingsScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.grey,

        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.work_outline),
            activeIcon: Icon(Icons.work),
            label: 'Jobs',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet_outlined),
            activeIcon: Icon(Icons.account_balance_wallet),
            label: 'Earnings',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            activeIcon: Icon(Icons.settings),
            label: 'More',
          ),
        ],
      ),
    );
  }
}


// =====================================================
// WORKER DASHBOARD
// =====================================================

class WorkerDashboard extends StatefulWidget {
  final String workerName;
  final String city;
  final String workType;

  const WorkerDashboard({
    super.key,
    required this.workerName,
    required this.city,
    required this.workType,
  });

  @override
  State<WorkerDashboard> createState() => _WorkerDashboardState();
}

class _WorkerDashboardState extends State<WorkerDashboard> {
  bool isAvailable = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,

        title: const Text(
          'Task Unity',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),

        actions: [
          // Language
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const LanguageScreen(),
                ),
              );
            },
            icon: const Icon(
              Icons.language,
              color: Colors.black,
            ),
            tooltip: 'Language',
          ),

          // Notifications
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const NotificationsScreen(),
                ),
              );
            },
            icon: const Icon(
              Icons.notifications_none,
              color: Colors.black,
            ),
            tooltip: 'Notifications',
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // PROFILE
            Text(
              'Good Morning, ${widget.workerName} 👋',
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 6),

            Row(
              children: [
                const Icon(
                  Icons.verified,
                  color: Colors.green,
                  size: 18,
                ),

                const SizedBox(width: 5),

                const Text(
                  'VERIFIED WORKER',
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 6),

            Text(
              '${widget.workType} • ${widget.city}',
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 20),

            // =====================================================
            // SKILL DEVELOPMENT
            // =====================================================

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
                  Row(
                    children: [
                      Container(
                        height: 48,
                        width: 48,

                        decoration: BoxDecoration(
                          color: Colors.deepPurple.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),

                        child: const Icon(
                          Icons.school_outlined,
                          color: Colors.deepPurple,
                          size: 28,
                        ),
                      ),

                      const SizedBox(width: 12),

                      const Expanded(
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,

                          children: [
                            Text(
                              'Skill Development',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            SizedBox(height: 4),

                            Text(
                              'Improve your skills and explore training',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 15),

                  const Text(
                    'Recommended training can help you expand your skill profile and access more job opportunities.',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 13,
                      height: 1.4,
                    ),
                  ),

                  const SizedBox(height: 15),

                  SizedBox(
                    width: double.infinity,
                    height: 45,

                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                            const SkillDevelopmentScreen(),
                          ),
                        );
                      },

                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        foregroundColor: Colors.white,

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),

                      child: const Text(
                        'Explore Skill Development',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // =====================================================
            // AVAILABILITY
            // =====================================================

            _sectionTitle('Work Status'),

            const SizedBox(height: 10),

            Container(
              padding: const EdgeInsets.all(18),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),

              child: Row(
                children: [
                  Icon(
                    Icons.circle,
                    color: isAvailable
                        ? Colors.green
                        : Colors.grey,
                    size: 14,
                  ),

                  const SizedBox(width: 10),

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,

                      children: [
                        Text(
                          isAvailable
                              ? 'AVAILABLE'
                              : 'OFFLINE',

                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 4),

                        Text(
                          isAvailable
                              ? 'You can receive new jobs'
                              : 'You will not receive new jobs',

                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Switch(
                    value: isAvailable,

                    onChanged: (value) {
                      setState(() {
                        isAvailable = value;
                      });
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // =====================================================
            // TODAY'S SUMMARY
            // =====================================================

            _sectionTitle('Today'),

            const SizedBox(height: 10),

            Row(
              children: [
                Expanded(
                  child: _summaryCard(
                    Icons.work_outline,
                    '4',
                    'Jobs',
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: _summaryCard(
                    Icons.currency_rupee,
                    '₹1,250',
                    'Earnings',
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // =====================================================
            // SERVICE REQUEST
            // =====================================================

            _sectionTitle('New Service Request'),

            const SizedBox(height: 10),

            Container(
              padding: const EdgeInsets.all(18),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),

              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,

                children: [
                  const Row(
                    children: [
                      CircleAvatar(
                        child: Icon(Icons.person),
                      ),

                      SizedBox(width: 12),

                      Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,

                        children: [
                          Text(
                            'Lakshmi',
                            style: TextStyle(
                              fontWeight:
                              FontWeight.bold,
                            ),
                          ),

                          Text(
                            '2.5 km away',
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  Text(
                    '${widget.workType} – Service Request',
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 6),

                  const Text(
                    'Customer needs help with a service.',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),

                  const SizedBox(height: 15),

                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {},
                          child: const Text('Reject'),
                        ),
                      ),

                      const SizedBox(width: 10),

                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          child: const Text('Accept'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // =====================================================
            // VERIFICATION
            // =====================================================

            _sectionTitle('Verification Status'),

            const SizedBox(height: 10),

            _verificationCard(
              Icons.badge_outlined,
              'e-Shram',
              'Verified',
              true,
            ),

            _verificationCard(
              Icons.workspace_premium_outlined,
              'Skill Certification',
              'Verified',
              true,
            ),

            _verificationCard(
              Icons.shield_outlined,
              'Insurance',
              'Active',
              true,
            ),

            const SizedBox(height: 20),

            // =====================================================
            // LOCATION
            // =====================================================

            _sectionTitle('Location Sharing'),

            const SizedBox(height: 10),

            Container(
              padding: const EdgeInsets.all(18),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),

              child: Row(
                children: [
                  const Icon(
                    Icons.location_on_outlined,
                    size: 30,
                  ),

                  const SizedBox(width: 12),

                  const Expanded(
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,

                      children: [
                        Text(
                          'Location Sharing',
                          style: TextStyle(
                            fontWeight:
                            FontWeight.bold,
                          ),
                        ),

                        SizedBox(height: 4),

                        Text(
                          'ON while available',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const Icon(
                    Icons.check_circle,
                    color: Colors.green,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 19,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _summaryCard(
      IconData icon,
      String value,
      String label,
      ) {
    return Container(
      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),

      child: Column(
        children: [
          Icon(
            icon,
            size: 28,
          ),

          const SizedBox(height: 8),

          Text(
            value,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 4),

          Text(
            label,
            style: const TextStyle(
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _verificationCard(
      IconData icon,
      String title,
      String status,
      bool verified,
      ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),

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
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          Icon(
            verified
                ? Icons.check_circle
                : Icons.pending,
            color: verified
                ? Colors.green
                : Colors.orange,
          ),

          const SizedBox(width: 5),

          Text(
            status,
            style: TextStyle(
              color: verified
                  ? Colors.green
                  : Colors.orange,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}