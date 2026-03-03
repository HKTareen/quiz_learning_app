import 'package:freezed_annotation/freezed_annotation.dart';

part 'quiz_question_dto.freezed.dart';
part 'quiz_question_dto.g.dart';

@freezed
abstract class QuizQuestionDto with _$QuizQuestionDto {
  const QuizQuestionDto._();

  factory QuizQuestionDto({
    @JsonKey(name: 'category') required String category,
    @JsonKey(name: 'type') required String type,
    @JsonKey(name: 'difficulty') required String difficulty,
    @JsonKey(name: 'question') required String question,
    @JsonKey(name: 'correct_answer') required String correctAnswer,
    @JsonKey(name: 'incorrect_answers') required List<String> incorrectAnswers,
  }) = _QuizQuestionDto;

  factory QuizQuestionDto.fromJson(Map<String, dynamic> json) =>
      _$QuizQuestionDtoFromJson(json);
}

@freezed
abstract class QuizResponseDto with _$QuizResponseDto {
  const QuizResponseDto._();

  factory QuizResponseDto({
    @JsonKey(name: 'response_code') required int responseCode,
    @JsonKey(name: 'results') required List<QuizQuestionDto> results,
  }) = _QuizResponseDto;

  factory QuizResponseDto.fromJson(Map<String, dynamic> json) =>
      _$QuizResponseDtoFromJson(json);
}
