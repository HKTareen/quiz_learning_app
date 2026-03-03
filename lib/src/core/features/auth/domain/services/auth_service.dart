import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/sign_in_model.dart';
import 'auth_api_service.dart';

part 'auth_service.g.dart';

abstract class AuthService {
  const AuthService();

  Future<void> login(SignInModel model);
}

@riverpod
AuthService authService(Ref ref) {
  return AuthApiService();
}
