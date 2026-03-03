import 'package:freezed_annotation/freezed_annotation.dart';

part 'ranking_user_dto.freezed.dart';
part 'ranking_user_dto.g.dart';

@freezed
abstract class RankingUserDto with _$RankingUserDto {
  const RankingUserDto._();

  factory RankingUserDto({
    required String id,
    required String name,
    required String imageUrl,
    required int rank,
    required int score,
  }) = _RankingUserDto;

  factory RankingUserDto.fromJson(Map<String, dynamic> json) =>
      _$RankingUserDtoFromJson(json);
}
