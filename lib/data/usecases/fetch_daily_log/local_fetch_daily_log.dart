import 'package:parking_lot_app/data/local_storage/local_storage_client.dart';
import 'package:parking_lot_app/data/models/interfaces/i_parking_daily_log.dart';
import 'package:parking_lot_app/domain/usecases/fetch_daily_log.dart';

class LocalFetchDailyLog implements FetchDailyLog {
  final LocalStorageClient client;
  LocalFetchDailyLog({required this.client});

  @override
  Future<IParkingDailyLog> fetch({required String formattedDate}) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
