import 'i_vehicle_log.dart';

abstract class IParkingDailyLog {
  final String date;
  final int totalSpots;
  final int availableSpots;
  List<IVehicleLog>? occupiedSpots;
  List<IVehicleLog>? dailyHistory;

  void entrance(IVehicleLog vehicle);
  void exit(IVehicleLog vehicle);

  IParkingDailyLog(this.availableSpots, this.date, this.totalSpots);
}
