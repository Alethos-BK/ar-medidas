import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
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
          title: const Text(
            "Confirmar a Exclusão?",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: const Text("Essa ação não poderá ser desfeita!"),
          insetPadding: EdgeInsets.all(25),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Tooltip(
                  message: 'Cancelar a Exclusão',
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("Cancelar"),
                  ),
                ),
                const SizedBox(width: 8),
                Tooltip(
                  message: 'Excluir Medida do Histórico',
                  child: TextButton(
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
                          behavior: SnackBarBehavior.floating,
                          duration: Duration(seconds: 2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      );
                    },
                    child: const Text("Excluir"),
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
          title: const Text(
            "Confirmar a Limpeza?",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: const Text(
            "Isso apagará todo o histórico!\nEssa ação não poderá ser desfeita!",
          ),
          insetPadding: EdgeInsets.all(25),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Tooltip(
                  message: 'Cancelar a Limpeza',
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("Cancelar"),
                  ),
                ),
                const SizedBox(width: 8),
                Tooltip(
                  message: 'Limpar Todo o Histórico',
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        MeasurementRepository().clearAllMeasurements();
                        measurements.clear();
                      });
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Histórico limpo com sucesso!"),
                          behavior: SnackBarBehavior.floating,
                          duration: Duration(seconds: 3),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      );
                    },
                    child: const Text("Limpar Histórico"),
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
          icon: Icon(Icons.arrow_back_rounded),
          tooltip: 'Retornar',
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Histórico de Medidas"),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_forever_rounded),
            tooltip: 'Limpar Todo o Histórico',
            onPressed: _clearAllMeasurements,
          ),
        ],
      ),
      body:
          measurements.isEmpty
              ? Center(
                child: Text(
                  "Nenhuma medida salva :(",
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withAlpha((0.6 * 255).toInt()),
                  ),
                ),
              )
              : ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: measurements.length,
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (context, index) {
                  final m = measurements[index];
                  return ListTile(
                    leading: const Icon(Icons.straighten_rounded),
                    title: GestureDetector(
                      onLongPress: () {
                        Clipboard.setData(ClipboardData(text: m.totalDistance));
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text("Distância copiada!"),
                            duration: const Duration(seconds: 2),
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                        );
                      },
                      child: Text(
                        m.totalDistance,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    subtitle: Text(
                      DateFormat('dd/MM/yyyy HH:mm').format(m.timestamp),
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurface.withAlpha((0.6 * 255).toInt()),
                      ),
                    ),
                    trailing: Tooltip(
                      message: 'Excluir Medida',
                      child: IconButton(
                        icon: const Icon(Icons.delete_rounded),
                        onPressed: () => _deleteMeasurement(index),
                      ),
                    ),
                  );
                },
              ),
    );
  }
}
