import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../theme/app_colors.dart';
import '../theme/app_styles.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  String appName = "AR Medidas";
  String version = "Desconhecida";

  @override
  void initState() {
    super.initState();
    _loadPackageInfo();
  }

  Future<void> _loadPackageInfo() async {
    try {
      final info = await PackageInfo.fromPlatform();
      setState(() {
        version = "${info.version}+${info.buildNumber}";
      });
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sobre o App',
          style: GoogleFonts.acme(
            color:
                Theme.of(context).brightness == Brightness.light
                    ? Colors.white
                    : Colors.black,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: AppStyles.backIcon,
          tooltip: 'Voltar',
          onPressed: () => Navigator.pop(context),
        ),
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
              Text('AR Medidas', style: AppStyles.containerText(context)),
              const SizedBox(height: AppStyles.spacingNormal),
              Text('Versão: $version', style: AppStyles.containerText(context)),
              const SizedBox(height: AppStyles.spacingLarge),
              Text(
                'Este aplicativo utiliza realidade aumentada para ajudar você a fazer medições espaciais precisas em tempo real. Foi desenvolvido como parte de um projeto de estudo, com foco em acessibilidade e simplicidade.',
                style: AppStyles.containerText(context),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppStyles.spacingLarge),
              Tooltip(
                message: 'Voltar para a tela inicial',
                child: ElevatedButton.icon(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.arrow_back_rounded, size: 30),
                  label: Text("Voltar", style: GoogleFonts.acme()),
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
