import '../../export_all.dart';

/// Bottom sheet modal for Credit flow - enter mobile number to check E-Wallet.
class CreditCheckModal extends StatelessWidget {
  const CreditCheckModal({super.key, required this.onCheckEWallet});

  final void Function(String countryCode, String phone) onCheckEWallet;

  static Future<void> show(
    BuildContext context, {
    required void Function(String countryCode, String phone) onCheckEWallet,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => CreditCheckModal(onCheckEWallet: onCheckEWallet),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _CreditCheckModalContent(onCheckEWallet: onCheckEWallet);
  }
}

class _CreditCheckModalContent extends StatefulWidget {
  const _CreditCheckModalContent({required this.onCheckEWallet});

  final void Function(String countryCode, String phone) onCheckEWallet;

  @override
  State<_CreditCheckModalContent> createState() =>
      _CreditCheckModalContentState();
}

class _CreditCheckModalContentState extends State<_CreditCheckModalContent> {
  final _phoneController = TextEditingController();
  late CountryCode _selectedCountry;

  @override
  void initState() {
    super.initState();
    _selectedCountry = defaultCountryCodes.firstWhere(
      (c) => c.code == 'ID',
      orElse: () => defaultCountryCodes.first,
    );
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;
    final height = MediaQuery.sizeOf(context).height * 0.4 + bottomInset;

    return Container(
      height: height,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          12.ph,
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          20.ph,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundColor: AppColors.primaryColor,
                  child: Image.asset(
                    Assets.cardIcon,
                    width: 22,
                    height: 22,
                  ),
                ),
                10.pw,
                Text(
                  'Credit',
                  style: context.robotoFlexSemiBold(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.close,
                      size: 20,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 18,
            ),
            child:  Divider(
              color: Colors.grey.shade300,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CountryPhoneFieldWidget(
                    controller: _phoneController,
                    initialCountry: _selectedCountry,
                    onCountryChanged: (c) =>
                        setState(() => _selectedCountry = c),
                    label: 'Mobile Number',
                    hint: '898*******',
                  ),
                  24.ph,
                  CustomButtonWidget(
                    label: 'Check E-Wallet',
                    onPressed: () {
                      Navigator.of(context).pop();
                      widget.onCheckEWallet(
                        _selectedCountry.dialCode,
                        _phoneController.text.trim(),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
