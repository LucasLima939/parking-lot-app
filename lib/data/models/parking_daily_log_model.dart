import 'package:intl/intl.dart';
import 'package:parking_lot_app/data/models/interfaces/i_parking_daily_log.dart';
import 'package:parking_lot_app/data/models/interfaces/i_vehicle_log.dart';
import 'package:equatable/equatable.dart';
import 'package:parking_lot_app/data/models/vehicle_log_model.dart';

class ParkingDailyLogModel with EquatableMixin implements IParkingDailyLog {
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
        dailyHistory = json['daily_history'] == null
            ? null
            : List<Map<String, dynamic>>.from(json['daily_history'])
                .map((json) => VehicleLogModel.fromJson(json))
                .toList(),
        occupiedSpots = json['occupied_spots'] == null
            ? null
            : List<Map<String, dynamic>>.from(json['occupied_spots'])
                .map((json) => VehicleLogModel.fromJson(json))
                .toList();

  @override
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['total_spots'] = totalSpots;
    data['available_spots'] = availableSpots;
    data['date'] = date;
    data['daily_history'] = dailyHistory?.map((obj) => obj.toJson()).toList();
    data['occupied_spots'] = occupiedSpots?.map((obj) => obj.toJson()).toList();
    return data;
  }

  @override
  List<Object?> get props =>
      [totalSpots, availableSpots, date, dailyHistory, occupiedSpots];
}
