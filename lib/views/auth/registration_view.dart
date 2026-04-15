import '../../export_all.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

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

  CountryCode _selectedCountry = defaultCountryCodes.first;
  LoginUserRole _selectedUserRole = LoginUserRole.householder;
  // Loading is driven by authProvider state (MVVM-ish).
  bool _obscurePassword = true;
  final ImagePicker _imagePicker = ImagePicker();
  XFile? _profileImage;

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
    final ok = await ref.read(authProvider.notifier).signUp(
          email: _emailController.text.trim(),
          password: _passwordController.text,
          displayName: _firstNameController.text.trim(),
          phone: _mobileController.text.trim(),
          phoneDialCode: _selectedCountry.dialCode,
          role: _selectedUserRole,
          profileImagePath: _profileImage?.path,
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

  Future<void> _pickFromGallery() async {
    try {
      final file = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );
      if (file == null) return;
      if (!mounted) return;
      setState(() => _profileImage = file);
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not open gallery.')),
      );
    }
  }

  Future<void> _captureFromCamera() async {
    try {
      final file = await _imagePicker.pickImage(
        source: ImageSource.camera,
        imageQuality: 80,
      );
      if (file == null) return;
      if (!mounted) return;
      setState(() => _profileImage = file);
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not open camera.')),
      );
    }
  }

  void _removePhoto() => setState(() => _profileImage = null);

  Future<void> _showPhotoPickerSheet() async {
    final isSubmitting = ref.read(authProvider).isSigningUp;
    if (isSubmitting) return;
    await showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(top: 8, bottom: 12),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.photo_library_outlined),
                  title: const Text('Choose from gallery'),
                  onTap: () async {
                    Navigator.of(context).pop();
                    await _pickFromGallery();
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.photo_camera_outlined),
                  title: const Text('Take a photo'),
                  onTap: () async {
                    Navigator.of(context).pop();
                    await _captureFromCamera();
                  },
                ),
                if (_profileImage != null)
                  ListTile(
                    leading: Icon(
                      Icons.delete_outline,
                      color: Colors.red.withValues(alpha: 0.85),
                    ),
                    title: Text(
                      'Remove photo',
                      style: TextStyle(
                        color: Colors.red.withValues(alpha: 0.85),
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                      _removePhoto();
                    },
                  ),
                12.ph,
              ],
            ),
          ),
        );
      },
    );
  }

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
                _buildProfilePhotoPicker(),
                24.ph,
                CustomTextFieldWidget(
                  controller: _firstNameController,
                  label: 'Name',
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
                  hint: 'Enter your name',
                  textInputAction: TextInputAction.next,
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) {
                      return 'Name is required';
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
                24.ph,
                _buildRoleDropdown(context),
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
                  setState(() => _selectedUserRole = value);
                }
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProfilePhotoPicker() {
    final file = _profileImage;
    final hasPicked = file != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 96,
              height: 96,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black.withValues(alpha: 0.06),
                image: DecorationImage(
                  image: hasPicked
                      ? FileImage(File(file.path))
                      : const AssetImage(Assets.userAvatar),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Material(
                color: Colors.white,
                shape: const CircleBorder(),
                elevation: 2,
                child: InkWell(
                  customBorder: const CircleBorder(),
                  onTap: _showPhotoPickerSheet,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Icon(
                      Icons.camera_alt_outlined,
                      size: 20,
                      color: Colors.black.withValues(alpha: 0.75),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
