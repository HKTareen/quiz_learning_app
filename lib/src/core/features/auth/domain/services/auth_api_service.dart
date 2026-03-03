import '../../data/service/auth_api.dart';
import '../models/sign_in_model.dart';
import 'auth_service.dart';

class AuthApiService extends AuthService {
  AuthApiService();

  @override
  Future<void> login(SignInModel model) async {
    await AuthApi().login(model.toDto());
  }
}
