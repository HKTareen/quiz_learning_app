import 'package:freezed_annotation/freezed_annotation.dart';

part 'quiz_category_model.freezed.dart';

@freezed
abstract class QuizCategoryModel with _$QuizCategoryModel {
  const QuizCategoryModel._();

  factory QuizCategoryModel({
    required int id,
    required String name,
    required int progress,
  }) = _QuizCategoryModel;
}
