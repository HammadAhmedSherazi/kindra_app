import 'package:flutter/services.dart';

import '../../export_all.dart';

/// Success screen shown after eco-points are credited (e.g. after garbage handover).
/// Uses [HistoryDetailData] so it can be opened from redemption flow or history.
class EcoPointsSuccessView extends StatelessWidget {
  const EcoPointsSuccessView({
    super.key,
    required this.data,
  });

  final HistoryDetailData data;

  @override
  Widget build(BuildContext context) {
    return CustomInnerScreenTemplate(
      title: "",
      showBackButton: false,
      child: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              24.ph,
              CardWithOverlayWidget(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Eco-Points Credited Successfully',
                      textAlign: TextAlign.center,
                      style: context.robotoFlexBold(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                    12.ph,
                    Text(
                      '+${data.pointsAwarded} Point${data.pointsAwarded == 1 ? '' : 's'}',
                      textAlign: TextAlign.center,
                      style: context.robotoFlexSemiBold(
                        fontSize: 18,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    24.ph,
                    _DetailRow(
                      label: 'Status',
                      value: _SuccessStatusPill(text: data.status),
                    ),
                    16.ph,
                    _DetailRow(
                      label: 'Redemption ID',
                      value: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            data.redemptionId,
                            style: context.robotoFlexMedium(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                          8.pw,
                          GestureDetector(
                            onTap: () {
                              Clipboard.setData(
                                ClipboardData(text: data.redemptionId),
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
                      label: 'Type of weight',
                      text: data.typeOfWaste,
                    ),
                    16.ph,
                    _DetailRowText(
                      label: 'Garbage weight',
                      text: data.garbageWeight,
                    ),
                    16.ph,
                    _DetailRowText(label: 'Date', text: data.date),
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
                          '${data.totalPoints} Points',
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
             Spacer(),
              CustomButtonWidget(
                label: 'Back Home',
                variant: CustomButtonVariant.outlined,
                onPressed: () => AppRouter.backToHome(),
                backgroundColor: Colors.white,
                borderColor: AppColors.primaryTextColor,
                textColor: AppColors.primaryTextColor,
              ),
              16.ph,
              CustomButtonWidget(
                label: 'See Points',
                onPressed: () {
                  AppRouter.backToHome();
                  AppRouter.push(const PointsView());
                },
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
