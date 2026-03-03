import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/dto/quiz_question_dto.dart';

part 'quiz_question_model.freezed.dart';

@freezed
abstract class QuizQuestionModel with _$QuizQuestionModel {
  const QuizQuestionModel._();

  factory QuizQuestionModel({
    required String category,
    required String type,
    required String difficulty,
    required String question,
    required String correctAnswer,
    required List<String> allAnswers,
  }) = _QuizQuestionModel;

  factory QuizQuestionModel.fromDto(QuizQuestionDto dto) {
    final allAnswers = [dto.correctAnswer, ...dto.incorrectAnswers]..shuffle();
    return QuizQuestionModel(
      category: dto.category,
      type: dto.type,
      difficulty: dto.difficulty,
      question: dto.question,
      correctAnswer: dto.correctAnswer,
      allAnswers: allAnswers,
    );
  }
}
