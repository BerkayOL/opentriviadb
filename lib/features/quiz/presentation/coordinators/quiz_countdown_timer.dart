import 'dart:async';

import '../../domain/constants/quiz_config.dart';

class QuizCountdownTimer {
  Timer? _timer;

  void start(void Function() onTick) {
    stop();
    _timer = Timer.periodic(QuizConfig.timerTickInterval, (_) => onTick());
  }

  void stop() {
    _timer?.cancel();
    _timer = null;
  }

  void dispose() {
    stop();
  }
}
