import 'package:ar_medidas/theme.dart';
import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AR Medidas',
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      themeMode: ThemeMode.system,
      home: const HomeScreen(),
    );
  }
}
