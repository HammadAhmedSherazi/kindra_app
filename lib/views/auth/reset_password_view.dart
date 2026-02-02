import '../../export_all.dart';

class ResetPasswordView extends ConsumerStatefulWidget {
  const ResetPasswordView({super.key});

  @override
  ConsumerState<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends ConsumerState<ResetPasswordView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _onSubmit() async {
    if (!_formKey.currentState!.validate()) return;
    // TODO: call API to send OTP to email
    if (!mounted) return;
    final email = _emailController.text.trim();
    AppRouter.push(OtpVerificationView(email: email));
  }

  void _onSkip() {
    AppRouter.back();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF5F5F5),
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 12),
          child: BackButtonWidget(onPressed: () => AppRouter.back()),
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
                50.ph,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      Assets.logo,
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
                      'Reset your password',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 29.49,
                        fontFamily: 'Roboto Flex',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                12.ph,
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          'Please enter your email to get an OTP code to reset your password',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontFamily: 'Roboto Flex',
                            fontWeight: FontWeight.w300,
                            height: 1.49,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                32.ph,
                CustomTextFieldWidget(
                  controller: _emailController,
                  label: context.tr('email'),
                  prefixIconConstraints: const BoxConstraints(
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
                  hint: 'user@gmail.com',
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.done,
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) {
                      return 'Email is required';
                    }
                    return null;
                  },
                ),
                32.ph,
                CustomButtonWidget(label: 'Get Started', onPressed: _onSubmit),
              
              ],
            ),
          ),
        ),
      ),
    );
  }
}
