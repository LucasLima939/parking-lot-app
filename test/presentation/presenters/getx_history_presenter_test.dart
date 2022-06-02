import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:parking_lot_app/data/models/interfaces/i_parking_daily_log.dart';
import 'package:parking_lot_app/data/models/parking_daily_log_model.dart';
import 'package:parking_lot_app/domain/helpers/errors/domain_error.dart';
import 'package:parking_lot_app/presentation/presenters/getx_history_presenter.dart';
import 'package:parking_lot_app/ui/helpers/message/ui_error.dart';

import '../../mock/fetch_daily_log_spy.dart';
import '../../mock/mock_model_collection.dart';

void main() {
  late GetxHistoryPresenter sut;
  late FetchDailyLogSpy fetchDailyLog;
  late IParkingDailyLog parkingDailyLog;

  setUp(() {
    parkingDailyLog =
        ParkingDailyLogModel.fromJson(MockModelCollection.dailyLogJson);
    fetchDailyLog = FetchDailyLogSpy();
    sut = GetxHistoryPresenter(fetchDailyLog: fetchDailyLog);

    fetchDailyLog.mockRequest(parkingDailyLog);
  });

  setUpAll(() {
    registerFallbackValue(MockModelCollection.dailyLogJson);
  });

  test('Should call method correctly', () async {
    await sut.fetchDailyParkingLot(
        formattedDate: MockModelCollection.formattedDate);

    verify(() => fetchDailyLog.fetch(
        formattedDate: MockModelCollection.formattedDate)).called(1);
  });
  test('Should emit correct events if method has no errors', () async {
    expect(sut.messageStream, emitsInOrder([UiMessage.none]));
    expect(sut.isLoadingStream, emitsInOrder([true, false]));
    expect(sut.parkingDailyLogStream, emitsInOrder([parkingDailyLog]));

    await sut.fetchDailyParkingLot(
        formattedDate: MockModelCollection.formattedDate);
  });
  test('Should emit error if method throws DomainError.exception', () async {
    fetchDailyLog.mockError(DomainError.unexpected);

    expect(sut.messageStream,
        emitsInOrder([UiMessage.none, UiMessage.unexpected]));
    expect(sut.isLoadingStream, emitsInOrder([true, false]));

    await sut.fetchDailyParkingLot(
        formattedDate: MockModelCollection.formattedDate);
  });
}
