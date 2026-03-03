import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/features/app_provider/snackbar/snackbar_provider.dart';
import '../../core/features/auth/domain/provider/login_provider.dart';
import '../../core/local_data/preferences/preferences_service.dart';
import '../../extensions/custom_extensions.dart';
import '../../mixins/form_state_mixin.dart';
import '../../mixins/localization_mixin.dart';
import '../../utils/validators.dart';
import '../../widget/app_background_widget.dart';
import '../../widget/app_button_widget.dart';
import '../../widget/app_text_field.dart';
import '../../widget/container_widget.dart';
import '../../widget/form_title_widget.dart';
import '../main/main_tab_page.dart';

class SignInPage extends ConsumerStatefulWidget {
  const SignInPage.builder(
    BuildContext context,
    GoRouterState state, {
    super.key,
  });

  static const path = '/sign-in';
  static const name = 'sign-in';

  @override
  ConsumerState<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends ConsumerState<SignInPage> with FormStateMixin {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final deviceType = context.deviceType;
    final lang = context.lang;
    final isLoading = ref.watch(loginProvider) == AsyncLoading<void>();
    return Scaffold(
      body: AppBackgroundWidget(
        body: Form(
          key: formKey,
          autovalidateMode: autovalidateMode,
          child: Center(
            child: SingleChildScrollView(
              padding: const .symmetric(horizontal: 20),
              child: switch (deviceType) {
                .mobile => Column(
                  children: [
                    FormTitleWidget.mobile(title: lang.signIn),
                    TextFormFieldWidget(
                      textEditingController: _emailController,
                      hint: lang.email,
                      readonly: isLoading,
                      validator: (v) => Validators.emailValidator(v, lang),
                    ),
                    AppPasswordField(
                      textEditingController: _passwordController,
                      hint: lang.password,
                      readonly: isLoading,
                      validator: (v) => Validators.passwordValidator(v, lang),
                    ),
                    AppButtonWidget(
                      title: lang.signIn,
                      onPressed: submitter,
                      isLoading: isLoading,
                    ),
                  ],
                ),
                .tab => ContainerWidget(
                  child: Column(
                    mainAxisSize: .min,
                    children: [
                      FormTitleWidget.tab(title: lang.signIn),
                      TextFormFieldWidget(
                        textEditingController: _emailController,
                        hint: lang.email,
                        readonly: isLoading,
                        validator: (v) => Validators.emailValidator(v, lang),
                      ),
                      AppPasswordField(
                        textEditingController: _passwordController,
                        hint: lang.password,
                        readonly: isLoading,
                        validator: (v) => Validators.passwordValidator(v, lang),
                      ),
                      AppButtonWidget(
                        title: lang.signIn,
                        onPressed: submitter,
                        isLoading: isLoading,
                      ),
                    ],
                  ),
                ),
                .web => ContainerWidget(
                  child: Column(
                    mainAxisSize: .min,
                    children: [
                      FormTitleWidget.web(title: lang.signIn),
                      TextFormFieldWidget(
                        textEditingController: _emailController,
                        hint: lang.email,
                        readonly: isLoading,
                        validator: (v) => Validators.emailValidator(v, lang),
                      ),
                      AppPasswordField(
                        textEditingController: _passwordController,
                        hint: lang.password,
                        readonly: isLoading,
                        validator: (v) => Validators.passwordValidator(v, lang),
                      ),
                      AppButtonWidget(
                        title: lang.signIn,
                        onPressed: submitter,
                        isLoading: isLoading,
                      ),
                    ],
                  ),
                ),
              },
            ),
          ),
        ),
      ),
    );
  }

  @override
  Future<void> onSubmit() async {
    try {
      await ref
          .read(loginProvider.notifier)
          .login(
            .new(
              email: _emailController.text,
              password: _passwordController.text,
            ),
          );
      await ref.read(preferencesServiceProvider).saveSignIn(true);
      if (!mounted) return;
      context.goNamed(MainTabPage.name);
    } catch (e) {
      ref.read(snackBarProvider).showSnackbar(e.toString());
    }
  }
}
