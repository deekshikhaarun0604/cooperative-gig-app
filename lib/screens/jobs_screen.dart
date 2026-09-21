import 'package:flutter/material.dart';
import 'job_details_screen.dart';

class JobsScreen extends StatefulWidget {
const JobsScreen({super.key});

@override
State<JobsScreen> createState() => _JobsScreenState();
}

class _JobsScreenState extends State<JobsScreen> {
final List<Map<String, dynamic>> _activeJobs = [
{
'service': 'Electrician – Fan Repair',
'customer': 'Lakshmi',
'distance': '2.5 km',
'status': 'REQUESTED',
},
{
'service': 'Electrical Wiring',
'customer': 'Arun',
'distance': '4.1 km',
'status': 'ACCEPTED',
},
{
'service': 'Switch Repair',
'customer': 'Priya',
'distance': '1.8 km',
'status': 'TRAVELLING',
},
];

final List<Map<String, dynamic>> _completedJobs = [
{
'service': 'Ceiling Fan Installation',
'customer': 'Kumar',
'distance': '3.2 km',
'status': 'COMPLETED',
},
];

void _acceptJob(int index) {
setState(() {
_activeJobs[index]['status'] = 'ACCEPTED';
});

ScaffoldMessenger.of(context).showSnackBar(
const SnackBar(
content: Text('Job accepted successfully'),
),
);
}

void _rejectJob(int index) {
final String service =
_activeJobs[index]['service'] as String;

setState(() {
_activeJobs.removeAt(index);
});

ScaffoldMessenger.of(context).showSnackBar(
SnackBar(
content: Text('$service rejected'),
),
);
}

void _openJobDetails() {
Navigator.push(
context,
MaterialPageRoute(
builder: (_) => const JobDetailsScreen(),
),
);
}

@override
Widget build(BuildContext context) {
final requestedJobs = _activeJobs
    .where((job) => job['status'] == 'REQUESTED')
    .toList();

final otherActiveJobs = _activeJobs
    .where((job) => job['status'] != 'REQUESTED')
    .toList();

return Scaffold(
appBar: AppBar(
title: const Text('My Jobs'),
),
body: ListView(
padding: const EdgeInsets.all(16),
children: [
if (requestedJobs.isNotEmpty) ...[
const Text(
'New Service Requests',
style: TextStyle(
fontSize: 20,
fontWeight: FontWeight.bold,
),
),
const SizedBox(height: 12),

...requestedJobs.map((job) {
final int index = _activeJobs.indexOf(job);

return _requestedJobCard(
job,
index,
);
}),

const SizedBox(height: 25),
],

if (otherActiveJobs.isNotEmpty) ...[
const Text(
'Active Jobs',
style: TextStyle(
fontSize: 20,
fontWeight: FontWeight.bold,
),
),
const SizedBox(height: 12),

...otherActiveJobs.map((job) {
return _jobCard(job);
}),

const SizedBox(height: 25),
],

const Text(
'Completed',
style: TextStyle(
fontSize: 20,
fontWeight: FontWeight.bold,
),
),

const SizedBox(height: 12),

if (_completedJobs.isEmpty)
const Padding(
padding: EdgeInsets.symmetric(vertical: 20),
child: Center(
child: Text(
'No completed jobs',
style: TextStyle(
color: Colors.grey,
),
),
),
)
else
..._completedJobs.map(
(job) => _jobCard(job),
),
],
),
);
}

Widget _requestedJobCard(
Map<String, dynamic> job,
int index,
) {
return Card(
margin: const EdgeInsets.only(bottom: 12),
child: Padding(
padding: const EdgeInsets.all(14),
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
InkWell(
onTap: _openJobDetails,
child: Row(
children: [
const CircleAvatar(
child: Icon(Icons.build),
),

const SizedBox(width: 12),

Expanded(
child: Column(
crossAxisAlignment:
CrossAxisAlignment.start,
children: [
Text(
job['service'],
style: const TextStyle(
fontWeight: FontWeight.bold,
fontSize: 16,
),
),

const SizedBox(height: 5),

Text(
'${job['customer']} • ${job['distance']}',
style: const TextStyle(
color: Colors.grey,
),
),
],
),
),

_statusBadge(
'REQUESTED',
Colors.orange,
),
],
),
),

const SizedBox(height: 14),

Row(
children: [
Expanded(
child: OutlinedButton(
onPressed: () => _rejectJob(index),
child: const Text('Reject'),
),
),

const SizedBox(width: 10),

Expanded(
child: ElevatedButton(
onPressed: () => _acceptJob(index),
child: const Text('Accept'),
),
),
],
),
],
),
),
);
}

Widget _jobCard(
Map<String, dynamic> job,
) {
final String status = job['status'] as String;

final Color statusColor =
_statusColor(status);

return Card(
margin: const EdgeInsets.only(bottom: 12),
child: ListTile(
leading: const CircleAvatar(
child: Icon(Icons.build),
),

title: Text(
job['service'],
style: const TextStyle(
fontWeight: FontWeight.bold,
),
),

subtitle: Text(
'${job['customer']} • ${job['distance']}',
),

trailing: _statusBadge(
status,
statusColor,
),

onTap: _openJobDetails,
),
);
}

Widget _statusBadge(
String status,
Color statusColor,
) {
return Container(
padding: const EdgeInsets.symmetric(
horizontal: 8,
vertical: 5,
),
decoration: BoxDecoration(
color: statusColor.withValues(alpha: 0.1),
borderRadius: BorderRadius.circular(8),
),
child: Text(
status,
style: TextStyle(
color: statusColor,
fontSize: 11,
fontWeight: FontWeight.bold,
),
),
);
}

Color _statusColor(String status) {
switch (status) {
case 'ACCEPTED':
return Colors.blue;

case 'TRAVELLING':
return Colors.deepPurple;

case 'COMPLETED':
return Colors.green;

case 'REQUESTED':
return Colors.orange;

default:
return Colors.grey;
}
}
}