import 'credit_check_modal.dart';
import 'credit_exchange_view.dart';
import 'redeem_enums.dart';

import '../../export_all.dart';

/// Screen 1: Points Redemption - Select E-wallet or Credit, then choose E-wallet provider.
class RedeemMethodSelectionView extends StatefulWidget {
  const RedeemMethodSelectionView({super.key});

  @override
  State<RedeemMethodSelectionView> createState() =>
      _RedeemMethodSelectionViewState();
}

class _RedeemMethodSelectionViewState extends State<RedeemMethodSelectionView> {
  RedeemMethod _method = RedeemMethod.eWallet;
  EWalletProvider? _selectedWallet;

  static const _eWalletOptions = [
    (EWalletProvider.paypal, 'Paypal', Assets.payPalIcon),
    (EWalletProvider.googlePay, 'Google Pay', Assets.googlePayIcon),
    (EWalletProvider.applePay, 'Apple Pay', Assets.applePayIcon),
  ];

  bool get _canProceed =>
      _method == RedeemMethod.eWallet && _selectedWallet != null ||
      _method == RedeemMethod.credit;

  void _onNext() {
    if (_method == RedeemMethod.eWallet && _selectedWallet != null) {
      AppRouter.push(
        WalletExchangeView(provider: _selectedWallet!),
      );
      return;
    }
    if (_method == RedeemMethod.credit) {
      CreditCheckModal.show(
        context,
        onCheckEWallet: (countryCode, phone) {
          AppRouter.push(
            CreditExchangeView(phoneNumber: phone.isNotEmpty ? phone : null),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomInnerScreenTemplate(
      title: 'Points Redemption',
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Select for redeemed points',
                style: context.robotoFlexRegular(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                ),
              ),
              24.ph,
              Row(
                children: [
                  Expanded(
                    child: _MethodCard(
                      label: 'E-wallet',
                      iconPath: Assets.walletIcon,
                      isIconSvg: false,
                      isSelected: _method == RedeemMethod.eWallet,
                      onTap: () =>
                          setState(() => _method = RedeemMethod.eWallet),
                    ),
                  ),
                  16.pw,
                  Expanded(
                    child: _MethodCard(
                      label: 'Credit',
                      iconPath: Assets.cardIcon,
                      isIconSvg: false,
                      isSelected: _method == RedeemMethod.credit,
                      onTap: () => setState(() => _method = RedeemMethod.credit),
                    ),
                  ),
                ],
              ),
              if (_method == RedeemMethod.eWallet) ...[
                24.ph,
                _ChooseEWalletSection(
                  options: _eWalletOptions,
                  selected: _selectedWallet,
                  onSelected: (p) => setState(() => _selectedWallet = p),
                ),
              ],
              const Spacer(),
              CustomButtonWidget(
                label: 'Next',
                onPressed: _canProceed ? _onNext : null,
                enabled: _canProceed,
              ),
              24.ph,
            ],
          ),
        ),
      ),
    );
  }
}

class _MethodCard extends StatelessWidget {
  const _MethodCard({
    required this.label,
    required this.iconPath,
    required this.isIconSvg,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final String iconPath;
  final bool isIconSvg;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final borderColor =
        isSelected ? AppColors.primaryColor : const Color(0xFFD9D9D9);
    final iconColor = isSelected ? AppColors.primaryColor : Colors.grey.shade600;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: borderColor, width: isSelected ? 2 : 1),
        ),
        child: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (isIconSvg)
                  SvgPicture.asset(
                    iconPath,
                    width: 56,
                    height: 56,
                    colorFilter: ColorFilter.mode(
                      iconColor,
                      BlendMode.srcIn,
                    ),
                  )
                else
                  Image.asset(
                    iconPath,
                    width: 56,
                    height: 56,
                    color: iconColor,
                  ),
                12.ph,
                Text(
                  label,
                  style: context.robotoFlexMedium(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            Positioned(
              top: 0,
              right: 12,
              child: Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isSelected ? AppColors.primaryColor : Colors.grey.shade400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ChooseEWalletSection extends StatelessWidget {
  const _ChooseEWalletSection({
    required this.options,
    required this.selected,
    required this.onSelected,
  });

  final List<(EWalletProvider, String, String)> options;
  final EWalletProvider? selected;
  final ValueChanged<EWalletProvider> onSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFD9D9D9)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Choose E-Wallet',
            style: context.robotoFlexSemiBold(
              fontSize: 16,
              color: Colors.black,
            ),
          ),
          16.ph,
          ...options.asMap().entries.map((entry) {
            final index = entry.key;
            final (provider, label, iconPath) = entry.value;
            final isLast = index == options.length - 1;
            return Column(
              children: [
                InkWell(
                  onTap: () => onSelected(provider),
                  borderRadius: BorderRadius.circular(8),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Row(
                      children: [
                        if (iconPath.endsWith('.svg'))
                          SvgPicture.asset(
                            iconPath,
                            width: 36,
                            height: 36,
                          )
                        else
                          Image.asset(
                            iconPath,
                            width: 36,
                            height: 36,
                          ),
                        16.pw,
                        Expanded(
                          child: Text(
                            label,
                            style: context.robotoFlexMedium(
                              fontSize: 15,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: selected == provider
                                  ? AppColors.primaryColor
                                  : Colors.grey.shade400,
                              width: 2,
                            ),
                            color: selected == provider
                                ? AppColors.primaryColor
                                : Colors.transparent,
                          ),
                          child: selected == provider
                              ? Icon(
                                  Icons.check,
                                  size: 12,
                                  color: Colors.white,
                                )
                              : null,
                        ),
                      ],
                    ),
                  ),
                ),
                if (!isLast)
                  Divider(height: 1, color: Colors.grey.shade300),
              ],
            );
          }),
        ],
      ),
    );
  }
}
