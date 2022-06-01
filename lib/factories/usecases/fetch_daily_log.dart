import 'package:parking_lot_app/data/usecases/fetch_daily_log/local_fetch_daily_log.dart';
import 'package:parking_lot_app/domain/usecases/fetch_daily_log.dart';
import 'package:parking_lot_app/factories/cache/local_storage_client.dart';

FetchDailyLog makeFetchDailyLog() =>
    LocalFetchDailyLog(client: makeLocalStorageClient());
