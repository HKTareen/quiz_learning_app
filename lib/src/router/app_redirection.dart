part of 'router.dart';

abstract class Redirection {
  static FutureOr<String?> redirect(
    BuildContext _,
    GoRouterState state,
    Ref ref,
  ) async {
    final preferencesService = ref.read(preferencesServiceProvider);
    final isSignedIn = preferencesService.isSignIn;
    final isLoginRoute = state.fullPath == SignInPage.path;
    if (!isSignedIn) {
      if (isLoginRoute) return null;
      return SignInPage.path;
    }
    if (isLoginRoute) return MainTabPage.path;
    return null;
  }
}
