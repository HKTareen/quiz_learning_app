import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../binding.dart';

part 'preferences_provider.g.dart';

@riverpod
SharedPreferences sharedPreferences(Ref ref) {
  return QuizLearningAppBinding.instance.sharedPreferences;
}
