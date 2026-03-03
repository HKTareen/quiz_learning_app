import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class QuizLearningAppBinding {
  QuizLearningAppBinding() : assert(_instance == null) {
    initInstance();
  }

  static QuizLearningAppBinding get instance => checkInstance(_instance);
  static QuizLearningAppBinding? _instance;

  @protected
  @mustCallSuper
  void initInstance() => _instance = this;

  static T checkInstance<T extends QuizLearningAppBinding>(T? instance) {
    assert(() {
      if (instance == null) {
        throw FlutterError.fromParts([
          ErrorSummary('QuizLearningApp binding has not yet been initialized.'),
          ErrorHint(
            'In the app, this is done by the `AppQuizLearningAppBinding.ensureInitialized()` call '
            'in the `void main()` method.',
          ),
          ErrorHint(
            'In a test, one can call `TestQuizLearningAppBinding.ensureInitialized()` as the '
            "first line in the test's `main()` method to initialize the binding.",
          ),
        ]);
      }
      return true;
    }());
    return instance!;
  }

  SharedPreferences get sharedPreferences;
}

class AppQuizLearningAppBinding extends QuizLearningAppBinding {
  AppQuizLearningAppBinding();

  factory AppQuizLearningAppBinding.ensureInitialized() {
    if (QuizLearningAppBinding._instance == null) AppQuizLearningAppBinding();
    return QuizLearningAppBinding.instance as AppQuizLearningAppBinding;
  }

  SharedPreferences? _preferences;

  @override
  SharedPreferences get sharedPreferences {
    if (_preferences == null) {
      throw FlutterError.fromParts([
        ErrorSummary('Shared preferences have not yet been preloaded.'),
        ErrorHint(
          'In the app, this is done by the `await AppQuizLearningAppBinding.preloadSharedPreferences()` call '
          'in the `Future<void> main()` method.',
        ),
        ErrorHint(
          'In a test, one can call `TestQuizLearningAppBinding.setInitialSharedPreferencesValues({})` as the '
          "first line in the test's `main()` method.",
        ),
      ]);
    }
    return _preferences!;
  }

  Future<void> loadSharedPreferences() async {
    _preferences = await SharedPreferences.getInstance();
  }
}
