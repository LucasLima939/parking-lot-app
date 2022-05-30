abstract class IVehicleLog {
  final String licensePlate;
  final int entranceTime;
  final String occupiedSpot;
  int? exitTime;

  IVehicleLog(this.entranceTime, this.licensePlate, this.occupiedSpot);
}
