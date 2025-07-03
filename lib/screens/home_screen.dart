import 'package:ar_medidas/screens/about_sreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
          style: GoogleFonts.acme(
            color:
                Theme.of(context).brightness == Brightness.light
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
              Material(
                elevation: 4,
                shape: CircleBorder(),
                shadowColor:
                    Theme.of(context).brightness == Brightness.light
                        ? Colors.black.withAlpha((0.2 * 255).toInt())
                        : Colors.white.withAlpha((0.2 * 255).toInt()),
                child: ClipOval(
                  child: Image.asset(
                    'assets/Image.png',
                    width: 125,
                    height: 125,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: AppStyles.spacingMedium),
              Text(
                "Bem-vindo ao nosso App de Medidas",
                style: AppStyles.containerText(context),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppStyles.spacingLarge),
              Tooltip(
                message: 'Iniciar a Mediçãoo',
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ArScreen()),
                    );
                  },
                  icon: AppStyles.cameraIcon,
                  label: Text("Iniciar Medição", style: GoogleFonts.acme()),
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
                  label: Text("Acessar Histórico", style: GoogleFonts.acme()),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Theme.of(context).brightness == Brightness.light
                            ? AppColors.bambooBase
                            : AppColors.oregonBase,
                    textStyle: AppStyles.buttonText,
                  ),
                ),
              ),
              const SizedBox(height: AppStyles.spacingMedium),
              Tooltip(
                message: 'Ver informações sobre o app',
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AboutScreen(),
                      ),
                    );
                  },
                  icon: Icon(Icons.info_outline_rounded, size: 30),
                  label: Text("Sobre o App", style: GoogleFonts.acme()),
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
