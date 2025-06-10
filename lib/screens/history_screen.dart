import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
          elevation: 4,
          shadowColor: Theme.of(context).brightness == Brightness.light
              ? Colors.black.withAlpha((0.2 * 255).toInt())
              : Colors.white.withAlpha((0.2 * 255).toInt()),
          insetPadding: EdgeInsets.all(17),
          title: Row(
            children: [
              AppStyles.warningIcon(context),
              SizedBox(width: AppStyles.spacingNormal),
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
                      backgroundColor:
                          Theme.of(context).brightness == Brightness.light
                          ? AppColors.cornBase
                          : AppColors.cornShades[7],
                      shadowColor:
                          Theme.of(context).brightness == Brightness.light
                          ? Colors.black.withAlpha((0.2 * 255).toInt())
                          : Colors.white.withAlpha((0.2 * 255).toInt()),
                    ),
                  ),
                ),
                const SizedBox(width: AppStyles.spacingNormal),
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
                      backgroundColor:
                          Theme.of(context).brightness == Brightness.light
                          ? AppColors.bambooBase
                          : AppColors.oregonBase,
                      shadowColor:
                          Theme.of(context).brightness == Brightness.light
                          ? Colors.black.withAlpha((0.2 * 255).toInt())
                          : Colors.white.withAlpha((0.2 * 255).toInt()),
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
          insetPadding: EdgeInsets.all(17),
          title: Row(
            children: [
              AppStyles.warningIcon(context),
              SizedBox(width: AppStyles.spacingNormal),
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
                      backgroundColor:
                          Theme.of(context).brightness == Brightness.light
                          ? AppColors.cornBase
                          : AppColors.cornShades[7],
                      shadowColor:
                          Theme.of(context).brightness == Brightness.light
                          ? Colors.black.withAlpha((0.2 * 255).toInt())
                          : Colors.white.withAlpha((0.2 * 255).toInt()),
                    ),
                  ),
                ),
                const SizedBox(width: AppStyles.spacingNormal),
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
                      backgroundColor:
                          Theme.of(context).brightness == Brightness.light
                          ? AppColors.bambooBase
                          : AppColors.oregonBase,
                      shadowColor:
                          Theme.of(context).brightness == Brightness.light
                          ? Colors.black.withAlpha((0.2 * 255).toInt())
                          : Colors.white.withAlpha((0.2 * 255).toInt()),
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
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) {
            final screenWidth = MediaQuery.of(context).size.width;
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
              style: TextStyle(
                color: Theme.of(context).brightness == Brightness.light
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
      body: measurements.isEmpty
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
              separatorBuilder: (context, index) =>
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
                        color: Theme.of(context).brightness == Brightness.light
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
