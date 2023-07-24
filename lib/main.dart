import 'package:delivery_app/core/providers/auth_providers.dart';
import 'package:delivery_app/views/opening/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'core/core_shelf.dart' as core;
import 'package:firebase_core/firebase_core.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await core.LocalManager.prefrencesInit();

  runApp(
    MultiProvider(
      providers: [
        ...?core.AppProviders.instance?.dependItems],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
        builder: (context, core.ThemeProvider theme, Widget? child) {
      bool dark = theme.isDark;
      return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: dark ? Brightness.light : Brightness.light,
          systemNavigationBarColor: Colors.transparent,
          systemNavigationBarIconBrightness:
              dark ? Brightness.light : Brightness.light,
        ),
        child: const MaterialApp(
          title: 'Foody-Office',
          debugShowCheckedModeBanner: false,
          home: SplashScreen(),
        ),
      );
    });
  }
}
