import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/extension.dart';
import '../utils/router.dart';
import '../views/auth/login_view.dart';
import 'custom_button_widget.dart';

/// Shows "Exit App?" confirmation dialog. On Exit, pops dialog and navigates to login.
void showExitAppDialog(BuildContext context) {
  showDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (ctx) => const _ExitAppDialog(),
  );
}

class _ExitAppDialog extends StatelessWidget {
  const _ExitAppDialog();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      // insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 20,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Exit App?',
              style: context.robotoFlexSemiBold(
                fontSize: 20,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            12.ph,
            Text(
              'Are you sure you want to exit the app?',
              style: context.robotoFlexRegular(
                fontSize: 15,
                color: AppColors.primaryTextColor,
              ),
              textAlign: TextAlign.center,
            ),
            24.ph,
            Row(
              children: [
                Expanded(
                  child: CustomButtonWidget(
                    label: 'Cancel',
                    onPressed: () => Navigator.of(context).pop(),
                    variant: CustomButtonVariant.outlined,
                    backgroundColor: Colors.white,
                    textColor: const Color(0xFF3A3A3A),
                    borderColor: const Color(0xFF3A3A3A),
                    textSize: 16,
                  ),
                ),
                16.pw,
                Expanded(
                  child: CustomButtonWidget(
                    label: 'Exit',
                    onPressed: () {
                      Navigator.of(context).pop();
                      AppRouter.pushReplacement(const LoginView());
                    },
                    backgroundColor: AppColors.primaryColor,
                    textColor: Colors.white,
                    textSize: 16,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
