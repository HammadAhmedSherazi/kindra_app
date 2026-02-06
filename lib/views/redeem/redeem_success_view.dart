import 'package:flutter/services.dart';

import '../../export_all.dart';

/// Screen 3: Points Redemption Successful - Confirmation after exchange.
class RedeemSuccessView extends StatelessWidget {
  const RedeemSuccessView({
    super.key,
    required this.redeemedAmount,
    required this.pointsRedeemed,
    required this.redemptionId,
    this.date,
  });

  final double redeemedAmount;
  final int pointsRedeemed;
  final String redemptionId;
  final String? date;

  String get _formattedDate {
    if (date != null) return date!;
    final now = DateTime.now();
    final weekdays = [
      'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'
    ];
    final months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return '${weekdays[now.weekday - 1]}, ${months[now.month - 1]} ${now.day}, ${now.year}';
  }

  @override
  Widget build(BuildContext context) {
    return CustomInnerScreenTemplate(
      title: '',
      showBackButton: false,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              24.ph,
              CardWithOverlayWidget(
                overlay: Container(
                  width: 80,
                  height: 80,
                  decoration: const BoxDecoration(
                    color: AppColors.primaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check,
                    size: 44,
                    color: Colors.white,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Points Redemption Successful',
                      textAlign: TextAlign.center,
                      style: context.robotoFlexBold(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                    12.ph,
                    Text(
                      '\$${redeemedAmount.toStringAsFixed(1)}',
                      textAlign: TextAlign.center,
                      style: context.robotoFlexSemiBold(
                        fontSize: 20,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    24.ph,
                    _DetailRow(
                      label: 'Status',
                      value: _SuccessStatusPill(text: 'Success'),
                    ),
                    16.ph,
                    _DetailRow(
                      label: 'Redemption ID',
                      value: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            redemptionId,
                            style: context.robotoFlexMedium(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                          8.pw,
                          GestureDetector(
                            onTap: () {
                              Clipboard.setData(
                                ClipboardData(text: redemptionId),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Redemption ID copied'),
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                            },
                            child: Icon(
                              Icons.copy_rounded,
                              size: 20,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    16.ph,
                    _DetailRowText(
                      label: 'Points redeemed',
                      text: pointsRedeemed.toString(),
                    ),
                    16.ph,
                    _DetailRowText(
                      label: 'Date',
                      text: _formattedDate,
                    ),
                    20.ph,
                    Divider(height: 1, color: Colors.grey.shade300),
                    20.ph,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total Points',
                          style: context.robotoFlexSemiBold(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          '\$${redeemedAmount.toStringAsFixed(1)}',
                          style: context.robotoFlexSemiBold(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Spacer(),
              CustomButtonWidget(
                label: 'Back to Home',
                onPressed: () => AppRouter.backToHome(),
              ),
              24.ph,
            ],
          ),
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.label, required this.value});

  final String label;
  final Widget value;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.grey.shade700,
            fontSize: 14,
            fontFamily: 'Roboto Flex',
            fontWeight: FontWeight.w400,
          ),
        ),
        Flexible(
          child: Align(alignment: Alignment.centerRight, child: value),
        ),
      ],
    );
  }
}

class _DetailRowText extends StatelessWidget {
  const _DetailRowText({required this.label, required this.text});

  final String label;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.grey.shade700,
            fontSize: 14,
            fontFamily: 'Roboto Flex',
            fontWeight: FontWeight.w400,
          ),
        ),
        Text(
          text,
          style: context.robotoFlexMedium(
            fontSize: 14,
            color: Colors.black,
          ),
          textAlign: TextAlign.right,
        ),
      ],
    );
  }
}

class _SuccessStatusPill extends StatelessWidget {
  const _SuccessStatusPill({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFE3F2FD),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFF90CAF9), width: 1),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Color(0xFF1976D2),
          fontSize: 13,
          fontFamily: 'Roboto Flex',
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
