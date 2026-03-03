import '../dto/sign_in_dto.dart';

class AuthApi {
  Future<void> login(SignInDto signInDto) async {
    await Future.delayed(const .new(seconds: 3));
    final email = signInDto.email;
    final password = signInDto.password;
    if (email != 'test@gmail.com' && password != 'Test@123') {
      throw 'Invalid email and password';
    }
    if (email != 'test@gmail.com') {
      throw 'Invalid email, please try again';
    }
    if (password != 'Test@123') {
      throw 'Invalid password';
    }
  }
}
