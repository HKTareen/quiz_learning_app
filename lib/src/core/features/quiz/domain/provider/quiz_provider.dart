import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/quiz_category_model.dart';
import '../models/quiz_question_model.dart';
import '../models/quiz_result_model.dart';
import '../services/quiz_service.dart';

part 'quiz_provider.g.dart';

@riverpod
class QuizState extends _$QuizState {
  @override
  List<QuizQuestionModel> build() {
    return [];
  }

  void setQuestions(List<QuizQuestionModel> questions) {
    state = questions;
  }

  void clearQuestions() {
    state = [];
  }
}

@riverpod
class QuizCategories extends _$QuizCategories {
  @override
  List<QuizCategoryModel> build() {
    return [
      QuizCategoryModel(id: 9, name: 'General Knowledge', progress: 0),
      QuizCategoryModel(id: 19, name: 'Math', progress: 0),
      QuizCategoryModel(id: 10, name: 'English', progress: 0),
      QuizCategoryModel(id: 17, name: 'Science & Nature', progress: 0),
      QuizCategoryModel(id: 18, name: 'Computers', progress: 0),
      QuizCategoryModel(id: 21, name: 'Sports', progress: 0),
      QuizCategoryModel(id: 22, name: 'Geography', progress: 0),
      QuizCategoryModel(id: 23, name: 'History', progress: 0),
      QuizCategoryModel(id: 25, name: 'Art', progress: 0),
      QuizCategoryModel(id: 27, name: 'Animals', progress: 0),
    ];
  }

  void updateCategoryProgress(int categoryId, int progress) {
    state = state.map((category) {
      if (category.id == categoryId) {
        return category.copyWith(progress: progress);
      }
      return category;
    }).toList();
  }
}

@riverpod
Future<List<QuizQuestionModel>> fetchQuizQuestions(
  Ref ref, {
  required int category,
  required int amount,
}) async {
  final service = ref.read(quizServiceProvider);
  return await service.fetchQuestions(
    category: category,
    amount: amount,
  );
}

@riverpod
class QuizResult extends _$QuizResult {
  @override
  QuizResultModel? build() {
    return null;
  }

  void setResult(QuizResultModel result) {
    state = result;
  }

  void clearResult() {
    state = null;
  }
}
