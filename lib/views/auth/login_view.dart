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
  bool _isSubmitting = false;
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
    setState(() => _isSubmitting = true);
    try {
      await FirebaseAuthService.instance.signIn(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );
      await FirebaseAuthService.instance.reloadCurrentUser();
      if (!mounted) return;

      if (!FirebaseAuthService.instance.isEmailVerified) {
        AppRouter.pushAndRemoveUntil(const EmailVerificationView());
        return;
      }

      final role = await FirebaseAuthService.instance.fetchRoleForCurrentUser();
      if (!mounted) return;
      if (role == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Your profile is incomplete. Please register again or contact support.',
            ),
          ),
        );
        await FirebaseAuthService.instance.signOut();
        return;
      }
      if (role != _selectedUserRole) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid credentials')),
        );
        await FirebaseAuthService.instance.signOut();
        return;
      }
      await FirebaseAuthService.instance.recordSuccessfulLogin(_selectedUserRole);
      navigateToDashboardForRole(role);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(FirebaseAuthService.messageForAuthException(e)),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
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
                _buildRoleDropdown(context),
                24.ph,
                CustomButtonWidget(
                  label: context.tr('login'),
                  onPressed: _onSubmit,
                  loading: _isSubmitting,
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

  Widget _buildRoleDropdown(BuildContext context) {
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
              onChanged: _isSubmitting
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
