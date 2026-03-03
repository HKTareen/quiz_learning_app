import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/ranking_user_model.dart';
import '../services/ranking_service.dart';

part 'ranking_provider.g.dart';

@riverpod
Future<List<RankingUserModel>> fetchRankingUsers(Ref ref) async {
  final service = ref.read(rankingServiceProvider);
  return await service.fetchRankingUsers();
}
