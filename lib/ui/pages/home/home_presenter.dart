import 'package:flutter/scheduler.dart';
import 'package:parking_lot_app/data/models/interfaces/i_parking_daily_log.dart';
import 'package:parking_lot_app/ui/helpers/message/ui_error.dart';

abstract class HomePresenter {
  Stream<bool> get isLoadingStream;
  Stream<UiMessage> get messageStream;

  Future<IParkingDailyLog?> fetchDailyParkingLot();
  Future<void> createEntrance(
      {required String license,
      required String spot,
      required int entranceTimestamp,
      required VoidCallback onSuccess});
  Future<void> createExit(
      {required String spot,
      required int exitTimestamp,
      required VoidCallback onSuccess});
}
