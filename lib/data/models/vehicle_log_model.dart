import 'package:parking_lot_app/data/models/interfaces/i_vehicle_log.dart';
import 'package:equatable/equatable.dart';

class VehicleLogModel with EquatableMixin implements IVehicleLog {
  VehicleLogModel(this.entranceTime, this.licensePlate, this.occupiedSpot);

  @override
  int? exitTime;

  @override
  final int entranceTime;

  @override
  final String licensePlate;

  @override
  final String occupiedSpot;

  @override
  VehicleLogModel.fromJson(Map<String, dynamic> json)
      : licensePlate = json['license_plate'],
        entranceTime = json['entrance_time'],
        occupiedSpot = json['occupied_spot'],
        exitTime = json['exit_time'];

  @override
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['exit_time'] = exitTime;
    data['entrance_time'] = entranceTime;
    data['license_plate'] = licensePlate;
    data['occupied_spot'] = occupiedSpot;
    return data;
  }

  @override
  List<Object?> get props =>
      [exitTime, entranceTime, licensePlate, occupiedSpot];
}
