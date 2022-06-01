import 'package:parking_lot_app/data/models/interfaces/i_parking_daily_log.dart';
import 'package:parking_lot_app/ui/helpers/message/ui_error.dart';

abstract class HistoryPresenter {
  Stream<bool> get isLoadingStream;
  Stream<UiMessage> get errorStream;

  Future<IParkingDailyLog> fetchDailyParkingLot(
      {required String formattedDate});
}
