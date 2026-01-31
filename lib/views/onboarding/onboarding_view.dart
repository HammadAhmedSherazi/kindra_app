import '../../export_all.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Text(
                'Kindra',
                style: context.textStyle.titleLarge?.copyWith(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              24.ph,
              Text(
                context.tr('welcome_message'),
                textAlign: TextAlign.center,
                style: context.textStyle.bodyMedium,
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    SharedPreferenceManager.sharedInstance.storeGetStarted(true);
                    AppRouter.pushReplacement(const LoginView());
                  },
                  child: Text(context.tr('get_started')),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
