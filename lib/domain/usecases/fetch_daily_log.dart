import 'package:parking_lot_app/data/models/interfaces/i_parking_daily_log.dart';

abstract class FetchDailyLog {
  Future<IParkingDailyLog> fetch({required String formattedDate});
}
