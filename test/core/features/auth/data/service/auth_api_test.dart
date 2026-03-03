import 'package:flutter_test/flutter_test.dart';

import 'package:quiz_learning_app/src/core/features/auth/data/dto/sign_in_dto.dart';
import 'package:quiz_learning_app/src/core/features/auth/data/service/auth_api.dart';

void main() {
  group('AuthApi', () {
    late AuthApi authApi;

    setUp(() {
      authApi = AuthApi();
    });

    test('should login successfully with correct credentials', () async {
      final dto = SignInDto(email: 'test@gmail.com', password: 'Test@123');

      expect(() => authApi.login(dto), returnsNormally);
    });

    test('should throw error when email is incorrect', () async {
      final dto = SignInDto(email: 'wrong@gmail.com', password: 'Test@123');

      expect(
        () => authApi.login(dto),
        throwsA('Invalid email, please try again'),
      );
    });

    test('should throw error when password is incorrect', () async {
      final dto = SignInDto(email: 'test@gmail.com', password: 'WrongPass');

      expect(
        () => authApi.login(dto),
        throwsA('Invalid password'),
      );
    });

    test('should throw error when both email and password are incorrect', () async {
      final dto = SignInDto(email: 'wrong@gmail.com', password: 'WrongPass');

      expect(
        () => authApi.login(dto),
        throwsA('Invalid email and password'),
      );
    });
  });
}
