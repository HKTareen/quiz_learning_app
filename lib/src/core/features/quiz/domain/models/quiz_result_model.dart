import 'package:freezed_annotation/freezed_annotation.dart';

part 'quiz_result_model.freezed.dart';

@freezed
abstract class QuizResultModel with _$QuizResultModel {
  const QuizResultModel._();

  factory QuizResultModel({
    required int totalQuestions,
    required int correctAnswers,
    required int score,
  }) = _QuizResultModel;

  int get percentage => ((correctAnswers / totalQuestions) * 100).round();
}
