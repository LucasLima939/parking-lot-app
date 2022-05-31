import 'package:parking_lot_app/data/local_storage/local_storage_client.dart';
import 'package:parking_lot_app/data/models/interfaces/i_parking_daily_log.dart';
import 'package:parking_lot_app/domain/helpers/errors/domain_error.dart';
import 'package:parking_lot_app/domain/usecases/update_daily_log.dart';

class LocalUpdateDailyLog implements UpdateDailyLog {
  final LocalStorageClient client;
  LocalUpdateDailyLog({required this.client});

  @override
  Future<void> update({required IParkingDailyLog dailyLog}) async {
    try {
      await client.put(key: dailyLog.date, data: dailyLog.toJson());
    } catch (e) {
      throw DomainError.unexpected;
    }
  }
}
