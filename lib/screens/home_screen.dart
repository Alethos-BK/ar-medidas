import 'package:flutter/material.dart';
import '../screens/ar_screen.dart';
import '../screens/history_screen.dart';
import '../theme/app_colors.dart';
import '../theme/app_styles.dart';

class HomeScreen extends StatelessWidget {
  final VoidCallback onThemeToggle;

  const HomeScreen({super.key, required this.onThemeToggle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'AR Medidas',
          style: TextStyle(
            color: Theme.of(context).brightness == Brightness.light
                ? Colors.white
                : Colors.black,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Theme.of(context).brightness == Brightness.light
                  ? Icons.dark_mode_rounded
                  : Icons.light_mode_rounded,
              size: 30,
            ),
            tooltip: 'Mudar Tema (Claro/Escuro)',
            onPressed: () {
              onThemeToggle();
            },
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: AppStyles.paddingBig,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Bem-vindo ao nosso App de Medidas",
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppStyles.spacingLarge),
              Tooltip(
                message: 'Iniciar a Medição',
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ArScreen()),
                    );
                  },
                  icon: AppStyles.cameraIcon,
                  label: const Text("Iniciar Medição"),
                  style: ElevatedButton.styleFrom(
                    textStyle: AppStyles.buttonText,
                  ),
                ),
              ),
              const SizedBox(height: AppStyles.spacingMedium),
              Tooltip(
                message: 'Acessar Histórico de Medições',
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HistoryScreen(),
                      ),
                    );
                  },
                  icon: Icon(Icons.history_rounded, size: 30),
                  label: const Text("Acessar Histórico"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Theme.of(context).brightness == Brightness.light
                        ? AppColors.bambooBase
                        : AppColors.oregonBase,
                    textStyle: AppStyles.buttonText,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
