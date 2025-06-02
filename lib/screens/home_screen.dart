import 'package:flutter/material.dart';
import 'package:ar_medidas/theme.dart';
import '../screens/ar_screen.dart';
import '../screens/history_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  icon: AppStyles.historyIcon,
                  label: const Text("Acessar Histórico"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.bambooBase,
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
