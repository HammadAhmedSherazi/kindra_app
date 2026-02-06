import 'redeem_enums.dart';

import '../../export_all.dart';

/// Screen 2: Points Redemption - E-wallet exchange (PayPal, Google Pay, Apple Pay).
/// Enter nominal, select point amount, exchange.
class WalletExchangeView extends StatefulWidget {
  const WalletExchangeView({
    super.key,
    required this.provider,
  });

  final EWalletProvider provider;

  String get _providerName {
    switch (provider) {
      case EWalletProvider.paypal:
        return 'Paypal';
      case EWalletProvider.googlePay:
        return 'Google Pay';
      case EWalletProvider.applePay:
        return 'Apple Pay';
    }
  }

  String get _providerIcon {
    switch (provider) {
      case EWalletProvider.paypal:
        return Assets.payPalIcon;
      case EWalletProvider.googlePay:
        return Assets.googlePayIcon;
      case EWalletProvider.applePay:
        return Assets.applePayIcon;
    }
  }

  @override
  State<WalletExchangeView> createState() => _WalletExchangeViewState();
}

class _WalletExchangeViewState extends State<WalletExchangeView> {
  final _nominalController = TextEditingController(text: '6');
  int _selectedIndex = 0;

  static const _pointOptions = [
    (1000, 2.5),
    (2000, 5.0),
    (3000, 7.5),
    (4000, 10.0),
    (5000, 12.5),
    (6000, 15.0),
  ];

  static const _maxRedeemableDollar = 5.0;
  static const _demoPointsRedeemed = 10000;

  @override
  void dispose() {
    _nominalController.dispose();
    super.dispose();
  }

  void _onExchangePoints() {
    final (points, dollar) = _pointOptions[_selectedIndex];
    AppRouter.push(
      RedeemSuccessView(
        redeemedAmount: dollar,
        pointsRedeemed: points,
        redemptionId: '0 123 456 ****',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomInnerScreenTemplate(
      title: 'Points Redemption',
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              24.ph,
              _ProviderCard(
                providerName: widget._providerName,
                providerIcon: widget._providerIcon,
                accountId: 'Abcd- 092565232',
                maxRedeemable: '\$$_maxRedeemableDollar',
              ),
              24.ph,
              _EnterNominalSection(
                controller: _nominalController,
              ),
              24.ph,
              _PointOptionsGrid(
                options: _pointOptions,
                selectedIndex: _selectedIndex,
                onSelected: (i) => setState(() => _selectedIndex = i),
              ),
              24.ph,
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Points redeemed',
                        style: context.robotoFlexRegular(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      4.ph,
                      Text(
                        '$_demoPointsRedeemed',
                        style: context.robotoFlexSemiBold(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  SizedBox(
                    width: 180,
                    child: CustomButtonWidget(
                      label: 'Exchange Points',
                      onPressed: _onExchangePoints,
                      textSize: 16,
                    ),
                  ),
                ],
              ),
              24.ph,
            ],
          ),
        ),
      ),
    );
  }
}

class _ProviderCard extends StatelessWidget {
  const _ProviderCard({
    required this.providerName,
    required this.providerIcon,
    required this.accountId,
    required this.maxRedeemable,
  });

  final String providerName;
  final String providerIcon;
  final String accountId;
  final String maxRedeemable;

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
          Row(
            children: [
              SvgPicture.asset(providerIcon, width: 40, height: 40),
              12.pw,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    providerName,
                    style: context.robotoFlexSemiBold(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  4.ph,
                  Text(
                    accountId,
                    style: context.robotoFlexRegular(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ],
          ),
          16.ph,
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFF90CAF9)),
            ),
            child: Text(
              'Point that can be redeemed $maxRedeemable',
              style: context.robotoFlexMedium(
                fontSize: 14,
                color: const Color(0xFF1976D2),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _EnterNominalSection extends StatelessWidget {
  const _EnterNominalSection({
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFD9D9D9)),
      ),
      child: CustomTextFieldWidget(
        controller: controller,
        label: 'Enter Nominal',
        keyboardType: TextInputType.number,
        hint: '0',
      ),
    );
  }
}

class _PointOptionsGrid extends StatelessWidget {
  const _PointOptionsGrid({
    required this.options,
    required this.selectedIndex,
    required this.onSelected,
  });

  final List<(int points, double dollar)> options;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 1.2,
      ),
      itemCount: options.length,
      itemBuilder: (context, index) {
        final (points, dollar) = options[index];
        final isSelected = index == selectedIndex;
        return GestureDetector(
          onTap: () => onSelected(index),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected ? AppColors.primaryColor : const Color(0xFFD9D9D9),
                width: isSelected ? 2 : 1,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${points} Points',
                  textAlign: TextAlign.center,
                  style: context.robotoFlexMedium(
                    fontSize: 13,
                    color: Colors.black,
                  ),
                ),
                8.ph,
                Text(
                  '\$$dollar',
                  style: context.robotoFlexSemiBold(
                    fontSize: 14,
                    color: isSelected ? AppColors.primaryColor : Colors.black,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
