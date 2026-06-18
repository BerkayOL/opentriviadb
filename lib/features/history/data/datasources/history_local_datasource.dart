import 'dart:developer' as developer;

import 'package:hive_ce/hive.dart';

import '../../domain/entities/quiz_history_entry.dart';
import '../constants/history_storage_keys.dart';
import '../models/quiz_history_model.dart';

abstract interface class HistoryLocalDataSource {
  Future<void> saveResult(QuizHistoryEntry entry);

  Future<List<QuizHistoryEntry>> getHistory();

  Future<void> clearHistory();
}

class HistoryLocalDataSourceImpl implements HistoryLocalDataSource {
  const HistoryLocalDataSourceImpl();

  static const String _invalidValueMessage = 'Stored value is not a map.';
  static const String _parseFailureMessage =
      'Stored value could not be parsed.';
  static const String _logName = 'HistoryLocalDataSource';

  @override
  Future<void> saveResult(QuizHistoryEntry entry) async {
    final box = await Hive.openBox<dynamic>(HistoryStorageKeys.boxName);

    final model = QuizHistoryModel.fromEntity(entry);

    await box.put(model.id, model.toMap());
  }

  @override
  Future<List<QuizHistoryEntry>> getHistory() async {
    final box = await Hive.openBox<dynamic>(HistoryStorageKeys.boxName);

    final entries = <QuizHistoryEntry>[];

    for (final storedEntry in box.toMap().entries) {
      final key = storedEntry.key;
      final value = storedEntry.value;

      try {
        if (value is! Map) {
          _logInvalidHistoryEntry(key, _invalidValueMessage);
          continue;
        }

        final map = Map<String, dynamic>.from(value);
        final entry = QuizHistoryModel.fromMap(map).toEntity();

        entries.add(entry);
      } catch (error, stackTrace) {
        _logInvalidHistoryEntry(
          key,
          _parseFailureMessage,
          error: error,
          stackTrace: stackTrace,
        );
        continue;
      }
    }

    entries.sort((a, b) => b.createdAt.compareTo(a.createdAt));

    return entries;
  }

  @override
  Future<void> clearHistory() async {
    final box = await Hive.openBox<dynamic>(HistoryStorageKeys.boxName);
    await box.clear();
  }

  void _logInvalidHistoryEntry(
    Object? key,
    String message, {
    Object? error,
    StackTrace? stackTrace,
  }) {
    assert(() {
      developer.log(
        '$message Key: $key',
        name: _logName,
        error: error,
        stackTrace: stackTrace,
      );
      return true;
    }());
  }
}
