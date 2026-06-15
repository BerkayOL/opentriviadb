abstract final class AppStrings {
  static const String appName = 'Trivia Quiz';
  static const String brandName = 'Quizora';
  static const String splashSubTitle = 'Test your knowledge.';
  static const String setupSubtitle = 'Set up your quiz and start when ready.';
  static const String comingSoon = 'Coming soon.';
  static const String history = 'History';
  static const String home = 'Quiz';
  static const String settings = 'Settings';
  static const String category = 'Category';
  static const String difficulty = 'Difficulty';
  static const String setupReady = 'Ready';
  static const String numberOfQuestions = 'Number of Questions';
  static const String questionType = 'Question Type';
  static const String chooseCategory = 'Choose a category';
  static const String selectQuestionCount = 'Select question count';
  static const String selectQuestionType = 'Select question type';
  static const String anyLevel = 'Any level';
  static const historySubtitle = 'Track your completed quizzes and best score.';
  static const highestScore = 'Highest Score';
  static const clearHistory = 'Clear History';
  static const noHistoryTitle = 'No quiz history yet.';
  static const String loadingQuestions = 'Preparing your questions...';
  static String questionProgress(int current, int total) {
    return 'Question $current of $total';
  }

  static const String noQuestionsTitle = 'No questions available.';
  static const String noQuestionsMessage =
      'Try a different setup or check back later.';

  static const String noQuestionAvailable = 'Question is not available.';

  static const String seeResults = 'See Results';
  static const String nextQuestion = 'Next Question';

  static const String quizCompleted = 'Quiz completed';
  static const String restartQuiz = 'Restart Quiz';

  static String quizScoreResult(int score, int totalQuestions) {
    return 'You answered $score of $totalQuestions correctly.';
  }

  static const noHistoryMessage = 'Complete a quiz to see your results here.';
  static const genericError = 'Something went wrong.';
  static const correct = 'correct';
  static const clearHistoryConfirmMessage =
      'This will delete your saved quiz results.';
  static const cancel = 'Cancel';
  static const clear = 'Clear';
  static const completedAt = 'Completed at';
  static const recentQuizzes = 'Recent Quizzes';
  static const String settingsSubtitle = 'Adjust how Quizora works for you.';
  static const String appearance = 'Appearance';
  static const String defaultSystemSubTitle = 'Follow your device appearance.';
  static const String lightSystemSubTitle = 'Bright and clean interface.';
  static const String darkSystemSubTitle = 'Deep focus mode.';
  static const String themeSectionSubtitle =
      'Choose your preferred appearance.';
  static const String easy = 'Easy';
  static const String medium = 'Medium';
  static const String systemTheme = 'System theme';
  static const String lightTheme = 'Light theme';
  static const String darkTheme = 'Dark theme';
  static const String hard = 'Hard';
  static const String multipleChoice = 'Multiple Choice';
  static const String trueFalse = 'True / False';
  static const String startQuiz = 'Start Quiz';
  static const String categoriesLoadError = 'Categories could not be loaded.';
  static const String noCategoriesFound = 'No categories found';
  static const String noCategoriesMessage =
      'Try again or start without choosing a category.';
  static const String correctAnswersLabel = 'correct answers';
  static String correctAnswerCount(int count) {
    return count == 1 ? '$count correct answer' : '$count correct answers';
  }
}
