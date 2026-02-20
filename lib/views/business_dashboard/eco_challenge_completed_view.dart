import '../../export_all.dart';

/// Success screen after completing an eco challenge.
/// Shows green check, "Challenge Completed!", "+50 Point added to your account",
/// "Back to Eco Tips" and "Back to Home" buttons.
class EcoChallengeCompletedView extends StatelessWidget {
  const EcoChallengeCompletedView({
    super.key,
    this.points = 50,
  });

  final int points;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const Spacer(flex: 2),
              Container(
                width: 121,
                height: 121,
                decoration: const BoxDecoration(
                  color: AppColors.primaryColor,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Image.asset(
                    Assets.checkedIcon,
                    width: 56,
                    height: 56,
                  ),
                ),
              ),
              32.ph,
              Text(
                'Challenge Completed!',
                textAlign: TextAlign.center,
                style: context.robotoFlexBold(
                  fontSize: 28,
                  color: Colors.black,
                ),
              ),
              12.ph,
              Text(
                '+$points Point added to your account',
                textAlign: TextAlign.center,
                style: context.robotoFlexMedium(
                  fontSize: 18,
                  color: AppColors.primaryColor,
                ),
              ),
              const Spacer(flex: 2),
              CustomButtonWidget(
                label: 'Back to Eco Tips',
                onPressed: () => AppRouter.back(),
              ),
              16.ph,
              CustomButtonWidget(
                label: 'Back to Home',
                variant: CustomButtonVariant.outlined,
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (_) => const BusinessDashboardView(initialIndex: 0),
                    ),
                    (route) => false,
                  );
                },
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
}
