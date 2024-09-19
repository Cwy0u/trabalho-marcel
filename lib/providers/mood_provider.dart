import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/mood_record.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

final moodRecordsProvider =
    StateNotifierProvider<MoodRecordsNotifier, List<MoodRecord>>((ref) {
  return MoodRecordsNotifier();
});

class MoodRecordsNotifier extends StateNotifier<List<MoodRecord>> {
  MoodRecordsNotifier() : super([]) {
    _loadRecords();
  }

  Future<void> _loadRecords() async {
    final prefs = await SharedPreferences.getInstance();
    final recordsJson = prefs.getString('moodRecords');
    if (recordsJson != null) {
      final recordList = json.decode(recordsJson) as List<dynamic>;
      state = recordList
          .map((e) => MoodRecord.fromMap(e as Map<String, dynamic>))
          .toList();
    }
  }

  Future<void> addRecord(MoodRecord record) async {
    state = [...state, record];
    await _saveRecords();
  }

  Future<void> _saveRecords() async {
    final prefs = await SharedPreferences.getInstance();
    final recordsJson = json.encode(state.map((e) => e.toMap()).toList());
    prefs.setString('moodRecords', recordsJson);
  }
}
