import 'package:flutter/material.dart';

class EarningsScreen extends StatelessWidget {
  const EarningsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Earnings'),
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),

        children: [

          _moneyCard(
            'Gross Earnings',
            '₹45,000',
            Icons.account_balance_wallet_outlined,
          ),

          const SizedBox(height: 12),

          _moneyCard(
            'Insurance Contribution',
            '₹2,200',
            Icons.shield_outlined,
          ),

          const SizedBox(height: 12),

          _moneyCard(
            'Net Eligible Earnings',
            '₹42,800',
            Icons.payments_outlined,
          ),

          const SizedBox(height: 25),

          const Text(
            'Contribution History',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 12),

          _history(
            'Electrician – Fan Repair',
            '₹100',
            'Today',
          ),

          _history(
            'Electrical Wiring',
            '₹250',
            'Yesterday',
          ),

          _history(
            'Switch Repair',
            '₹150',
            '18 Sep',
          ),
        ],
      ),
    );
  }

  Widget _moneyCard(
      String title,
      String amount,
      IconData icon,
      ) {
    return Container(
      padding: const EdgeInsets.all(20),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),

      child: Row(
        children: [

          Icon(
            icon,
            size: 32,
          ),

          const SizedBox(width: 15),

          Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,

            children: [

              Text(
                title,
                style: const TextStyle(
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 5),

              Text(
                amount,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _history(
      String service,
      String amount,
      String date,
      ) {
    return Card(
      child: ListTile(
        leading: const Icon(
          Icons.receipt_long,
        ),

        title: Text(service),

        subtitle: Text(date),

        trailing: Text(
          amount,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}