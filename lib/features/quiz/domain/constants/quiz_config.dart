abstract final class QuizConfig {
  static const int defaultQuestionAmount = 10;
  static const List<int> questionCountOptions = [5, 10, 15, 20];

  static const int questionDurationSeconds = 30;
  static const int timerCriticalThresholdSeconds = 5;

  static const double highScoreRatio = 0.8;
  static const double mediumScoreRatio = 0.4;
}
