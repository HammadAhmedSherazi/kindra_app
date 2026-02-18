import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../export_all.dart';

/// Data for Past Pickup detail screen (Complete or Rejected).
class PastPickupDetailData {
  const PastPickupDetailData({
    required this.pickupId,
    required this.redemptionId,
    required this.typeOfWeight,
    required this.wasteQuantity,
    required this.date,
    this.pointsEarned,
    required this.totalPoints,
  });

  final String pickupId;
  final String redemptionId;
  final String typeOfWeight;
  final String wasteQuantity;
  final String date;
  /// Null for rejected pickups.
  final int? pointsEarned;
  final int totalPoints;
}

/// Detail screen for a past pickup: shown when user taps a Completed or Rejected
/// item in Past Pickup tab. Follows household flow (same layout as EcoPointsSuccessView).
class PastPickupDetailView extends StatelessWidget {
  const PastPickupDetailView({
    super.key,
    required this.data,
    required this.isCompleted,
  });

  final PastPickupDetailData data;
  final bool isCompleted;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF9FAFC),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const Spacer(flex: 1),
              CardWithOverlayWidget(
                overlay: isCompleted ? null : _rejectedOverlay(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      isCompleted
                          ? 'Pickup Completed Successfully'
                          : 'Pickup Rejected',
                      textAlign: TextAlign.center,
                      style: context.robotoFlexBold(
                        fontSize: 22,
                        color: Colors.black,
                      ),
                    ),
                    if (isCompleted && data.pointsEarned != null) ...[
                      8.ph,
                      RichText(
                        textAlign: TextAlign.center,
                        
                        text: TextSpan(
                          style: context.robotoFlexMedium(
                            fontSize: 16,
                            color: AppColors.primaryColor,
                          ),
                          children: [
                            TextSpan(
                              text: '+${data.pointsEarned} Point ',
                              style: context.robotoFlexMedium(
                                fontSize: 16,
                                color: AppColors.primaryColor,
                              ),
                            ),
                            const TextSpan(text: 'Eco-point Earned'),
                          ],
                        ),
                      ),
                    ],
                    24.ph,
                    _detailRow(
                      context: context,
                      label: 'Pickup ID',
                      value: data.pickupId,
                    ),
                    16.ph,
                    _redemptionRow(context),
                    16.ph,
                    _detailRow(
                      context: context,
                      label: 'Type of weight',
                      value: data.typeOfWeight,
                    ),
                    16.ph,
                    _detailRow(
                      context: context,
                      label: 'Waste Oil',
                      value: data.wasteQuantity,
                    ),
                    16.ph,
                    _detailRow(
                      context: context,
                      label: 'Date',
                      value: data.date,
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
              const Spacer(flex: 2),
              CustomButtonWidget(
                label: 'Back',
                variant: CustomButtonVariant.outlined,
                onPressed: () => AppRouter.back(),
                backgroundColor: Colors.white,
                borderColor: AppColors.primaryTextColor,
                textColor: AppColors.primaryTextColor,
              ),
              32.ph,
            ],
          ),
        ),
      ),
    );
  }

  Widget _rejectedOverlay() {
    return Container(
      width: 121,
      height: 121,
      decoration: const BoxDecoration(
        color: Color(0xFFE53935),
        shape: BoxShape.circle,
      ),
      child: const Center(
        child: Icon(
          Icons.close,
          size: 56,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _detailRow({
    required BuildContext context,
    required String label,
    required String value,
  }) {
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
          value,
          style: context.robotoFlexMedium(
            fontSize: 14,
            color: Colors.black,
          ),
          textAlign: TextAlign.right,
        ),
      ],
    );
  }

  Widget _redemptionRow(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Redemption ID',
          style: TextStyle(
            color: Colors.grey.shade700,
            fontSize: 14,
            fontFamily: 'Roboto Flex',
            fontWeight: FontWeight.w400,
          ),
        ),
        Row(
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
      ],
    );
  }
}
