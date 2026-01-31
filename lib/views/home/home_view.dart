import '../../export_all.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.tr('home')),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              context.tr('welcome_message'),
              style: context.textStyle.titleMedium,
              textAlign: TextAlign.center,
            ),
            24.ph,
            ElevatedButton(
              onPressed: () => AppRouter.pushReplacement(const LoginView()),
              child: Text(context.tr('logout')),
            ),
          ],
        ),
      ),
    );
  }
}
