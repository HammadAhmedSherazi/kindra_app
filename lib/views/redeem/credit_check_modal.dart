import '../../export_all.dart';

/// Bottom sheet modal for Credit flow - enter mobile number to check E-Wallet.
class CreditCheckModal extends StatelessWidget {
  const CreditCheckModal({
    super.key,
    required this.onCheckEWallet,
  });

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
  const _CreditCheckModalContent({
    required this.onCheckEWallet,
  });

  final void Function(String countryCode, String phone) onCheckEWallet;

  @override
  State<_CreditCheckModalContent> createState() =>
      _CreditCheckModalContentState();
}

class _CreditCheckModalContentState extends State<_CreditCheckModalContent> {
  final _phoneController = TextEditingController(text: '898*******');
  String _countryCode = '+62';

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.5,
      minChildSize: 0.4,
      maxChildSize: 0.85,
      builder: (context, scrollController) {
        return Container(
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
              Stack(
                alignment: Alignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        Assets.cardIcon,
                        width: 32,
                        height: 32,
                        color: AppColors.primaryColor,
                      ),
                      8.pw,
                      Text(
                        'Credit',
                        style: context.robotoFlexSemiBold(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    right: 20,
                    child: GestureDetector(
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
                  ),
                ],
              ),
              24.ph,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Mobile Number',
                      style: context.robotoFlexMedium(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    12.ph,
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFFD9D9D9)),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 12,
                            ),
                            child: Text(
                              '🇮🇩',
                              style: const TextStyle(fontSize: 20),
                            ),
                          ),
                          Text(
                            '$_countryCode  ',
                            style: context.robotoFlexMedium(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                          Icon(
                            Icons.keyboard_arrow_down,
                            size: 20,
                            color: Colors.grey.shade600,
                          ),
                          Expanded(
                            child: TextField(
                              controller: _phoneController,
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 14,
                                ),
                                hintText: '898*******',
                                hintStyle: TextStyle(
                                  color: Colors.grey.shade500,
                                  fontSize: 16,
                                  fontFamily: 'Roboto Flex',
                                ),
                              ),
                              style: context.robotoFlexMedium(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    24.ph,
                    CustomButtonWidget(
                      label: 'Check E-Wallet',
                      onPressed: () {
                        Navigator.of(context).pop();
                        widget.onCheckEWallet(
                          _countryCode,
                          _phoneController.text.replaceAll('*', ''),
                        );
                      },
                    ),
                    24.ph,
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
