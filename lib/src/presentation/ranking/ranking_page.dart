import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/features/ranking/domain/models/ranking_user_model.dart';
import '../../core/features/ranking/domain/provider/ranking_provider.dart';
import '../../core/features/user/domain/provider/user_provider.dart';
import '../../extensions/custom_extensions.dart';
import '../../widget/app_background_widget.dart';
import '../../widget/loading_widget.dart';

class RankingPage extends ConsumerWidget {
  const RankingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);
    final rankingAsync = ref.watch(fetchRankingUsersProvider);
    final deviceType = context.deviceType;

    if (user == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return AppBackgroundWidget(
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: deviceType == DeviceType.mobile ? 20 : 40,
              vertical: 20,
            ),
            child: Text(
              'Leaderboard',
              style: TextStyle(
                fontSize: deviceType == DeviceType.mobile ? 24 : 32,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: rankingAsync.when(
              data: (users) => ListView.builder(
                padding: EdgeInsets.symmetric(
                  horizontal: deviceType == DeviceType.mobile ? 20 : 40,
                  vertical: 10,
                ),
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final rankingUser = users[index];
                  final isCurrentUser = rankingUser.id == user.id;
                  return _RankingCard(
                    user: rankingUser,
                    isCurrentUser: isCurrentUser,
                  );
                },
              ),
              loading: () => const Center(child: LoadingWidget()),
              error: (error, stack) => Center(
                child: Text('Error: $error'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RankingCard extends StatelessWidget {
  const _RankingCard({
    required this.user,
    required this.isCurrentUser,
  });

  final RankingUserModel user;
  final bool isCurrentUser;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      color: isCurrentUser ? Colors.yellow[100] : Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: isCurrentUser ? Colors.orange : Colors.black,
          width: isCurrentUser ? 2 : 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Rank
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: isCurrentUser ? Colors.orange : Colors.black,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '${user.rank}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            // Avatar
            CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(user.imageUrl),
            ),
            const SizedBox(width: 16),
            // Name and Score
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.name,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isCurrentUser ? Colors.orange[900] : Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Score: ${user.score}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
