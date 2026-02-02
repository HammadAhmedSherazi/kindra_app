import 'package:kindra_app/export_all.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
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
      child: SvgPicture.asset(Assets.logo, width: 30, height: 30,),
    );
  }
}
