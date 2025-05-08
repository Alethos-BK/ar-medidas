import 'package:flutter/material.dart';
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
    setState(() {
      measurements.removeAt(index);
    });
    MeasurementRepository().deleteMeasurement(measurementToDelete);
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
                    leading: const Icon(Icons.straighten),
                    title: Text(
                      m.totalDistance,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
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
                        icon: const Icon(Icons.delete),
                        onPressed: () => _deleteMeasurement(index),
                      ),
                    ),
                  );
                },
              ),
    );
  }
}
