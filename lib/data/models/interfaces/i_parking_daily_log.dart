import 'i_vehicle_log.dart';

abstract class IParkingDailyLog {
  String get date;
  int get totalSpots;
  int get availableSpots;
  List<IVehicleLog>? occupiedSpots;
  List<IVehicleLog>? dailyHistory;

  void entrance(IVehicleLog vehicle);
  void exit(IVehicleLog vehicle);
  Map<String, dynamic> toJson();
}
