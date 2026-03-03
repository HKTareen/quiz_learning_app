import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/user_model.dart';

part 'user_provider.g.dart';

@riverpod
class CurrentUser extends _$CurrentUser {
  @override
  UserModel? build() {
    // Initialize with default user after login
    return UserModel(
      id: '1',
      name: 'Test User',
      email: 'test@gmail.com',
      imageUrl: 'https://i.pravatar.cc/150?img=1',
      rank: 5,
      score: 1250,
    );
  }

  void updateUser(UserModel user) {
    state = user;
  }

  void updateScore(int newScore) {
    if (state != null) {
      state = state!.copyWith(score: newScore);
    }
  }

  void clearUser() {
    state = null;
  }
}
