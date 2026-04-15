import '../../export_all.dart';

class RoleProfileEditView extends ConsumerStatefulWidget {
  const RoleProfileEditView({super.key, required this.role});

  final LoginUserRole role;

  @override
  ConsumerState<RoleProfileEditView> createState() => _RoleProfileEditViewState();
}

class _RoleProfileEditViewState extends ConsumerState<RoleProfileEditView> {
  final _formKey = GlobalKey<FormState>();

  final _householdSizeController = TextEditingController();
  final _communityNameController = TextEditingController();
  final _businessNameController = TextEditingController();
  final _businessCategoryController = TextEditingController();
  final _groupNameController = TextEditingController();
  final _vehicleNumberController = TextEditingController();
  final _licenseNumberController = TextEditingController();

  bool _hydrated = false;

  @override
  void dispose() {
    _householdSizeController.dispose();
    _communityNameController.dispose();
    _businessNameController.dispose();
    _businessCategoryController.dispose();
    _groupNameController.dispose();
    _vehicleNumberController.dispose();
    _licenseNumberController.dispose();
    super.dispose();
  }

  void _hydrate(RoleProfile? p) {
    if (_hydrated) return;
    _hydrated = true;

    switch (widget.role) {
      case LoginUserRole.householder:
        final hp = p is HouseholderProfile ? p : const HouseholderProfile();
        _householdSizeController.text =
            (hp.householdSize?.toString() ?? '');
      case LoginUserRole.communities:
        final cp = p is CommunityProfile ? p : const CommunityProfile();
        _communityNameController.text = cp.communityName ?? '';
      case LoginUserRole.businesses:
        final bp = p is BusinessProfile ? p : const BusinessProfile();
        _businessNameController.text = bp.businessName ?? '';
        _businessCategoryController.text = bp.businessCategory ?? '';
      case LoginUserRole.coastalGroups:
        final gp = p is CoastalGroupProfile ? p : const CoastalGroupProfile();
        _groupNameController.text = gp.groupName ?? '';
      case LoginUserRole.drivers:
        final dp = p is DriverProfile ? p : const DriverProfile();
        _vehicleNumberController.text = dp.vehicleNumber ?? '';
        _licenseNumberController.text = dp.licenseNumber ?? '';
    }
  }

  RoleProfile _buildProfileFromForm() {
    switch (widget.role) {
      case LoginUserRole.householder:
        final parsed = int.tryParse(_householdSizeController.text.trim());
        return HouseholderProfile(householdSize: parsed);
      case LoginUserRole.communities:
        return CommunityProfile(
          communityName: _communityNameController.text.trim(),
        );
      case LoginUserRole.businesses:
        return BusinessProfile(
          businessName: _businessNameController.text.trim(),
          businessCategory: _businessCategoryController.text.trim(),
        );
      case LoginUserRole.coastalGroups:
        return CoastalGroupProfile(groupName: _groupNameController.text.trim());
      case LoginUserRole.drivers:
        return DriverProfile(
          vehicleNumber: _vehicleNumberController.text.trim(),
          licenseNumber: _licenseNumberController.text.trim(),
        );
    }
  }

  Future<void> _onSave() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    final vm = ref.read(userEditViewModelProvider.notifier);
    await vm.saveRoleProfile(_buildProfileFromForm());
    final err = ref.read(userEditViewModelProvider).errorMessage;
    if (!mounted) return;
    if (err != null && err.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(err)));
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Role profile updated')),
    );
    AppRouter.back();
  }

  @override
  Widget build(BuildContext context) {
    final asyncRoleProfile = ref.watch(currentUserRoleProfileProvider(widget.role));
    asyncRoleProfile.whenData(_hydrate);

    final isSaving = ref.watch(userEditViewModelProvider.select((s) => s.isSaving));

    return CustomInnerScreenTemplate(
      title: '${widget.role.displayName} Profile',
      child: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          children: [
            ..._buildFieldsForRole(context),
            28.ph,
            CustomButtonWidget(
              label: 'Save',
              onPressed: isSaving ? null : _onSave,
              loading: isSaving,
              height: 52,
            ),
            24.ph,
          ],
        ),
      ),
    );
  }

  List<Widget> _buildFieldsForRole(BuildContext context) {
    switch (widget.role) {
      case LoginUserRole.householder:
        return [
          CustomTextFieldWidget(
            controller: _householdSizeController,
            label: 'Household size',
            hint: 'e.g. 4',
            keyboardType: TextInputType.number,
          ),
        ];
      case LoginUserRole.communities:
        return [
          CustomTextFieldWidget(
            controller: _communityNameController,
            label: 'Community name',
            hint: 'Enter community name',
            validator: (v) =>
                (v == null || v.trim().isEmpty) ? 'Required' : null,
          ),
        ];
      case LoginUserRole.businesses:
        return [
          CustomTextFieldWidget(
            controller: _businessNameController,
            label: 'Business name',
            hint: 'Enter business name',
            validator: (v) =>
                (v == null || v.trim().isEmpty) ? 'Required' : null,
          ),
          16.ph,
          CustomTextFieldWidget(
            controller: _businessCategoryController,
            label: 'Business category',
            hint: 'e.g. Restaurant',
          ),
        ];
      case LoginUserRole.coastalGroups:
        return [
          CustomTextFieldWidget(
            controller: _groupNameController,
            label: 'Group name',
            hint: 'Enter group name',
            validator: (v) =>
                (v == null || v.trim().isEmpty) ? 'Required' : null,
          ),
        ];
      case LoginUserRole.drivers:
        return [
          CustomTextFieldWidget(
            controller: _vehicleNumberController,
            label: 'Vehicle number',
            hint: 'e.g. MH04 AB 1234',
          ),
          16.ph,
          CustomTextFieldWidget(
            controller: _licenseNumberController,
            label: 'License number',
            hint: 'Enter license number',
          ),
        ];
    }
  }
}

