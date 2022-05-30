import 'package:get/get.dart';
import 'package:parking_lot_app/ui/helpers/error/ui_error.dart';
import 'package:parking_lot_app/data/models/interfaces/i_parking_daily_log.dart';
import 'package:parking_lot_app/ui/pages/home/home_presenter.dart';

class GetxHomePresenter extends GetxController implements HomePresenter {
  @override
  Future<void> createEntrance({required String license, required String spot}) {
    // TODO: implement createEntrance
    throw UnimplementedError();
  }

  @override
  Future<void> createExit({required String spot}) {
    // TODO: implement createExit
    throw UnimplementedError();
  }

  @override
  // TODO: implement errorStream
  Stream<UiError> get errorStream => throw UnimplementedError();

  @override
  Future<IParkingDailyLog> fetchDailyParkingLot() {
    // TODO: implement fetchDailyParkingLot
    throw UnimplementedError();
  }

  @override
  // TODO: implement isLoadingStream
  Stream<bool> get isLoadingStream => throw UnimplementedError();
}
