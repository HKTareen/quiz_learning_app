import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/sign_in_model.dart';
import '../services/auth_service.dart';

part 'login_provider.g.dart';

@riverpod
class Login extends _$Login {
  @override
  AsyncValue<void> build() {
    return const AsyncData(null);
  }

  Future<void> login(SignInModel model) async {
    try {
      state = const AsyncLoading();
      await ref.read(authServiceProvider).login(model);
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
      rethrow;
    }
  }
}
