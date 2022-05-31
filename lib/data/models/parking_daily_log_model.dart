import 'package:intl/intl.dart';
import 'package:parking_lot_app/data/models/interfaces/i_parking_daily_log.dart';
import 'package:parking_lot_app/data/models/interfaces/i_vehicle_log.dart';

class ParkingDailyLogModel implements IParkingDailyLog {
  ParkingDailyLogModel({required this.totalSpots, required this.availableSpots})
      : date = DateFormat('dd/MM/yyyy').format(DateTime.now());

  @override
  final int totalSpots;

  @override
  final int availableSpots;

  @override
  final String date;

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
    final _isRemoved = occupiedSpots?.remove(vehicle) ?? false;
    if (_isRemoved) {
      vehicle.exitTime = DateTime.now().millisecondsSinceEpoch;
      dailyHistory?.add(vehicle);
    }
  }

  ParkingDailyLogModel.fromJson(Map<String, dynamic> json)
      : totalSpots = json['total_spots'],
        availableSpots = json['available_spots'],
        date = json['date'],
        dailyHistory = json['daily_history'],
        occupiedSpots = json['occupied_spots'];

  @override
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['total_spots'] = totalSpots;
    data['available_spots'] = availableSpots;
    data['date'] = date;
    data['daily_history'] = dailyHistory;
    data['occupied_spots'] = occupiedSpots;
    return data;
  }
}
