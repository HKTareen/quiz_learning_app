import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/features/user/domain/provider/user_provider.dart';
import '../auth/sign_in_page.dart';
import '../home/home_page.dart';
import '../profile/profile_page.dart';
import '../ranking/ranking_page.dart';

class MainTabPage extends ConsumerStatefulWidget {
  const MainTabPage.builder(
    BuildContext context,
    GoRouterState state, {
    super.key,
  });

  static const path = '/main';
  static const name = 'main';

  @override
  ConsumerState<MainTabPage> createState() => _MainTabPageState();
}

class _MainTabPageState extends ConsumerState<MainTabPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this, initialIndex: 1);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(currentUserProvider);
    if (user == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.goNamed(SignInPage.name);
      });
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      body: TabBarView(
        controller: _tabController,
        children: [
          const ProfilePage(),
          const HomePage(),
          const RankingPage(),
        ],
      ),
      bottomNavigationBar: TabBar(
        controller: _tabController,
        tabs: const [
          Tab(icon: Icon(Icons.person), text: 'Profile'),
          Tab(icon: Icon(Icons.home), text: 'Home'),
          Tab(icon: Icon(Icons.leaderboard), text: 'Ranking'),
        ],
        labelColor: Colors.black,
        unselectedLabelColor: Colors.grey,
        indicatorColor: Colors.black,
      ),
    );
  }
}
