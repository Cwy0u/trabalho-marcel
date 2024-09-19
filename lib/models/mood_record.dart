import 'package:flutter/foundation.dart';

class MoodRecord {
  final DateTime date;
  final String mood;
  final String description;

  MoodRecord({
    required this.date,
    required this.mood,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'date': date.toIso8601String(),
      'mood': mood,
      'description': description,
    };
  }

  factory MoodRecord.fromMap(Map<String, dynamic> map) {
    return MoodRecord(
        date: DateTime.parse(map['date']),
        mood: map['mood'],
        description: map['description'],
        );
  }
}
