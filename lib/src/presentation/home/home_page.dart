import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/features/quiz/domain/models/quiz_category_model.dart';
import '../../core/features/quiz/domain/provider/quiz_provider.dart';
import '../../core/features/user/domain/provider/user_provider.dart';
import '../../extensions/custom_extensions.dart';
import '../../widget/app_background_widget.dart';
import '../quiz/quiz_page.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  static const path = '/';
  static const name = '/';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);
    final categories = ref.watch(quizCategoriesProvider);
    final deviceType = context.deviceType;

    if (user == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return AppBackgroundWidget(
      body: Column(
        children: [
          // Header with user info
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: deviceType == DeviceType.mobile ? 20 : 40,
              vertical: 20,
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: deviceType == DeviceType.mobile ? 25 : 35,
                  backgroundImage: NetworkImage(user.imageUrl),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.name,
                        style: TextStyle(
                          fontSize: deviceType == DeviceType.mobile ? 18 : 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Rank #${user.rank} • Score: ${user.score}',
                        style: TextStyle(
                          fontSize: deviceType == DeviceType.mobile ? 14 : 18,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Categories List
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(
                horizontal: deviceType == DeviceType.mobile ? 20 : 40,
                vertical: 10,
              ),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                return _CategoryCard(
                  category: category,
                  onTap: () {
                    context.pushNamed(
                      QuizPage.name,
                      extra: category,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  const _CategoryCard({
    required this.category,
    required this.onTap,
  });

  final QuizCategoryModel category;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: Colors.black, width: 1),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      category.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    LinearProgressIndicator(
                      value: category.progress / 100,
                      backgroundColor: Colors.grey[300],
                      valueColor: const AlwaysStoppedAnimation<Color>(Colors.black),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${category.progress}% Complete',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios, size: 20),
            ],
          ),
        ),
      ),
    );
  }
}
