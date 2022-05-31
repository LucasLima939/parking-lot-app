import 'package:parking_lot_app/data/local_storage/local_storage_client.dart';
import 'package:parking_lot_app/data/models/interfaces/i_parking_daily_log.dart';
import 'package:parking_lot_app/data/models/parking_daily_log_model.dart';
import 'package:parking_lot_app/domain/helpers/errors/domain_error.dart';
import 'package:parking_lot_app/domain/usecases/fetch_daily_log.dart';

class LocalFetchDailyLog implements FetchDailyLog {
  final LocalStorageClient client;
  LocalFetchDailyLog({required this.client});

  @override
  Future<IParkingDailyLog> fetch({required String formattedDate}) async {
    try {
      final response = await client.get(key: formattedDate);
      if (response == null) throw DomainError.noRegister;
      return ParkingDailyLogModel.fromJson(response);
    } on DomainError {
      rethrow;
    } catch (e) {
      throw DomainError.unexpected;
    }
  }
}
