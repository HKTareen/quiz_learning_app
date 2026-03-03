import '../../data/service/ranking_api.dart';
import '../../data/dto/ranking_user_dto.dart';
import '../models/ranking_user_model.dart';
import 'ranking_service.dart';

class RankingApiService extends RankingService {
  RankingApiService();

  @override
  Future<List<RankingUserModel>> fetchRankingUsers() async {
    final data = await RankingApi().fetchRankingUsers();
    return data
        .map((json) => RankingUserModel.fromDto(
              RankingUserDto.fromJson(json),
            ))
        .toList();
  }
}
