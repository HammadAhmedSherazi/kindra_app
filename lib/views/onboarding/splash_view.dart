import 'package:kindra_app/export_all.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () async {
      if (!mounted) return;

      final user = FirebaseAuthService.instance.currentUser;
      if (user == null) {
        AppRouter.pushReplacement(const OnboardingView());
        return;
      }

      await FirebaseAuthService.instance.reloadCurrentUser();
      if (!mounted) return;

      if (!FirebaseAuthService.instance.isEmailVerified) {
        // Avoid forcing verification screen on every cold start.
        // User can verify and then login again.
        await FirebaseAuthService.instance.signOut();
        await FirebaseAuthService.instance.clearLocalAuthCache();
        if (!mounted) return;
        AppRouter.pushReplacement(const LoginView());
        return;
      }

      // Prefer Firestore role; fallback to cached role if needed.
      final role =
          await FirebaseAuthService.instance.fetchRoleForCurrentUser() ??
              await FirebaseAuthService.instance.readCachedLoginRole();

      if (!mounted) return;

      if (role == null) {
        AppRouter.pushReplacement(const LoginView());
        return;
      }
      navigateToDashboardForRole(role);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(0.50, -0.05),
          end: Alignment(0.50, 1.11),
          colors: [const Color(0xFF005469), const Color(0xFF001419)],
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(44),
        child: Image.asset(Assets.logo, width: 152, height: 152,)),
    );
  }
}
