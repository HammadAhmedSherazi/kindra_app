import '../../export_all.dart';

/// Shown after sign-up or sign-in when the account email is not verified yet.
class EmailVerificationView extends ConsumerStatefulWidget {
  const EmailVerificationView({super.key});

  @override
  ConsumerState<EmailVerificationView> createState() =>
      _EmailVerificationViewState();
}

class _EmailVerificationViewState extends ConsumerState<EmailVerificationView> {
  bool _busy = false;

  Future<void> _tryContinue() async {
    setState(() => _busy = true);
    try {
      await FirebaseAuthService.instance.reloadCurrentUser();
      if (!mounted) return;
      final verified = FirebaseAuthService.instance.isEmailVerified;
      if (!verified) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Email not verified yet. Open the link in your inbox, then tap again.',
            ),
          ),
        );
        return;
      }
      final role = await FirebaseAuthService.instance.fetchRoleForCurrentUser();
      if (!mounted) return;
      if (role == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Profile not found. Please contact support.'),
          ),
        );
        return;
      }
      navigateToDashboardForRole(role);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(FirebaseAuthService.messageForAuthException(e)),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _resend() async {
    setState(() => _busy = true);
    try {
      await FirebaseAuthService.instance.sendVerificationEmail();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Verification email sent. Check your inbox.'),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(FirebaseAuthService.messageForAuthException(e)),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final email = FirebaseAuthService.instance.currentUserEmail ?? '';

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 12),
          child: BackButtonWidget(onPressed: () => AppRouter.back()),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              24.ph,
              Text(
                'Verify your email',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 27.49,
                  fontFamily: 'Roboto Flex',
                  fontWeight: FontWeight.w600,
                ),
              ),
              16.ph,
              Text(
                'We sent a message to $email. Open the link in that email to verify your account.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black.withValues(alpha: 0.75),
                  fontSize: 16,
                  fontFamily: 'Roboto Flex',
                  fontWeight: FontWeight.w300,
                  height: 1.4,
                ),
              ),
              32.ph,
              CustomButtonWidget(
                label: 'I\'ve verified — continue',
                onPressed: _tryContinue,
                loading: _busy,
              ),
              16.ph,
              TextButton(
                onPressed: _busy ? null : _resend,
                child: Text(
                  'Resend verification email',
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 16,
                    fontFamily: 'Roboto Flex',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
