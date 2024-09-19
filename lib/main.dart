import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'screens/home_screen.dart';
import 'package:tpm_app/screens/history_screen.dart';
import 'package:tpm_app/screens/add_edit_screen.dart';
import 'services/notification_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final notificationService = NotificationService();
  notificationService.initNotifications();

  runApp(
    const ProviderScope(
      child: Myapp(),
    ),
  );
}

class Myapp extends StatelessWidget {
  const Myapp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TpmAPP',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
      routes: {
        '/add_edit': (context) => const AddEditScreen(),
        '/history': (context) => const HistoryScreen(),
      },
    );
  }
}
