import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/extension.dart';
import '../utils/router.dart';
import '../views/auth/login_view.dart';
import '../services/firebase_auth_service.dart';
import 'custom_button_widget.dart';

/// Shows "Exit App?" confirmation dialog. On Exit, pops dialog and navigates to login.
void showExitAppDialog(BuildContext context) {
  showDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (ctx) => const _ExitAppDialog(),
  );
}

/// Shows "Log Out?" confirmation dialog. On confirm, pops dialog and navigates to login.
void showLogoutDialog(BuildContext context) {
  showDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (ctx) => const _LogoutDialog(),
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
                      AppRouter.pushAndRemoveUntil(const LoginView());
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

class _LogoutDialog extends StatelessWidget {
  const _LogoutDialog();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
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
              'Log Out?',
              style: context.robotoFlexSemiBold(
                fontSize: 20,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            12.ph,
            Text(
              'Are you sure you want to log out?',
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
                    label: 'Log Out',
                    onPressed: () async {
                      Navigator.of(context).pop();
                      await FirebaseAuthService.instance.signOut();
                      await FirebaseAuthService.instance.clearLocalAuthCache();
                      AppRouter.pushAndRemoveUntil(const LoginView());
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
