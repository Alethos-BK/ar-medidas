import 'package:flutter/material.dart';
import '../repositories/measurement_repository.dart';
import '../models/measurement.dart';
import 'package:intl/intl.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Measurement> measurements =
        MeasurementRepository().getAllMeasurements();

    return Scaffold(
      appBar: AppBar(title: const Text("Histórico de Medidas")),
      body:
          measurements.isEmpty
              ? const Center(child: Text("Nenhuma medida salva :("))
              : ListView.builder(
                itemCount: measurements.length,
                itemBuilder: (context, index) {
                  final m = measurements[index];
                  return ListTile(
                    title: Text(
                      "${m.totalDistance}",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      DateFormat('dd/MM/yyyy HH:mm').format(m.timestamp),
                    ),
                  );
                },
              ),
    );
  }
}
