import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/quiz_request.dart';
import 'quiz_state.dart';

class QuizCubit extends Cubit<QuizState> {
  QuizCubit() : super(const QuizState());

  Future<void> startQuiz(QuizRequest request) async {
    // TODO: Load questions through GetQuestionsUseCase.
    emit(const QuizState(status: QuizStatus.loading));
  }

  void answerCurrentQuestion(String answer) {
    // TODO: Evaluate selected answer and advance quiz state.
  }

  Future<void> finishQuiz() async {
    // TODO: Save result through SaveQuizResultUseCase.
  }
}
