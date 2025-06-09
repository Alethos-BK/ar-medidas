import 'package:ar_medidas/theme/app_themes.dart';
import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.system;

  void _toggleTheme() {
    setState(() {
      if (_themeMode == ThemeMode.light) {
        _themeMode = ThemeMode.dark;
      } else {
        _themeMode = ThemeMode.light;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AR Medidas',
      debugShowCheckedModeBanner: false,
      theme: appThemeLight,
      darkTheme: appDarkTheme,
      themeMode: _themeMode,
      home: HomeScreen(onThemeToggle: _toggleTheme),
    );
  }
}
