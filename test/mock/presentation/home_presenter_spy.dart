import 'dart:async';

import 'package:mocktail/mocktail.dart';
import 'package:parking_lot_app/data/models/parking_daily_log_model.dart';
import 'package:parking_lot_app/ui/helpers/message/ui_error.dart';
import 'package:parking_lot_app/ui/pages/home/home_presenter.dart';

import '../mock_model_collection.dart';

class HomePresenterSpy extends Mock implements HomePresenter {
  Stream<UiError> get messageStream => StreamController<UiError>().stream;

  mockFetchError() {
    when((() => fetchDailyParkingLot())).thenAnswer((_) async => null);
  }

  mockFetchSuccess() {
    when((() => fetchDailyParkingLot())).thenAnswer((_) async =>
        ParkingDailyLogModel.fromJson(MockModelCollection.dailyLogJson));
  }
}
