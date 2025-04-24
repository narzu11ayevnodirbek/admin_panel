import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:admin_panel/views/screens/login/login_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    // theme: ThemeData(
    //   pageTransitionsTheme: PageTransitionsTheme(
    //     builders: Map<TargetPlatform, PageTransitionsBuilder>.fromIterable(
    //       TargetPlatform.values,
    //       value: (_) => FadeForwardsPageTransitionsBuilder(),
    //     ),
    //   ),
    // ),
    // home: MainScreen(),

    return AdaptiveTheme(
      light: ThemeData(),
      dark: ThemeData.dark(),
      initial: AdaptiveThemeMode.system,
      builder: (light, dark) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: light,
          darkTheme: dark,
          home: LoginScreen(),
        );
      },
    );
  }
}
