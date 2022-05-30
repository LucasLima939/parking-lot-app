import 'package:parking_lot_app/data/models/interfaces/i_vehicle_log.dart';

class VehicleLogModel implements IVehicleLog {
  VehicleLogModel(this.entranceTime, this.licensePlate, this.occupiedSpot);

  @override
  int? exitTime;

  @override
  final int entranceTime;

  @override
  final String licensePlate;

  @override
  final String occupiedSpot;
}
