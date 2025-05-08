import 'package:flutter/material.dart';
import '../screens/ar_screen.dart';
import '../screens/history_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Bem-vindo ao nosso App de Medidas",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Tooltip(
                message: 'Iniciar a Medição',
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ArScreen()),
                    );
                  },
                  icon: const Icon(Icons.camera_alt_rounded, size: 24),
                  label: const Text("Iniciar Medição"),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                ),
              ),
              const SizedBox(height: 20),
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
                  icon: const Icon(Icons.history_rounded, size: 24),
                  label: const Text("Acessar Histórico"),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                    textStyle: const TextStyle(fontSize: 18),
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
