import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/ranking_user_model.dart';
import 'ranking_api_service.dart';

part 'ranking_service.g.dart';

abstract class RankingService {
  const RankingService();

  Future<List<RankingUserModel>> fetchRankingUsers();
}

@riverpod
RankingService rankingService(Ref ref) {
  return RankingApiService();
}
