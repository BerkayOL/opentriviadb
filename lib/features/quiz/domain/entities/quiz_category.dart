import 'package:equatable/equatable.dart';

class QuizCategory extends Equatable {
  const QuizCategory({required this.id, required this.name});

  final int id;
  final String name;

  @override
  List<Object?> get props => [id, name];
}
