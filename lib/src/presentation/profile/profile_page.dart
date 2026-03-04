import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/features/user/domain/provider/user_provider.dart';
import '../../core/local_data/preferences/preferences_service.dart';
import '../../extensions/custom_extensions.dart';
import '../../widget/app_background_widget.dart';
import '../../widget/app_button_widget.dart';
import '../auth/sign_in_page.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);
    final deviceType = context.deviceType;

    if (user == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return AppBackgroundWidget(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: deviceType == DeviceType.mobile ? 20 : 40,
          vertical: 20,
        ),
        child: Column(
          children: [
            const SizedBox(height: 40),
            // Profile Image
            CircleAvatar(
              radius: deviceType == DeviceType.mobile ? 50 : 70,
              backgroundImage: NetworkImage(user.imageUrl),
            ),
            const SizedBox(height: 24),
            // Name
            Text(
              user.name,
              style: TextStyle(
                fontSize: deviceType == DeviceType.mobile ? 24 : 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            // Email
            Text(
              user.email,
              style: TextStyle(
                fontSize: deviceType == DeviceType.mobile ? 16 : 20,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 32),
            // Rank and Score Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.black, width: 1),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Rank',
                        style: TextStyle(
                          fontSize: deviceType == DeviceType.mobile ? 16 : 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        '#${user.rank}',
                        style: TextStyle(
                          fontSize: deviceType == DeviceType.mobile ? 18 : 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Score',
                        style: TextStyle(
                          fontSize: deviceType == DeviceType.mobile ? 16 : 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        '${user.score}',
                        style: TextStyle(
                          fontSize: deviceType == DeviceType.mobile ? 18 : 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            // Logout Button
            AppButtonWidget(
              title: 'Logout',
              onPressed: () async {
                await ref.read(preferencesServiceProvider).logOut();
                ref.read(currentUserProvider.notifier).clearUser();
                if (context.mounted) {
                  context.goNamed(SignInPage.name);
                }
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
