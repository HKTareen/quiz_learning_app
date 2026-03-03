library;

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../core/features/quiz/domain/models/quiz_category_model.dart';
import '../core/local_data/preferences/preferences_service.dart';
import '../presentation/auth/sign_in_page.dart';
import '../presentation/main/main_tab_page.dart';
import '../presentation/quiz/quiz_page.dart';

part 'app_redirection.dart';

part 'router.g.dart';

final navigatorKey = GlobalKey<NavigatorState>();

@riverpod
GoRouter routerConfig(Ref ref) {
  return GoRouter(
    navigatorKey: navigatorKey,
    debugLogDiagnostics: kDebugMode,
    initialLocation: MainTabPage.path,
    redirect: (context, state) => Redirection.redirect(context, state, ref),
    routes: [
      GoRoute(
        path: SignInPage.path,
        name: SignInPage.name,
        builder: SignInPage.builder,
      ),
      GoRoute(
        path: MainTabPage.path,
        name: MainTabPage.name,
        builder: MainTabPage.builder,
      ),
      GoRoute(
        path: QuizPage.path,
        name: QuizPage.name,
        builder: (context, state) {
          final category = state.extra as QuizCategoryModel?;
          return QuizPage.builder(context, state, category: category);
        },
      ),
    ],
  );
}
