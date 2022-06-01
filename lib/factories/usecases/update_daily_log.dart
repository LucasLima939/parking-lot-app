import 'package:parking_lot_app/data/usecases/update_daily_log/local_update_daily_log.dart';
import 'package:parking_lot_app/domain/usecases/update_daily_log.dart';
import 'package:parking_lot_app/factories/cache/local_storage_client.dart';

UpdateDailyLog makeUpdateDailyLog() =>
    LocalUpdateDailyLog(client: makeLocalStorageClient());
