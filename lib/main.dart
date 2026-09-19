import 'package:flutter/material.dart';
import 'login/worker_login.dart';

void main() {
  runApp(const TaskUnityApp());
}

class TaskUnityApp extends StatelessWidget {
  const TaskUnityApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Task Unity',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        scaffoldBackgroundColor: const Color(0xFFF5F7FA),
        useMaterial3: true,
      ),
      home: const WorkerLogin(),
    );
  }
}