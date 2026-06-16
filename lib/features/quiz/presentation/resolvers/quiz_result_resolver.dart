import 'package:flutter/material.dart';

import '../../../../core/constants/app_strings.dart';
import '../../domain/constants/quiz_config.dart';

abstract final class QuizResultResolver {
  static double scoreRatio({required int score, required int totalQuestions}) {
    if (totalQuestions == 0) {
      return 0;
    }

    return score / totalQuestions;
  }

  static String title(double ratio) {
    if (ratio >= QuizConfig.highScoreRatio) {
      return AppStrings.greatJob;
    }

    if (ratio >= QuizConfig.mediumScoreRatio) {
      return AppStrings.goodEffort;
    }

    return AppStrings.keepPracticing;
  }

  static IconData icon(double ratio) {
    if (ratio >= QuizConfig.highScoreRatio) {
      return Icons.emoji_events_rounded;
    }

    if (ratio >= QuizConfig.mediumScoreRatio) {
      return Icons.track_changes_rounded;
    }

    return Icons.refresh_rounded;
  }
}
