import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/dto/ranking_user_dto.dart';

part 'ranking_user_model.freezed.dart';

@freezed
abstract class RankingUserModel with _$RankingUserModel {
  const RankingUserModel._();

  factory RankingUserModel({
    required String id,
    required String name,
    required String imageUrl,
    required int rank,
    required int score,
  }) = _RankingUserModel;

  factory RankingUserModel.fromDto(RankingUserDto dto) {
    return RankingUserModel(
      id: dto.id,
      name: dto.name,
      imageUrl: dto.imageUrl,
      rank: dto.rank,
      score: dto.score,
    );
  }
}
