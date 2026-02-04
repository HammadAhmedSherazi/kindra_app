import '../../export_all.dart';

class CountryCode {
  const CountryCode({
    required this.code,
    required this.dialCode,
    required this.flag,
  });
  final String code;
  final String dialCode;
  final String flag;
}

const List<CountryCode> _countryCodes = [
  CountryCode(code: 'PK', dialCode: '+92', flag: '🇵🇰'),
  CountryCode(code: 'US', dialCode: '+1', flag: '🇺🇸'),
  CountryCode(code: 'GB', dialCode: '+44', flag: '🇬🇧'),
  CountryCode(code: 'IN', dialCode: '+91', flag: '🇮🇳'),
  CountryCode(code: 'AE', dialCode: '+971', flag: '🇦🇪'),
  CountryCode(code: 'SA', dialCode: '+966', flag: '🇸🇦'),
  CountryCode(code: 'CA', dialCode: '+1', flag: '🇨🇦'),
  CountryCode(code: 'AU', dialCode: '+61', flag: '🇦🇺'),
];

class RegistrationView extends ConsumerStatefulWidget {
  const RegistrationView({super.key});

  @override
  ConsumerState<RegistrationView> createState() => _RegistrationViewState();
}

class _RegistrationViewState extends ConsumerState<RegistrationView> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _mobileController = TextEditingController();

  CountryCode _selectedCountry = _countryCodes.first;

  @override
  void dispose() {
    _firstNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _mobileController.dispose();
    super.dispose();
  }

  Future<void> _onSubmit() async {
    if (!_formKey.currentState!.validate()) return;
    // TODO: call registration API
    if (!mounted) return;
    AppRouter.pushAndRemoveUntil(const NavigationView());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
      
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        leadingWidth: 56,
        leading: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 12),
            child: BackButtonWidget(
              onPressed: () => AppRouter.back(),
            ),
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
                      'Join with Kindra',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 29.49,
                        fontFamily: 'Roboto Flex',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          'Sign up now & start your journey to make world Greener',
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
                  controller: _firstNameController,
                  label: 'First Name',
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 10),
                    child: Image.asset(
                      Assets.userIcon,
                      width: 26,
                      height: 26,
                      color: Colors.black.withValues(alpha: 0.3),
                    ),
                  ),
                  prefixIconConstraints: const BoxConstraints(
                    minWidth: 26,
                    minHeight: 26,
                  ),
                  hint: 'Enter your first name',
                  textInputAction: TextInputAction.next,
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) {
                      return 'First name is required';
                    }
                    return null;
                  },
                ),
                30.ph,
                CustomTextFieldWidget(
                  controller: _emailController,
                  label: context.tr('email'),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 10),
                    child: Image.asset(
                      Assets.emailIcon,
                      width: 26,
                      height: 26,
                      color: Colors.black.withValues(alpha: 0.3),
                    ),
                  ),
                  prefixIconConstraints: const BoxConstraints(
                    minWidth: 26,
                    minHeight: 26,
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
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 10),
                    child: Image.asset(
                      Assets.passwordIcon,
                      width: 26,
                      height: 26,
                      color: Colors.black.withValues(alpha: 0.3),
                    ),
                  ),
                  obscureText: true,
                  hint: 'Enter your password',
                  textInputAction: TextInputAction.next,
                  validator: (v) {
                    if (v == null || v.isEmpty) return 'Password is required';
                    if (v.length < 6)
                      return 'Password must be at least 6 characters';
                    return null;
                  },
                  suffixIcon: Padding(
                    padding: const EdgeInsets.only(right: 20, left: 10),
                    child: Image.asset(
                      Assets.eyeIcon,
                      width: 26,
                      height: 26,
                      color: Colors.black.withValues(alpha: 0.3),
                    ),
                  ),
                ),
                30.ph,
                _buildMobileField(),
                32.ph,
                CustomButtonWidget(label: 'Registration', onPressed: _onSubmit),
                24.ph,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      
                      child: Text.rich(
                        textAlign: TextAlign.center,
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'Already have an account? ',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontFamily: 'Roboto Flex',
                                fontWeight: FontWeight.w300,
                                height: 1.08,
                              ),
                            ),
                            WidgetSpan(
                              alignment: PlaceholderAlignment.baseline,
                              baseline: TextBaseline.alphabetic,
                              child: GestureDetector(
                                onTap: () => AppRouter.back(),
                                child: Text(
                                  'Login here',
                                  style: TextStyle(
                                    color: const Color(0xFFDB932C),
                                    fontSize: 20,
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

  Widget _buildMobileField() {
    return CustomTextFieldWidget(
      controller: _mobileController,
      label: 'Mobile Number',
      hint: 'Enter number',
      keyboardType: TextInputType.phone,
      textInputAction: TextInputAction.done,
      prefixIconConstraints: const BoxConstraints(minWidth: 100, minHeight: 26),
      prefixIcon: Padding(
        padding: const EdgeInsets.only(left: 20, right: 8),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<CountryCode>(
            value: _selectedCountry,
            isExpanded: false,
            icon: const Icon(Icons.keyboard_arrow_down, size: 24),
            items: _countryCodes
                .map(
                  (c) => DropdownMenuItem<CountryCode>(
                    value: c,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(c.flag, style: const TextStyle(fontSize: 20)),
                        6.pw,
                        Text(
                          c.dialCode,
                          style: TextStyle(
                            fontSize: 15.87,
                            fontFamily: 'Roboto Flex',
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
            onChanged: (v) {
              if (v != null) setState(() => _selectedCountry = v);
            },
          ),
        ),
      ),
      validator: (v) {
        if (v == null || v.trim().isEmpty) {
          return 'Mobile number is required';
        }
        return null;
      },
    );
  }
}
