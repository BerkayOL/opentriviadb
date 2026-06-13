import 'package:hive_ce/hive.dart';

import '../../domain/entities/quiz_history_entry.dart';
import '../models/quiz_history_model.dart';

abstract interface class HistoryLocalDataSource {
  Future<void> saveResult(QuizHistoryEntry entry);

  Future<List<QuizHistoryEntry>> getHistory();

  Future<void> clearHistory();
}

class HistoryLocalDataSourceImpl implements HistoryLocalDataSource {
  const HistoryLocalDataSourceImpl();

  static const String _boxName = 'quiz_history';

  @override
  Future<void> saveResult(QuizHistoryEntry entry) async {
    final box = await Hive.openBox<dynamic>(_boxName);

    final model = QuizHistoryModel.fromEntity(entry);

    await box.put(model.id, model.toMap());
  }

  @override
  Future<List<QuizHistoryEntry>> getHistory() async {
    final box = await Hive.openBox<dynamic>(_boxName);

    final entries = <QuizHistoryEntry>[];

    for (final value in box.values) {
      try {
        if (value is! Map) {
          continue;
        }

        final map = Map<String, dynamic>.from(value);
        final entry = QuizHistoryModel.fromMap(map).toEntity();

        entries.add(entry);
      } catch (_) {
        continue;
      }
    }

    entries.sort((a, b) => b.createdAt.compareTo(a.createdAt));

    return entries;
  }

  @override
  Future<void> clearHistory() async {
    final box = await Hive.openBox<dynamic>(_boxName);
    await box.clear();
  }
}
