import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import '../providers/mood_provider.dart';
import '../models/mood_types.dart';
import '../models/mood_record.dart';

class HistoryScreen extends ConsumerWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final moodRecords = ref.watch(moodRecordsProvider);

    final moodCountMap = <String, int>{};
    for (var moodType in moodTypes) {
      moodCountMap[moodType] = 0;
    }
    for (var record in moodRecords) {
      moodCountMap[record.mood] = (moodCountMap[record.mood] ?? 0) + 1;
    }

    final data = moodTypes.map((moodTypes) {
      return MoodCount(moodTypes, moodCountMap[moodTypes] ?? 0);
    }).toList();

    final series = [
      charts.Series<MoodCount, String>(
        id: 'MoodCounts',
        domainFn: (MoodCount moodCount, _) => moodCount.mood,
        measureFn: (MoodCount moodCount, _) => moodCount.count,
        data: data,
        labelAccessorFn: (MoodCount moodCount, _) => '${moodCount.count}',
      )
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Histórico de Humor'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: charts.BarChart(
          series,
          animate: true,
          barRendererDecorator: charts.BarLabelDecorator<String>(),
          domainAxis: const charts.OrdinalAxisSpec(),
        ),
      ),
    );
  }
}

class MoodCount {
  final String mood;
  final int count;

  MoodCount(this.mood, this.count);
}
