import 'package:parking_lot_app/data/models/interfaces/i_parking_daily_log.dart';
import 'package:parking_lot_app/ui/helpers/error/ui_error.dart';

abstract class HomePresenter {
  Stream<bool> get isLoadingStream;
  Stream<UiError> get errorStream;

  Future<IParkingDailyLog> fetchDailyParkingLot();
  Future<void> createEntrance({required String license, required String spot});
  Future<void> createExit({required String spot});
}
