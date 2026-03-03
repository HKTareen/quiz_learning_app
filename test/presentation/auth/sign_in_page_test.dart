import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import 'package:quiz_learning_app/src/base/l10n/app_localizations.dart';
import 'package:quiz_learning_app/src/presentation/auth/sign_in_page.dart';

void main() {
  testWidgets('SignInPage renders without errors', (tester) async {
    final router = GoRouter(
      initialLocation: SignInPage.path,
      routes: [
        GoRoute(
          path: SignInPage.path,
          builder: SignInPage.builder,
        ),
      ],
    );

    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp.router(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          routerConfig: router,
        ),
      ),
    );

    await tester.pump();

    expect(find.byType(SignInPage), findsOneWidget);
  });
}
