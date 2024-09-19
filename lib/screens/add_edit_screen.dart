import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/mood_provider.dart';
import '../models/mood_record.dart';
import '../models/mood_types.dart';
import '../services/notification_service.dart';

class AddEditScreen extends ConsumerStatefulWidget {
  const AddEditScreen({Key? key}) : super(key: key);

  @override
  _AddEditScreenState createState() => _AddEditScreenState();
}

class _AddEditScreenState extends ConsumerState<AddEditScreen> {
  String _selectedMood = moodTypes.first;
  final _moodController = TextEditingController();
  final _descriptionController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final record = ModalRoute.of(context)?.settings.arguments as MoodRecord?;
    if (record != null) {
      _selectedMood = record.mood;
      _descriptionController.text = record.description;
      _selectedDate = record.date;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar seus humores'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButton<String>(
              value: _selectedMood,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedMood = newValue!;
                });
              },
              items: moodTypes.map<DropdownMenuItem<String>>((String mood) {
                return DropdownMenuItem<String>(
                  value: mood,
                  child: Text(mood),
                );
              }).toList(),
            ),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                  labelText: 'Diga aqui o que esta sentido'),
            ),
            ElevatedButton(
              onPressed: () async {
                final record = MoodRecord(
                  date: _selectedDate,
                  mood: _selectedMood,
                  description: _descriptionController.text,
                );
                await ref.read(moodRecordsProvider.notifier).addRecord(record);
                Navigator.pop(context);
              },
              child: const Text('Salvar'),
            ),
          ],
        ),
      ),
    );
  }
}
