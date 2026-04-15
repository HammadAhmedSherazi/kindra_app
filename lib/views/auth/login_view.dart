import '../../export_all.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});

  @override
  ConsumerState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  LoginUserRole _selectedUserRole = LoginUserRole.householder;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _onSubmit() async {
    if (!_formKey.currentState!.validate()) return;
    final role = await ref.read(authProvider.notifier).login(
          email: _emailController.text.trim(),
          password: _passwordController.text,
          selectedRole: _selectedUserRole,
        );
    if (!mounted) return;

    final authState = ref.read(authProvider);
    if (authState.needsEmailVerification) {
      // Keep previous screen in stack so Back works.
      AppRouter.push(const EmailVerificationView());
      return;
    }

    if (role != null) {
      navigateToDashboardForRole(role);
      return;
    }

    // Errors are shown via ref.listen in build().
  }

  @override
  Widget build(BuildContext context) {
    final isSubmitting =
        ref.watch(authProvider.select((s) => s.isLoggingIn));

    ref.listen<String?>(
      authProvider.select((s) => s.errorMessage),
      (previous, next) {
        if (next == null || next.trim().isEmpty) return;
        if (previous == next) return;
        final ctx = AppRouter.navKey.currentContext;
        if (ctx != null) {
          Helper.showMessage(
            ctx,
            message: next,
            backgroundColor: Colors.red,
          );
        }
        ref.read(authProvider.notifier).clearError();
      },
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 12),
          child: BackButtonWidget(
            onPressed: () =>
                AppRouter.pushAndRemoveUntil(const OnboardingView()),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      Assets.kindraTextLogo,
                      width: 160,
                      height: 67,
                      fit: BoxFit.contain,
                    ),
                  ],
                ),
                57.ph,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Explore Kindra',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 27.49,
                        fontFamily: 'Roboto Flex',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Enter your email & password',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 19,
                        fontFamily: 'Roboto Flex',
                        fontWeight: FontWeight.w300,
                        height: 1.08,
                      ),
                    ),
                  ],
                ),
                32.ph,
                CustomTextFieldWidget(
                  controller: _emailController,
                  label: context.tr('email'),
                  prefixIconConstraints: BoxConstraints(
                    minWidth: 26,
                    minHeight: 26,
                  ),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 10),
                    child: Image.asset(
                      Assets.emailIcon,
                      width: 26,
                      height: 26,
                      color: Colors.black.withValues(alpha: 0.3),
                    ),
                  ),

                  hint: 'email@example.com',
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) {
                      return 'Email is required';
                    }
                    return null;
                  },
                ),
                30.ph,
                CustomTextFieldWidget(
                  controller: _passwordController,
                  label: context.tr('password'),
                  hint: 'Enter your password',
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 10),
                    child: Image.asset(
                      Assets.passwordIcon,
                      width: 26,
                      height: 26,
                      color: Colors.black.withValues(alpha: 0.3),
                    ),
                  ),
                  obscureText: _obscurePassword,
                  textInputAction: TextInputAction.done,
                  validator: (v) {
                    if (v == null || v.isEmpty) return 'Password is required';
                    return null;
                  },
                  suffixIcon: InkWell(
                    onTap: () =>
                        setState(() => _obscurePassword = !_obscurePassword),
                    borderRadius: BorderRadius.circular(999),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20, left: 10),
                      child: Image.asset(
                        Assets.eyeIcon,
                        width: 26,
                        height: 26,
                        color: Colors.black.withValues(alpha: 0.3),
                      ),
                    ),
                  ),
                ),
                12.ph,
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => AppRouter.push(const ResetPasswordView()),
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.primaryColor,
                      padding: EdgeInsets.zero,
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Text(
                      'Forget password?',
                      style: TextStyle(
                        color: Colors.black.withValues(alpha: 0.66),
                        fontSize: 14.87,
                        fontFamily: 'Roboto Flex',
                        fontWeight: FontWeight.w300,
                        height: 1.08,
                      ),
                    ),
                  ),
                ),
                24.ph,
                _buildRoleDropdown(context, isSubmitting: isSubmitting),
                24.ph,
                CustomButtonWidget(
                  label: context.tr('login'),
                  onPressed: _onSubmit,
                  loading: isSubmitting,
                ),
                50.ph,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text.rich(
                        textAlign: TextAlign.center,
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'Don`t have an account? ',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 19,
                                fontFamily: 'Roboto Flex',
                                fontWeight: FontWeight.w300,
                                height: 1.08,
                              ),
                            ),
                            WidgetSpan(
                              alignment: PlaceholderAlignment.baseline,
                              baseline: TextBaseline.alphabetic,
                              child: GestureDetector(
                                onTap: () =>
                                    AppRouter.push(const RegistrationView()),
                                child: Text(
                                  'Register here',
                                  style: TextStyle(
                                    color: const Color(0xFFDB932C),
                                    fontSize: 19,
                                    fontFamily: 'Roboto Flex',
                                    fontWeight: FontWeight.w600,
                                    height: 1.08,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                32.ph,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRoleDropdown(BuildContext context, {required bool isSubmitting}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Select User',
          style: context.robotoFlexRegular(fontSize: 17, color: Colors.black),
        ),
        8.ph,
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(29),
            border: Border.all(width: 1, color: const Color(0xFF393939)),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<LoginUserRole>(
              value: _selectedUserRole,
              isExpanded: true,
              icon: Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.black.withValues(alpha: 0.5),
                ),
              ),
              style: TextStyle(
                color: Colors.black,
                fontSize: 14.87,
                fontFamily: 'Roboto Flex',
                fontWeight: FontWeight.w300,
                height: 1.08,
              ),
              items: LoginUserRole.values
                  .map(
                    (role) => DropdownMenuItem<LoginUserRole>(
                      value: role,
                      child: Text(role.displayName),
                    ),
                  )
                  .toList(),
              onChanged: isSubmitting
                  ? null
                  : (LoginUserRole? value) {
                      if (value != null) {
                        setState(() => _selectedUserRole = value);
                      }
                    },
            ),
          ),
        ),
      ],
    );
  }
}
