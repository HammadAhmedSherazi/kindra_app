import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../utils/assets.dart';
import '../utils/colors.dart';
import '../utils/extension.dart';
import '../utils/router.dart';
import 'custom_button_widget.dart';

/// Generic success dialog: green checkmark, title, subtitle, "Continue to Home" button.
/// [onContinue] is called after dialog is closed. If null, navigates to app home.
void showSuccessDialog(
  BuildContext context, {
  required String title,
  required String subtitle,
  VoidCallback? onContinue,
}) {
  showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (ctx) => _SuccessDialog(
      title: title,
      subtitle: subtitle,
      onContinue: onContinue,
    ),
  );
}

/// Success dialog shown after password is changed.
void showPasswordSuccessDialog(BuildContext context) {
  showSuccessDialog(
    context,
    title: 'Successful Update',
    subtitle: 'Your password has been successfully changed',
  );
}

/// Success dialog shown after profile is updated.
void showProfileUpdateSuccessDialog(BuildContext context, {VoidCallback? onContinue}) {
  showSuccessDialog(
    context,
    title: 'Successful Update Profile',
    subtitle: 'Your profile has been successfully updated',
    onContinue: onContinue,
  );
}

/// Success dialog shown after withdrawal: check + bubbles, transaction details, Done.
void showWithdrawalSuccessDialog(
  BuildContext context, {
  required double amount,
  required String transactionId,
  VoidCallback? onDone,
}) {
  showDialog<void>(
    context: context,
    barrierDismissible: false,
    barrierColor: Colors.black54,
    builder: (ctx) => _WithdrawalSuccessDialog(
      amount: amount,
      transactionId: transactionId,
      onDone: onDone,
    ),
  );
}

class _SuccessDialog extends StatelessWidget {
  const _SuccessDialog({
    required this.title,
    required this.subtitle,
    this.onContinue,
  });

  final String title;
  final String subtitle;
  final VoidCallback? onContinue;

  static const Color _green = AppColors.primaryColor;
 

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 32),
      child: Container(
        padding: const EdgeInsets.fromLTRB(24, 40, 24, 32),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Builder(
              builder: (context) {
                final sw = context.screenWidth;
                final sh = context.screenHeight;
                final scale = (sw + sh) * 0.0004;
                final r = (70 * scale).clamp(50.0, 90.0);
                final decoSize = (13 * scale).clamp(10.0, 18.0);
                return Stack(
                  alignment: Alignment.center,
                  clipBehavior: Clip.none,
                  children: [
                    // Decorative translucent circles (screen-responsive)
                    Positioned(top: -8, right: -r, child: _decoCircle((43 * scale).clamp(35.0, 50.0))),
                    Positioned(top: 55, right: -(r * 0.65), child: _decoCircle(decoSize)),
                    Positioned(top: 85, right: -(r * 0.9), child: _decoCircle(decoSize)),
                    Positioned(top: 120, right: -(r * 0.6), child: _decoCircle(decoSize)),
                    Positioned(top: 25, left: -(r * 0.7), child: _decoCircle(decoSize)),
                    Positioned(top: 100, left: -(r * 0.5), child: _decoCircle(decoSize)),
                    // Main green circle with checkmark
                    Container(
                      width: 135,
                      height: 135,
                      padding: const EdgeInsets.all(35),
                      decoration: const BoxDecoration(
                        color: _green,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Image.asset(Assets.checkedIcon),
                    ),
                  ],
                );
              },
            ),
            40.ph,
            Text(
              title,
              style: TextStyle(
                color: Colors.black,
                fontSize: 26.27,
                fontFamily: 'Roboto Flex',
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            12.ph,
            Text(
              subtitle,
              style: TextStyle(
                color: Colors.black,
                fontSize: 19,
                fontFamily: 'Roboto Flex',
                fontWeight: FontWeight.w300,
                height: 1.18,
              ),
              textAlign: TextAlign.center,
            ),
            32.ph,
            CustomButtonWidget(
              label: 'Continue to Home',
              onPressed: () {
                Navigator.of(context).pop();
                if (onContinue != null) {
                  onContinue!();
                } else {
                  AppRouter.backToHome();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _decoCircle(double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _green.withValues(alpha: 0.22),
      ),
    );
  }
}

class _WithdrawalSuccessDialog extends StatelessWidget {
  const _WithdrawalSuccessDialog({
    required this.amount,
    required this.transactionId,
    this.onDone,
  });

  final double amount;
  final String transactionId;
  final VoidCallback? onDone;

  static const Color _green = AppColors.primaryColor;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: context.screenWidth * 0.08),
      child: Container(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 28),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.15),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Builder(
              builder: (context) {
                final sw = context.screenWidth;
                final sh = context.screenHeight;
                final scale = (sw + sh) * 0.0004;
                final r = (70 * scale).clamp(50.0, 90.0);
                final decoSize = (13 * scale).clamp(10.0, 18.0);
                return Stack(
                  alignment: Alignment.center,
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(top: -8, right: -r, child: _decoCircle((43 * scale).clamp(35.0, 50.0))),
                    Positioned(top: 55, right: -(r * 0.65), child: _decoCircle(decoSize)),
                    Positioned(top: 85, right: -(r * 0.9), child: _decoCircle(decoSize)),
                    Positioned(top: 120, right: -(r * 0.6), child: _decoCircle(decoSize)),
                    Positioned(top: 25, left: -(r * 0.7), child: _decoCircle(decoSize)),
                    Positioned(top: 100, left: -(r * 0.5), child: _decoCircle(decoSize)),
                    Container(
                      width: 100,
                      height: 100,
                      padding: const EdgeInsets.all(28),
                      decoration: const BoxDecoration(
                        color: _green,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Image.asset(Assets.checkedIcon),
                    ),
                  ],
                );
              },
            ),
            24.ph,
            Text(
              'Withdrawal Successful!',
              style: TextStyle(
                color: Colors.black,
                fontSize: 22,
                fontFamily: 'Roboto Flex',
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            8.ph,
            Text(
              'You have successfully withdrawn \$${amount.toStringAsFixed(2)} to your PayPal account.',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 15,
                fontFamily: 'Roboto Flex',
                fontWeight: FontWeight.w400,
                height: 1.3,
              ),
              textAlign: TextAlign.center,
            ),
            16.ph,
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Row(
                children: [
                  SvgPicture.asset(Assets.payPalIcon, width: 40, height: 40),
                  12.pw,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Paypal',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontFamily: 'Roboto Flex',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        4.ph,
                        Text(
                          'Transaction ID: $transactionId',
                          style: TextStyle(
                            color: Colors.grey.shade700,
                            fontSize: 12,
                            fontFamily: 'Roboto Flex',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            12.ph,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Estimated arrival: 3-5 business days',
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: 13,
                    fontFamily: 'Roboto Flex',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Icon(Icons.chevron_right, size: 20, color: Colors.grey.shade500),
              ],
            ),
            16.ph,
            Text(
              "You'll receive an email confirmation shortly. Please contact us if you need any assistance.",
              style: TextStyle(
                color: Colors.black87,
                fontSize: 13,
                fontFamily: 'Roboto Flex',
                fontWeight: FontWeight.w400,
                height: 1.35,
              ),
              textAlign: TextAlign.center,
            ),
            24.ph,
            CustomButtonWidget(
              label: 'Done',
              onPressed: () {
                Navigator.of(context).pop();
                onDone?.call();
              },
              height: 50,
            ),
          ],
        ),
      ),
    );
  }

  Widget _decoCircle(double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _green.withValues(alpha: 0.22),
      ),
    );
  }
}
