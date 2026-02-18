import '../../export_all.dart';

/// Edit Business Profile form: Business Name, Email, Address, Mobile, Category.
class BusinessEditProfileView extends StatefulWidget {
  const BusinessEditProfileView({super.key});

  @override
  State<BusinessEditProfileView> createState() => _BusinessEditProfileViewState();
}

class _BusinessEditProfileViewState extends State<BusinessEditProfileView> {
  final _businessNameController = TextEditingController(text: 'Greentree Cafe');
  final _emailController = TextEditingController(text: 'info@greentreecafe.com');
  final _addressController = TextEditingController(
    text: '123 Green St, Springfield, It',
  );
  final _mobileController = TextEditingController(text: '898*******');
  final _categoryController = TextEditingController(text: 'Restaurant');

  @override
  void dispose() {
    _businessNameController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _mobileController.dispose();
    _categoryController.dispose();
    super.dispose();
  }

  void _onUpdate() {
    // TODO: call API to update business profile
    if (!mounted) return;
    showProfileUpdateSuccessDialog(context, onContinue: () => AppRouter.back());
  }

  @override
  Widget build(BuildContext context) {
    return CustomInnerScreenTemplate(
      title: 'Edit Profile',
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        children: [
          _buildFormCard(context),
        ],
      ),
    );
  }

  Widget _buildFormCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xffD9D9D9)),
        borderRadius: BorderRadius.circular(23),
       
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomTextFieldWidget(
            controller: _businessNameController,
            label: 'Business Name',
            hint: 'Greentree Cafe',
            prefixIcon: Padding(
              padding: const EdgeInsets.only(left: 20, right: 12),
              child: Icon(Icons.storefront_outlined, size: 22, color: Colors.grey.shade700),
            ),
            prefixIconConstraints: const BoxConstraints(minWidth: 54, minHeight: 26),
          ),
          20.ph,
          CustomTextFieldWidget(
            controller: _emailController,
            label: 'Email',
            hint: 'info@greentreecafe.com',
            keyboardType: TextInputType.emailAddress,
            prefixIcon: Padding(
              padding: const EdgeInsets.only(left: 20, right: 12),
              child: Icon(Icons.email_outlined, size: 22, color: Colors.grey.shade700),
            ),
            prefixIconConstraints: const BoxConstraints(minWidth: 54, minHeight: 26),
          ),
          20.ph,
          CustomTextFieldWidget(
            controller: _addressController,
            label: 'Address',
            hint: '123 Green St, Springfield, It',
            prefixIcon: Padding(
              padding: const EdgeInsets.only(left: 20, right: 12),
              child: Icon(Icons.location_on_outlined, size: 22, color: Colors.grey.shade700),
            ),
            prefixIconConstraints: const BoxConstraints(minWidth: 54, minHeight: 26),
          ),
          20.ph,
          CountryPhoneFieldWidget(
            controller: _mobileController,
            initialCountry: defaultCountryCodes
                .firstWhere(
                  (c) => c.dialCode == '+62',
                  orElse: () => defaultCountryCodes.first,
                ),
            label: 'Mobile Number',
            hint: '898*******',
          ),
          20.ph,
          CustomTextFieldWidget(
            controller: _categoryController,
            label: 'Category',
            hint: 'Restaurant',
            prefixIcon: Padding(
              padding: const EdgeInsets.only(left: 20, right: 12),
              child: Icon(Icons.restaurant_outlined, size: 22, color: Colors.grey.shade700),
            ),
            prefixIconConstraints: const BoxConstraints(minWidth: 54, minHeight: 26),
          ),
          32.ph,
          CustomButtonWidget(
            label: 'Update',
            onPressed: _onUpdate,
            height: 52,
          ),
        ],
      ),
    );
  }
}
