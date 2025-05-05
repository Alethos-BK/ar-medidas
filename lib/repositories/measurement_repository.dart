import '../models/measurement.dart';

class MeasurementRepository {
  static final MeasurementRepository _instance =
      MeasurementRepository._internal();
  final List<Measurement> _measurements = [];

  factory MeasurementRepository() {
    return _instance;
  }

  MeasurementRepository._internal();

  void addMeasurement(Measurement measurement) {
    _measurements.add(measurement);
  }

  List<Measurement> getAllMeasurements() {
    return _measurements.reversed.toList();
  }
}
