import 'export_all.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Don't crash the app if .env is missing in some builds.
  await dotenv.load(fileName: ".env", isOptional: true);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await SharedPreferenceManager.init();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(localeProvider);
    // final prefs = SharedPreferenceManager.sharedInstance;

    return MaterialApp(
      navigatorKey: AppRouter.navKey,
      localizationsDelegates: const [
        LocalizationService.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en'), Locale('es')],
      locale: locale,
      debugShowCheckedModeBanner: false,
      title: 'Kindra',
      theme: AppTheme.lightTheme,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(
            context,
          ).copyWith(textScaler: const TextScaler.linear(1.0)),
          child: child!,
        );
      },
      home: SplashView(),
    );
  }
}
