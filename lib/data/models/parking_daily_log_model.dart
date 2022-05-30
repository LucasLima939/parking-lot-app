import 'package:intl/intl.dart';
import 'package:parking_lot_app/data/models/interfaces/i_parking_daily_log.dart';
import 'package:parking_lot_app/data/models/interfaces/i_vehicle_log.dart';

class ParkingDailyLogModel implements IParkingDailyLog {
  ParkingDailyLogModel(this.totalSpots, this.availableSpots);

  @override
  final int totalSpots;

  @override
  final int availableSpots;

  @override
  final String date = DateFormat('dd/MM/yyyy HH:mm').format(DateTime.now());

  @override
  List<IVehicleLog>? dailyHistory;

  @override
  List<IVehicleLog>? occupiedSpots;

  @override
  void entrance(IVehicleLog vehicle) {
    occupiedSpots ??= <IVehicleLog>[];
    occupiedSpots?.add(vehicle);
  }

  @override
  void exit(IVehicleLog vehicle) {
    occupiedSpots?.remove(vehicle);
    vehicle.exitTime = DateTime.now().millisecondsSinceEpoch;
    dailyHistory?.add(vehicle);
  }
}
