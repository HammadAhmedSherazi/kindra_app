import 'package:flutter/material.dart';

import '../utils/assets.dart';
import '../utils/colors.dart';
import '../utils/extension.dart';
import '../utils/router.dart';
import '../views/navigation/navigation_view.dart';
import 'custom_button_widget.dart';

/// Success dialog shown after password is changed.
/// Shows "Successful Update", subtitle, and "Continue to Home" button.
void showPasswordSuccessDialog(BuildContext context) {
  showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (ctx) => const _PasswordSuccessDialog(),
  );
}

class _PasswordSuccessDialog extends StatelessWidget {
  const _PasswordSuccessDialog();

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
            Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                // Decorative translucent circles
                Positioned(top: -8, right: -70, child: _decoCircle(43)),
                Positioned(top: 55, right: -46, child: _decoCircle(13)),
                Positioned(top: 85, right: -65, child: _decoCircle(13)),
                Positioned(top: 120, right: -45, child: _decoCircle(13)),

                Positioned(top: 25, left: -50, child: _decoCircle(13)),
                Positioned(top: 100, left: -35, child: _decoCircle(13)),
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
            ),
            40.ph,
            Text(
              'Successful Update',
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
              'Your password has been successfully changed',
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
                AppRouter.backToHome();
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
