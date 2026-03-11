import '../../export_all.dart';

/// Withdraw funds screen: header, static balance card, amount input, method card, withdraw button, disclaimer.
/// Stack layout: top card static, scrollable content in Expanded child.
class WithdrawFundsView extends StatefulWidget {
  const WithdrawFundsView({super.key});

  @override
  State<WithdrawFundsView> createState() => _WithdrawFundsViewState();
}

class _WithdrawFundsViewState extends State<WithdrawFundsView> {
  static const double _availableBalance = 37.60;

  final _amountController = TextEditingController(text: '20.00');
  double _withdrawAmount = 20.00;

  @override
  void initState() {
    super.initState();
    _amountController.addListener(_parseAmount);
  }

  void _parseAmount() {
    final text = _amountController.text.trim();
    if (text.isEmpty) {
      setState(() => _withdrawAmount = 0);
      return;
    }
    final parsed = double.tryParse(text.replaceAll(RegExp(r'[^0-9.]'), '')) ?? 0.0;
    setState(() => _withdrawAmount = parsed);
  }

  @override
  void dispose() {
    _amountController.removeListener(_parseAmount);
    _amountController.dispose();
    super.dispose();
  }

  void _setMaxAmount() {
    _amountController.text = _availableBalance.toStringAsFixed(2);
  }

  void _withdraw() {
    if (_withdrawAmount <= 0 || _withdrawAmount > _availableBalance) return;
    showWithdrawalSuccessDialog(
      context,
      amount: _withdrawAmount,
      transactionId: '9515641HDND56656',
      onDone: () => AppRouter.back(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = context.screenWidth * 0.05;
    final contentTop = context.screenHeight * 0.24;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            CoastalGroupHeader(
              sectionTitle: 'Withdraw Funds',
              height: context.screenHeight * 0.30,
              onNotificationTap: () => AppRouter.push(const NotificationView()),
              leading: GestureDetector(
                onTap: () => AppRouter.back(),
                child: const Padding(
                  padding: EdgeInsets.only(top: 4),
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                    size: 22,
                  ),
                ),
              ),
            ),
            Positioned(
              top: contentTop,
              left: 0,
              right: 0,
              bottom: 0,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                    child: _BalanceCard(context),
                  ),
                  16.ph,
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.fromLTRB(
                        horizontalPadding,
                        0,
                        horizontalPadding,
                        24,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _buildAmountSection(context),
                          20.ph,
                          _buildMethodSection(context),
                          24.ph,
                          CustomButtonWidget(
                            label: 'Withdraw \$${_withdrawAmount.toStringAsFixed(2)}',
                            onPressed: _withdrawAmount > 0 &&
                                    _withdrawAmount <= _availableBalance
                                ? _withdraw
                                : null,
                            height: 52,
                          ),
                          20.ph,
                          Text(
                            'By withdrawing funds, you confirm that the payment details are accurate and that you consent to our terms of service.',
                            style: context.robotoFlexRegular(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          100.ph,
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _BalanceCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Image.asset(Assets.coinDollarIcon, width: 40, height: 40),
          14.pw,
          Expanded(
            child: Text(
              'Your Available Balance: \$${_availableBalance.toStringAsFixed(2)}',
              style: context.robotoFlexSemiBold(fontSize: 15, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAmountSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Enter Withdrawal Amount',
          style: context.robotoFlexRegular(fontSize: 17, color: Colors.black),
        ),
        8.ph,
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Text(
                  '\$',
                  style: context.robotoFlexBold(fontSize: 18, color: Colors.black),
                ),
              ),
              Container(
                width: 1,
                height: 24,
                margin: const EdgeInsets.symmetric(horizontal: 12),
                color: Colors.grey.shade400,
              ),
              Expanded(
                child: TextFormField(
                  controller: _amountController,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    hintText: '20.00',
                    hintStyle: context.robotoFlexRegular(
                      fontSize: 16,
                      color: Colors.grey.shade500,
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  ),
                  style: context.robotoFlexSemiBold(fontSize: 16, color: Colors.black),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 12),
                child: TextButton(
                  onPressed: _setMaxAmount,
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.grey.shade200,
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Max',
                    style: context.robotoFlexSemiBold(
                      fontSize: 14,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMethodSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Withdrawal Method',
          style: context.robotoFlexRegular(fontSize: 17, color: Colors.black),
        ),
        8.ph,
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.06),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              SvgPicture.asset(Assets.payPalIcon, width: 44, height: 44),
              14.pw,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Paypal',
                      style: context.robotoFlexBold(fontSize: 16, color: Colors.black),
                    ),
                    4.ph,
                    Text(
                      'Funds will be transferred within 3-5 business days.',
                      style: context.robotoFlexRegular(
                        fontSize: 13,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                'Change >',
                style: context.robotoFlexSemiBold(
                  fontSize: 14,
                  color: AppColors.primaryColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
