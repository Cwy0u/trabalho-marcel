import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/mood_provider.dart';
import 'add_edit_screen.dart';
import 'history_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final moodRecords = ref.watch(moodRecordsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('TpmAPP'),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {
              Navigator.pushNamed(context, '/history');
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: moodRecords.length,
        itemBuilder: (context, index) {
          final record = moodRecords[index];
          return ListTile(
            title: Text(record.mood),
            subtitle: Text(record.description),
            trailing: Text('${record.date.toLocal()}'),
            onTap: () {
              Navigator.pushNamed(
                context,
                '/add_edit',
                arguments: record,
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add_edit');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
