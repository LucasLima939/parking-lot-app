class MockModelCollection {
  static const totalSpots = 16;
  static const availableSpots = 16;
  static const formattedDate = '31/06/2022';
  static const licensePlate = 'PKSG-1921';
  static const occupiedSpot = 'C3';
  static final entranceTimestamp = DateTime.now().millisecondsSinceEpoch;
  static final exitTimestamp = DateTime.now().millisecondsSinceEpoch;
  static final dailyLogJson = <String, dynamic>{
    'total_spots': totalSpots,
    'available_spots': availableSpots,
    'date': formattedDate,
    'occupied_spots': [
      <String, dynamic>{
        'entrance_time': entranceTimestamp,
        'license_plate': licensePlate,
        'occupied_spot': occupiedSpot,
      }
    ],
  };
  static final occupiedSpotVehicle = <String, dynamic>{
    'entrance_time': entranceTimestamp,
    'license_plate': licensePlate,
    'occupied_spot': occupiedSpot,
  };
  static final historySpotVehicle =
      Map<String, dynamic>.from(occupiedSpotVehicle)
        ..addAll(<String, dynamic>{'exit_time': exitTimestamp});
}
