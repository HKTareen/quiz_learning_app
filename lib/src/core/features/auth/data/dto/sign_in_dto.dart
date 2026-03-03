import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/models/sign_in_model.dart';

part 'sign_in_dto.freezed.dart';
part 'sign_in_dto.g.dart';

@freezed
abstract class SignInDto with _$SignInDto {
  const SignInDto._();

  factory SignInDto({
    required final String email,
    required final String password,
  }) = _SignInDto;

  factory SignInDto.fromJson(Map<String, dynamic> json) =>
      _$SignInDtoFromJson(json);

  SignInModel toModel() {
    return SignInModel(email: email, password: password);
  }
}
