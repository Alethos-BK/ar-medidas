import 'package:ar_medidas/services/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../models/measurement.dart';
import '../repositories/measurement_repository.dart';
import '../theme/app_colors.dart';
import '../theme/app_styles.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  HistoryScreenState createState() => HistoryScreenState();
}

class HistoryScreenState extends State<HistoryScreen> {
  late List<Measurement> measurements = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadMeasurements();
  }

  Future<void> _loadMeasurements() async {
    setState(() => _isLoading = true);
    final result = await MeasurementFirebaseService.getAll();
    setState(() {
      measurements = result;
      _isLoading = false;
    });
  }

  void _deleteMeasurement(int index) async {
    final measurementToDelete = measurements[index];

    final confirm = await showDialog<bool>(
      context: context,
      barrierDismissible: true,
      builder:
          (context) => AlertDialog(
            title: Text("Excluir Medida?"),
            content: Text("Essa ação não poderá ser desfeita!"),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: Text("Cancelar"),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: Text("Excluir"),
              ),
            ],
          ),
    );

    if (confirm == true) {
      await MeasurementFirebaseService.removeMeasurement(measurementToDelete);
      setState(() {
        measurements.removeAt(index);
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Medida excluída com sucesso!")));
    }
  }

  void _clearAllMeasurements() async {
    final confirm = await showDialog<bool>(
      context: context,
      barrierDismissible: true,
      builder:
          (context) => AlertDialog(
            title: Text("Limpar Histórico?"),
            content: Text("Essa ação não poderá ser desfeita!"),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: Text("Cancelar"),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: Text("Limpar"),
              ),
            ],
          ),
    );

    if (confirm == true) {
      await MeasurementFirebaseService.clearAllMeasurements();
      setState(() {
        measurements.clear();
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Histórico limpo com sucesso!")));
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: Icon(
                Icons.arrow_back_rounded,
                size: screenWidth > 400 ? 38 : 32,
              ),
              tooltip: 'Retornar',
              onPressed: () => Navigator.pop(context),
            );
          },
        ),
        centerTitle: true,
        title: LayoutBuilder(
          builder: (context, constraints) {
            return Text(
              "Histórico de Medidas",
              style: GoogleFonts.acme(
                color:
                    Theme.of(context).brightness == Brightness.light
                        ? Colors.white
                        : Colors.black,
                fontSize: constraints.maxWidth > 260 ? 24 : 20,
              ),
            );
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.delete_forever_rounded,
              size: screenWidth > 400 ? 38 : 32,
            ),
            tooltip: 'Limpar Todo o Histórico',
            onPressed: _clearAllMeasurements,
          ),
        ],
      ),

      body:
          _isLoading
              ? Center(child: CircularProgressIndicator())
              : measurements.isEmpty
              ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppStyles.infoIcon(context),
                    const SizedBox(height: AppStyles.spacingNormal),
                    Text(
                      "Nenhuma medida salva :(",
                      style: AppStyles.fadedText(context),
                    ),
                  ],
                ),
              )
              : ListView.separated(
                padding: AppStyles.paddingSmall,
                itemCount: measurements.length,
                separatorBuilder:
                    (context, index) =>
                        const SizedBox(height: AppStyles.spacingNormal),
                itemBuilder: (context, index) {
                  final m = measurements[index];
                  return AppStyles.materialCard(
                    context: context,
                    child: ListTile(
                      leading: AppStyles.avatar(
                        context: context,
                        child: AppStyles.straightenIcon(context),
                      ),
                      title: GestureDetector(
                        onLongPress: () {
                          Clipboard.setData(
                            ClipboardData(text: m.totalDistance),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "Distância copiada!",
                                style: GoogleFonts.acme(),
                              ),
                              duration: const Duration(seconds: 2),
                            ),
                          );
                        },
                        child: Text(
                          m.totalDistance,
                          style: AppStyles.listTileTitle(context),
                        ),
                      ),
                      subtitle: Text(
                        DateFormat('dd/MM/yyyy HH:mm').format(m.timestamp),
                        style: AppStyles.listTileSubtitle(context),
                      ),
                      trailing: Tooltip(
                        message: 'Excluir a Medida',
                        child: IconButton(
                          icon: AppStyles.deleteIcon,
                          onPressed: () => _deleteMeasurement(index),
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? AppColors.bambooBase
                                  : AppColors.oregonBase,
                        ),
                      ),
                    ),
                  );
                },
              ),
    );
  }
}
