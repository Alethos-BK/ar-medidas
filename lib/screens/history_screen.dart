import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:ar_medidas/theme.dart';
import '../models/measurement.dart';
import '../repositories/measurement_repository.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  HistoryScreenState createState() => HistoryScreenState();
}

class HistoryScreenState extends State<HistoryScreen> {
  late List<Measurement> measurements;

  @override
  void initState() {
    super.initState();
    measurements = MeasurementRepository().getAllMeasurements();
  }

  void _deleteMeasurement(int index) {
    final Measurement measurementToDelete = measurements[index];

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              AppStyles.warningIcon,
              SizedBox(width: AppStyles.spacingSmall),
              Text(
                "Excluir a Medida?",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
          content: Text(
            "Essa ação não poderá ser desfeita!",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Tooltip(
                  message: 'Cancelar a Exclusão',
                  child: TextButton.icon(
                    icon: AppStyles.cancelIcon,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    label: const Text("Cancelar"),
                    style: TextButton.styleFrom(
                      backgroundColor: AppColors.cornBase,
                    ),
                  ),
                ),
                const SizedBox(width: AppStyles.spacingSmall),
                Tooltip(
                  message: 'Excluir Medida do Histórico',
                  child: TextButton.icon(
                    icon: AppStyles.deleteIcon,
                    onPressed: () {
                      setState(() {
                        measurements.removeAt(index);
                      });
                      MeasurementRepository().deleteMeasurement(
                        measurementToDelete,
                      );
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Medida excluída com sucesso!"),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    },
                    label: const Text("Excluir"),
                    style: TextButton.styleFrom(
                      backgroundColor: AppColors.bambooBase,
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  void _clearAllMeasurements() {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              AppStyles.warningIcon,
              SizedBox(width: AppStyles.spacingSmall),
              Text(
                "Limpar Histórico?",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
          content: Text(
            "Isso apagará todo o histórico!\nEssa ação não poderá ser desfeita!",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Tooltip(
                  message: 'Cancelar a Limpeza',
                  child: TextButton.icon(
                    icon: AppStyles.cancelIcon,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    label: const Text("Cancelar"),
                    style: TextButton.styleFrom(
                      backgroundColor: AppColors.cornBase,
                    ),
                  ),
                ),
                const SizedBox(width: AppStyles.spacingSmall),
                Tooltip(
                  message: 'Limpar Todo o Histórico',
                  child: TextButton.icon(
                    icon: AppStyles.deleteForeverIcon,
                    onPressed: () {
                      setState(() {
                        MeasurementRepository().clearAllMeasurements();
                        measurements.clear();
                      });
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Histórico limpo com sucesso!"),
                          duration: Duration(seconds: 3),
                        ),
                      );
                    },
                    label: const Text("Limpar"),
                    style: TextButton.styleFrom(
                      backgroundColor: AppColors.bambooBase,
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: AppStyles.backIcon,
          tooltip: 'Retornar',
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Histórico-Medidas",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: AppStyles.deleteForeverIcon,
            tooltip: 'Limpar Todo o Histórico',
            onPressed: _clearAllMeasurements,
          ),
        ],
      ),
      body: measurements.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppStyles.infoIcon,
                  const SizedBox(height: AppStyles.spacingNormal),
                  Text("Nenhuma medida salva :(", style: AppStyles.fadedText),
                ],
              ),
            )
          : ListView.separated(
              padding: AppStyles.paddingSmall,
              itemCount: measurements.length,
              separatorBuilder: (context, index) =>
                  const SizedBox(height: AppStyles.spacingNormal),
              itemBuilder: (context, index) {
                final m = measurements[index];
                return AppStyles.materialCard(
                  child: ListTile(
                    leading: AppStyles.avatar(child: AppStyles.straightenIcon),
                    title: GestureDetector(
                      onLongPress: () {
                        Clipboard.setData(ClipboardData(text: m.totalDistance));
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text("Distância copiada!"),
                            duration: const Duration(seconds: 2),
                          ),
                        );
                      },
                      child: Text(
                        m.totalDistance,
                        style: AppStyles.listTileTitle,
                      ),
                    ),
                    subtitle: Text(
                      DateFormat('dd/MM/yyyy HH:mm').format(m.timestamp),
                      style: AppStyles.listTileSubtitle,
                    ),
                    trailing: Tooltip(
                      message: 'Excluir Medida',
                      child: IconButton(
                        icon: AppStyles.deleteIcon,
                        onPressed: () => _deleteMeasurement(index),
                        color: AppColors.bambooBase,
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
