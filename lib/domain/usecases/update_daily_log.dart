import 'package:parking_lot_app/data/models/interfaces/i_parking_daily_log.dart';

abstract class UpdateDailyLog {
  Future<void> update({required IParkingDailyLog dailyLog});
}
