import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'database/local_database.dart';
import 'pages/uncategorized_pages/splash_screen_page/splash_screen_page.dart';
import 'resources/app_themes.dart';
import 'routes/app_router.dart';

void _errorHandler(Object error, StackTrace stack) {
  log(
    '\nError description: $error'
    '\nStackTrace:\n$stack',
    name: 'Error handler',
  );
}

Future<void> main() async {
  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      await LocalDB.instance.ensureInitialized();

      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
      ]);

      runApp(
        const _App(),
      );
    },
    _errorHandler,
  );
}

class _App extends StatelessWidget {
  const _App();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Magic Hat',
      theme: AppThemes.light(),
      initialRoute: SplashScreenPage.routeName,
      onGenerateRoute: AppRouter.generateRoute,
      routes: {
        SplashScreenPage.routeName: (_) => const SplashScreenPage(),
      },
    );
  }
}
