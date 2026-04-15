import '../../export_all.dart';

class EditProfileView extends ConsumerStatefulWidget {
  const EditProfileView({super.key});

  @override
  ConsumerState<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends ConsumerState<EditProfileView> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _mobileController = TextEditingController();
  final _addressController = TextEditingController();

  DateTime? _dateOfBirth;
  static const int _addressMaxLength = 200;

  CountryCode _selectedCountry = defaultCountryCodes.first;
  bool _isSubmitting = false;
  bool _showDobError = false;
  bool _hydrated = false;
  bool _hydratedFromAuthFallback = false;
  String? _hydratedUid;
  ProviderSubscription<AsyncValue<UserProfile?>>? _profileSub;

  @override
  void initState() {
    super.initState();
    // Hydrate immediately from FirebaseAuth so fields show even before Firestore loads.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _maybeHydrate(null);
      setState(() {});
    });

    // Listen to Firestore-backed profile changes and hydrate when data arrives.
    // Use listenManual here (ref.listen is only allowed in build()).
    _profileSub = ref.listenManual<AsyncValue<UserProfile?>>(
      currentUserProfileProvider,
      (previous, next) {
        next.whenOrNull(data: (p) => _maybeHydrate(p));
      },
    );

    // Also fetch once directly (helps when stream hasn't emitted yet).
    Future.microtask(() async {
      final p = await FirebaseAuthService.instance.fetchCurrentUserProfile();
      if (!mounted) return;
      _maybeHydrate(p);
    });
  }

  void _maybeHydrate(UserProfile? p) {
    final uid = FirebaseAuthService.instance.currentUser?.uid;
    final authName = FirebaseAuthService.instance.currentUserDisplayName ?? '';
    final authEmail = FirebaseAuthService.instance.currentUserEmail ?? '';

    // If user changed (logout/login), allow hydration again.
    if (_hydratedUid != uid) {
      _hydratedUid = uid;
      _hydrated = false;
      _hydratedFromAuthFallback = false;
    }

    final firestoreName = p?.displayName ?? '';
    final firestoreEmail = p?.email ?? '';
    final firestorePhone = p?.phone ?? '';
    final firestoreDial = p?.phoneDialCode ?? '';
    final firestoreAddress = p?.address;
    final firestoreDob = p?.dateOfBirth;

    final hasFirestore = firestoreName.trim().isNotEmpty ||
        firestoreEmail.trim().isNotEmpty ||
        firestorePhone.trim().isNotEmpty ||
        firestoreDial.trim().isNotEmpty ||
        (firestoreAddress != null && firestoreAddress.trim().isNotEmpty) ||
        firestoreDob != null;

    final candidateName = firestoreName.trim().isNotEmpty ? firestoreName : authName;
    final candidateEmail = firestoreEmail.trim().isNotEmpty ? firestoreEmail : authEmail;
    final candidatePhone = firestorePhone.trim().isNotEmpty
        ? firestorePhone
        : _mobileController.text;

    final hasAnyCandidate = candidateName.trim().isNotEmpty ||
        candidateEmail.trim().isNotEmpty ||
        candidatePhone.trim().isNotEmpty ||
        firestoreDial.trim().isNotEmpty ||
        (firestoreAddress != null && firestoreAddress.trim().isNotEmpty) ||
        firestoreDob != null;

    if (!hasAnyCandidate) return;

    // If we hydrated from auth fallback earlier and Firestore arrives later, update once.
    final shouldUpgradeFromFirestore = hasFirestore && _hydratedFromAuthFallback;

    if (_hydrated && !shouldUpgradeFromFirestore) return;

    _nameController.text = candidateName;
    _emailController.text = candidateEmail;
    if (candidatePhone.trim().isNotEmpty) {
      _mobileController.text = candidatePhone;
    }

    bool needsRebuild = false;
    if (firestoreAddress != null && firestoreAddress.trim().isNotEmpty) {
      _addressController.text = firestoreAddress;
    }
    if (firestoreDob != null) {
      if (_dateOfBirth != firestoreDob) {
        _dateOfBirth = firestoreDob;
        needsRebuild = true; // DOB text is derived from state, needs rebuild.
      }
    }

    final dialToUse =
        firestoreDial.trim().isNotEmpty ? firestoreDial : _selectedCountry.dialCode;
    final nextCountry = defaultCountryCodes.firstWhere(
      (c) => c.dialCode == dialToUse,
      orElse: () => defaultCountryCodes.first,
    );
    if (nextCountry.dialCode != _selectedCountry.dialCode) {
      _selectedCountry = nextCountry;
      needsRebuild = true; // CountryPhoneFieldWidget updates via widget rebuild.
    }

    _hydrated = true;
    _hydratedFromAuthFallback = !hasFirestore;

    // When Firestore profile arrives, force one rebuild to refresh derived UI
    // (DOB text + country code widget state).
    if ((needsRebuild || hasFirestore) && mounted) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) setState(() {});
      });
    }
  }

  @override
  void dispose() {
    _profileSub?.close();
    _nameController.dispose();
    _emailController.dispose();
    _mobileController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final firstDate = DateTime(1900, 1, 1);
    final lastDate = DateTime(now.year, now.month, now.day);
    final initial = _dateOfBirth ?? DateTime(2000, 1, 15);
    final initialDate = initial.isAfter(lastDate)
        ? lastDate
        : (initial.isBefore(firstDate) ? firstDate : initial);

    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
      selectableDayPredicate: (d) => !d.isAfter(lastDate),
    );
    if (picked != null) {
      setState(() {
        _dateOfBirth = picked;
        _showDobError = false;
      });
    }
  }

  Future<void> _onUpdate() async {
    if (_isSubmitting) return;
    if (!_formKey.currentState!.validate()) return;
    if (_dateOfBirth == null) {
      setState(() => _showDobError = true);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select date of birth')),
      );
      return;
    }

    setState(() => _isSubmitting = true);
    try {
      await FirebaseAuthService.instance.updateCurrentUserProfile(
        displayName: _nameController.text,
        phone: _mobileController.text,
        phoneDialCode: _selectedCountry.dialCode,
        address: _addressController.text,
        dateOfBirth: _dateOfBirth,
      );
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated')),
      );
      AppRouter.back();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(FirebaseAuthService.messageForAuthException(e))),
      );
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(currentUserProfileProvider);

    return CustomInnerScreenTemplate(
      title: 'Edit Profile',
      child: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          children: [
          CustomTextFieldWidget(
            controller: _nameController,
            label: 'Name',
            hint: 'John Doe',
            prefixIcon: Padding(
              padding: const EdgeInsets.only(left: 20, right: 12),
              child: Image.asset(Assets.userIcon, width: 22, height: 22),
            ),
            prefixIconConstraints: const BoxConstraints(minWidth: 54, minHeight: 26),
            validator: (v) {
              if (v == null || v.trim().isEmpty) return 'Name is required';
              return null;
            },
          ),
          20.ph,
          CustomTextFieldWidget(
            controller: _emailController,
            label: 'Email',
            hint: 'user@gmail.com',
            keyboardType: TextInputType.emailAddress,
            readOnly: true,
            enabled: false,
            prefixIcon: Padding(
              padding: const EdgeInsets.only(left: 20, right: 12),
              child: Image.asset(Assets.emailIcon, width: 22, height: 22),
            ),
            prefixIconConstraints: const BoxConstraints(minWidth: 54, minHeight: 26),
          ),
          20.ph,
          _buildDateOfBirthField(),
          20.ph,
          CountryPhoneFieldWidget(
            controller: _mobileController,
            initialCountry: _selectedCountry,
            onCountryChanged: (c) => setState(() => _selectedCountry = c),
            label: 'Mobile Number',
            hint: '898*******',
            validator: (v) {
              if (v == null || v.trim().isEmpty) {
                return 'Mobile number is required';
              }
              return null;
            },
          ),
          20.ph,
          CustomTextFieldWidget(
            controller: _addressController,
            label: 'Address',
            hint: 'Enter address',
            padding: const EdgeInsets.all(20),
            maxLines: 6,
            minLines: 5,
            maxLength: _addressMaxLength,
          ),
          // 6.ph,
          // _buildAddressCounter(),
          32.ph,
          CustomButtonWidget(
            label: 'Update',
            onPressed: _onUpdate,
            height: 52,
            loading: _isSubmitting,
          ),
          40.ph,
          ],
        ),
      ),
    );
  }

  Widget _buildDateOfBirthField() {
    final labelStyle = context.robotoFlexRegular(fontSize: 17, color: Colors.black);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Date of Birth', style: labelStyle),
        8.ph,
        InkWell(
          onTap: _pickDate,
          borderRadius: BorderRadius.circular(29),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            decoration: BoxDecoration(
              border: Border.all(
                color: _showDobError ? Theme.of(context).colorScheme.error : const Color(0xFF393939),
              ),
              borderRadius: BorderRadius.circular(29),
            ),
            child: Row(
              children: [
                Image.asset(Assets.dateIcon, width: 22, height: 22),
                12.pw,
                Text(
                  _dateOfBirth != null
                      ? '${_dateOfBirth!.day.toString().padLeft(2, '0')}/${_dateOfBirth!.month.toString().padLeft(2, '0')}/${_dateOfBirth!.year}'
                      : 'Select date',
                  style: context.robotoFlexRegular(
                    fontSize: 14.87,
                    color: _dateOfBirth != null
                        ? AppColors.primaryTextColor
                        : Colors.black.withValues(alpha: 0.3),
                  ),
                ),
                // const Spacer(),
                // Icon(
                //   Icons.calendar_today_outlined,
                //   size: 20,
                //   color: Colors.black.withValues(alpha: 0.4),
                // ),
              ],
            ),
          ),
        ),
        if (_showDobError) ...[
          6.ph,
          Text(
            'Date of birth is required',
            style: TextStyle(
              color: Theme.of(context).colorScheme.error,
              fontSize: 11,
              fontFamily: 'Roboto Flex',
            ),
          ),
        ],
      ],
    );
  }

  // ignore: unused_element
  Widget _buildAddressCounter() {
    return ListenableBuilder(
      listenable: _addressController,
      builder: (context, _) {
        return Align(
          alignment: Alignment.centerLeft,
          child: Text(
            '${_addressController.text.length}/$_addressMaxLength',
            style: context.robotoFlexRegular(
              fontSize: 12,
              color: AppColors.primaryTextColor.withValues(alpha: 0.6),
            ),
          ),
        );
      },
    );
  }
}
