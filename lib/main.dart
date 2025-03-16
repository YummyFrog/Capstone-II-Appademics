import 'package:flutter/material.dart';
import 'login_screen.dart';
// import 'register_screen.dart'; temporarily removed
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:appademics/noti_service.dart';

void main() {
  sqfliteFfiInit(); // Initialize SQLite FFI
  databaseFactory = databaseFactoryFfi; // Set the database factory
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Notifications
  NotiService().initNotification();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Manager App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LoginPage(), // Start with the login screen
    );
  }
}