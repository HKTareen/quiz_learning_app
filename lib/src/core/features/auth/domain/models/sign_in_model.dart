import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/dto/sign_in_dto.dart';

part 'sign_in_model.freezed.dart';

@freezed
abstract class SignInModel with _$SignInModel {
  const SignInModel._();

  factory SignInModel({required String email, required String password}) =
      _SignInModel;

  SignInDto toDto() {
    return SignInDto(email: email, password: password);
  }
}
