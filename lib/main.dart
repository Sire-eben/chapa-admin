import 'package:chapa_admin/locator.dart';
import 'package:chapa_admin/modules/dashboard/screens/dashboard.dart';
import 'package:chapa_admin/routing/route_names.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'handlers/base_change_notifier.dart';
import 'modules/authentication/screens/login_screen.dart';
import 'modules/authentication/services/auth_service.dart';
import 'modules/categories/service/category_service.dart';
import 'modules/layout_template/layout_template.dart';
import 'modules/printing_qualities/service/print_service.dart';
import 'modules/utilities/service/utils_service.dart';
import 'navigation_service.dart';
import 'routing/router.dart';
import 'utils/app_strings.dart';
import 'utils/app_themes.dart';
import 'package:url_strategy/url_strategy.dart';

// final chapaNavigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setPathUrlStrategy();
  await Firebase.initializeApp(
    // name: "CHAPA",
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<BaseChangeNotifier>(create: (_) => locator()),
        ChangeNotifierProvider<AuthService>(create: (_) => locator()),
        ChangeNotifierProvider<CategoryService>(create: (_) => locator()),
        ChangeNotifierProvider<UtilitiesService>(create: (_) => locator()),
        ChangeNotifierProvider<PrintingService>(create: (_) => locator()),
      ],
      child: MaterialApp(
        title: AppStrings.appName,
        theme: AppTheme.defaultTheme(context),
        debugShowCheckedModeBanner: false,
        builder: (context, child) => LayoutTemplate(child: child!),
        navigatorKey: locator<NavigationService>().chapaNavigatorKey,
        onGenerateRoute: generateRoute,
        initialRoute: authWrapper,
        // home: const AuthWrapper(),
      ),
    );
  }
}

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return StreamBuilder<User?>(
      stream: authService.authStateChanges,
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final user = snapshot.data;
          return user == null ? const LoginScreen() : DashboardScreen();
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
