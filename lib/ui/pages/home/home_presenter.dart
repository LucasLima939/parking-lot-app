import 'package:parking_lot_app/data/models/interfaces/i_parking_daily_log.dart';
import 'package:parking_lot_app/ui/helpers/message/ui_error.dart';

abstract class HomePresenter {
  Stream<bool> get isLoadingStream;
  Stream<UiError> get messageStream;

  Future<IParkingDailyLog?> fetchDailyParkingLot();
  Future<bool> createEntrance(
      {required String license,
      required String spot,
      required int entranceTimestamp});
  Future<bool> createExit({required String spot, required int exitTimestamp});
}
