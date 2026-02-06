import '../../export_all.dart';

/// Credit flow: Pulsa / Select Point Amount screen.
/// User selects point bundle and exchanges for mobile credit.
class CreditExchangeView extends StatefulWidget {
  const CreditExchangeView({
    super.key,
    this.phoneNumber,
  });

  final String? phoneNumber;

  @override
  State<CreditExchangeView> createState() => _CreditExchangeViewState();
}

class _CreditExchangeViewState extends State<CreditExchangeView> {
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
  static const _demoRecipient = 'Abcd- 092565232';

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
              _PulsaCard(
                recipient: _demoRecipient,
                maxRedeemable: '\$$_maxRedeemableDollar',
              ),
              24.ph,
              _SelectPointAmountSection(
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

class _PulsaCard extends StatelessWidget {
  const _PulsaCard({
    required this.recipient,
    required this.maxRedeemable,
  });

  final String recipient;
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
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Image.asset(
                    Assets.cardIcon,
                    width: 28,
                    height: 28,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
              12.pw,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pulsa',
                      style: context.robotoFlexSemiBold(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                    4.ph,
                    Text(
                      recipient,
                      style: context.robotoFlexRegular(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
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

class _SelectPointAmountSection extends StatelessWidget {
  const _SelectPointAmountSection({
    required this.options,
    required this.selectedIndex,
    required this.onSelected,
  });

  final List<(int points, double dollar)> options;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

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
            'Select Point Amount',
            style: context.robotoFlexSemiBold(
              fontSize: 16,
              color: Colors.black,
            ),
          ),
          16.ph,
          GridView.builder(
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
                    color: isSelected
                        ? AppColors.primaryColor
                        : Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected
                          ? AppColors.primaryColor
                          : Colors.grey.shade300,
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
                          color: isSelected
                              ? Colors.white
                              : Colors.grey.shade700,
                        ),
                      ),
                      8.ph,
                      Text(
                        '\$$dollar',
                        style: context.robotoFlexSemiBold(
                          fontSize: 14,
                          color: isSelected
                              ? Colors.white
                              : Colors.grey.shade700,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
