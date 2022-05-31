abstract class IVehicleLog {
  String get licensePlate;
  int get entranceTime;
  String get occupiedSpot;
  int? exitTime;

  Map<String, dynamic> toJson();
}
