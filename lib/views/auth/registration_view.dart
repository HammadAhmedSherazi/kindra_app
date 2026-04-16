import '../../export_all.dart';
import 'package:image_picker/image_picker.dart';

class RegistrationView extends ConsumerStatefulWidget {
  const RegistrationView({super.key});

  @override
  ConsumerState<RegistrationView> createState() => _RegistrationViewState();
}

class _RegistrationViewState extends ConsumerState<RegistrationView> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _groupNameController = TextEditingController();
  final _vehicleRegController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _mobileController = TextEditingController();

  CountryCode _selectedCountry = defaultCountryCodes.first;
  LoginUserRole _selectedUserRole = LoginUserRole.householder;
  String? _selectedBusinessCategory;
  // Loading is driven by authProvider state (MVVM-ish).
  bool _obscurePassword = true;
  XFile? _profileImage;

  @override
  void dispose() {
    _nameController.dispose();
    _groupNameController.dispose();
    _vehicleRegController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _mobileController.dispose();
    super.dispose();
  }

  String _nameFieldLabel(LoginUserRole role) {
    switch (role) {
      case LoginUserRole.businesses:
        return 'Business name';
      case LoginUserRole.coastalGroups:
        return 'Your name';
      case LoginUserRole.drivers:
        return 'Full name';
      default:
        return 'Name';
    }
  }

  String _nameFieldHint(LoginUserRole role) {
    switch (role) {
      case LoginUserRole.businesses:
        return 'Enter business name';
      case LoginUserRole.coastalGroups:
        return 'Enter your name';
      case LoginUserRole.drivers:
        return 'Enter your full name';
      default:
        return 'Enter your name';
    }
  }

  Future<void> _onSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    final role = _selectedUserRole;
    final name = _nameController.text.trim();

    if (role == LoginUserRole.businesses &&
        (_selectedBusinessCategory == null ||
            _selectedBusinessCategory!.trim().isEmpty)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a business category')),
      );
      return;
    }
    if (role == LoginUserRole.coastalGroups &&
        _groupNameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Group name is required')),
      );
      return;
    }
    if (role == LoginUserRole.drivers &&
        _vehicleRegController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Vehicle registration number is required'),
        ),
      );
      return;
    }

    final ok = await ref.read(authProvider.notifier).signUp(
          email: _emailController.text.trim(),
          password: _passwordController.text,
          displayName: name,
          phone: _mobileController.text.trim(),
          phoneDialCode: _selectedCountry.dialCode,
          role: role,
          profileImagePath: _profileImage?.path,
          businessCategory: role == LoginUserRole.businesses
              ? _selectedBusinessCategory?.trim()
              : null,
          groupName: role == LoginUserRole.coastalGroups
              ? _groupNameController.text.trim()
              : null,
          vehicleRegistration: role == LoginUserRole.drivers
              ? _vehicleRegController.text.trim()
              : null,
        );
    if (!mounted) return;
    if (ok) {
      // Navigate immediately (uses global navigatorKey via AppRouter).
      await Future<void>.delayed(Duration.zero);
      if (!mounted) return;
      // Keep registration in stack so Back works.
      AppRouter.push(const EmailVerificationView());
      return;
    }
    final err = ref.read(authProvider).errorMessage;
    if (err != null && err.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(err)));
      ref.read(authProvider.notifier).clearError();
    }
  }

  void _onPhotoChanged(XFile? f) => setState(() => _profileImage = f);

  @override
  Widget build(BuildContext context) {
    final isSubmitting =
        ref.watch(authProvider.select((s) => s.isSigningUp));
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
            child: BackButtonWidget(onPressed: () => AppRouter.back()),
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
                        fontSize: 27.49,
                        fontFamily: 'Roboto Flex',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          'Sign up now & start your journey to make world Greener',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
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
                ProfilePhotoPicker(
                  localImage: _profileImage,
                  enabled: !isSubmitting,
                  onChanged: _onPhotoChanged,
                ),
                24.ph,
                _buildRoleDropdown(context),
                30.ph,
                CustomTextFieldWidget(
                  controller: _nameController,
                  label: _nameFieldLabel(_selectedUserRole),
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
                  hint: _nameFieldHint(_selectedUserRole),
                  textInputAction: TextInputAction.next,
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) {
                      return _selectedUserRole == LoginUserRole.businesses
                          ? 'Business name is required'
                          : 'Name is required';
                    }
                    return null;
                  },
                ),
                if (_selectedUserRole == LoginUserRole.businesses) ...[
                  24.ph,
                  _buildBusinessCategoryDropdown(context),
                ],
                if (_selectedUserRole == LoginUserRole.coastalGroups) ...[
                  24.ph,
                  CustomTextFieldWidget(
                    controller: _groupNameController,
                    label: 'Group name',
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
                    hint: 'Enter coastal group name',
                    textInputAction: TextInputAction.next,
                    validator: (v) {
                      if (_selectedUserRole != LoginUserRole.coastalGroups) {
                        return null;
                      }
                      if (v == null || v.trim().isEmpty) {
                        return 'Group name is required';
                      }
                      return null;
                    },
                  ),
                ],
                if (_selectedUserRole == LoginUserRole.drivers) ...[
                  24.ph,
                  CustomTextFieldWidget(
                    controller: _vehicleRegController,
                    label: 'Vehicle registration number',
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(left: 20, right: 10),
                      child: Image.asset(
                        Assets.passwordIcon,
                        width: 26,
                        height: 26,
                        color: Colors.black.withValues(alpha: 0.3),
                      ),
                    ),
                    prefixIconConstraints: const BoxConstraints(
                      minWidth: 26,
                      minHeight: 26,
                    ),
                    hint: 'e.g. plate or registration ID',
                    textInputAction: TextInputAction.next,
                    validator: (v) {
                      if (_selectedUserRole != LoginUserRole.drivers) {
                        return null;
                      }
                      if (v == null || v.trim().isEmpty) {
                        return 'Vehicle registration is required';
                      }
                      return null;
                    },
                  ),
                ],
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
                  obscureText: _obscurePassword,
                  hint: 'Enter your password',
                  textInputAction: TextInputAction.next,
                  validator: (v) {
                    if (v == null || v.isEmpty) return 'Password is required';
                    if (v.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
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
                30.ph,
                CountryPhoneFieldWidget(
                  controller: _mobileController,
                  initialCountry: _selectedCountry,
                  onCountryChanged: (c) => setState(() => _selectedCountry = c),
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) {
                      return 'Mobile number is required';
                    }
                    return null;
                  },
                ),
                32.ph,
                CustomButtonWidget(
                  label: 'Registration',
                  onPressed: _onSubmit,
                  loading: isSubmitting,
                ),
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
                                onTap: () => AppRouter.back(),
                                child: Text(
                                  'Login here',
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
          'Select your role',
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
              onChanged: (LoginUserRole? value) {
                if (value != null) {
                  setState(() {
                    _selectedUserRole = value;
                    if (value != LoginUserRole.businesses) {
                      _selectedBusinessCategory = null;
                    }
                  });
                }
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBusinessCategoryDropdown(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Business category',
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
            child: DropdownButton<String>(
              value: _selectedBusinessCategory,
              isExpanded: true,
              hint: Text(
                'Select category',
                style: TextStyle(
                  color: Colors.black.withValues(alpha: 0.45),
                  fontSize: 14.87,
                  fontFamily: 'Roboto Flex',
                  fontWeight: FontWeight.w300,
                ),
              ),
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
              items: kBusinessSignupCategories
                  .map(
                    (c) => DropdownMenuItem<String>(
                      value: c,
                      child: Text(c),
                    ),
                  )
                  .toList(),
              onChanged: (String? value) {
                setState(() => _selectedBusinessCategory = value);
              },
            ),
          ),
        ),
      ],
    );
  }

}
