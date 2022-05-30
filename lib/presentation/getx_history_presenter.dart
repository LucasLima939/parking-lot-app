import 'package:get/get.dart';
import 'package:parking_lot_app/ui/helpers/error/ui_error.dart';
import 'package:parking_lot_app/data/models/interfaces/i_parking_daily_log.dart';
import 'package:parking_lot_app/ui/pages/history/history_presenter.dart';

class GetxHistoryPresenter extends GetxController implements HistoryPresenter {
  @override
  // TODO: implement errorStream
  Stream<UiError> get errorStream => throw UnimplementedError();

  @override
  Future<IParkingDailyLog> fetchDailyParkingLot(
      {required String formattedDate}) {
    // TODO: implement fetchDailyParkingLot
    throw UnimplementedError();
  }

  @override
  // TODO: implement isLoadingStream
  Stream<bool> get isLoadingStream => throw UnimplementedError();
}
