import '../../export_all.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  final _nameController = TextEditingController(text: 'John Doe');
  final _emailController = TextEditingController(text: 'user@gmail.com');
  final _mobileController = TextEditingController(text: '898*******');
  final _addressController = TextEditingController();

  DateTime? _dateOfBirth;
  static const int _addressMaxLength = 200;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _mobileController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _dateOfBirth ?? DateTime(2000, 1, 15),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) setState(() => _dateOfBirth = picked);
  }

  void _onUpdate() {
    // TODO: call API to update profile
    AppRouter.back();
  }

  @override
  Widget build(BuildContext context) {
    return CustomInnerScreenTemplate(
      title: 'Edit Profile',
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
          ),
          20.ph,
          CustomTextFieldWidget(
            controller: _emailController,
            label: 'Email',
            hint: 'user@gmail.com',
            keyboardType: TextInputType.emailAddress,
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
            initialCountry: defaultCountryCodes
                .firstWhere((c) => c.dialCode == '+62', orElse: () => defaultCountryCodes.first),
            label: 'Mobile Number',
            hint: '898*******',
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
          ),
          40.ph,
        ],
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
              border: Border.all(color: const Color(0xFF393939)),
              borderRadius: BorderRadius.circular(29),
            ),
            child: Row(
              children: [
                Image.asset(Assets.dateIcon, width: 22, height: 22),
                12.pw,
                Text(
                  _dateOfBirth != null
                      ? '${_dateOfBirth!.day}/${_dateOfBirth!.month}/${_dateOfBirth!.year}'
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
      ],
    );
  }

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
