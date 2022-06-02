import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:parking_lot_app/data/models/parking_daily_log_model.dart';
import 'package:parking_lot_app/domain/helpers/errors/domain_error.dart';
import 'package:parking_lot_app/presentation/presenters/getx_home_presenter.dart';
import 'package:parking_lot_app/ui/helpers/message/ui_error.dart';

import '../../mock/fetch_daily_log_spy.dart';
import '../../mock/mock_model_collection.dart';
import '../../mock/update_daily_log_spy.dart';

void main() {
  late GetxHomePresenter sut;
  late FetchDailyLogSpy fetchDailyLog;
  late UpdateDailyLogSpy updateDailyLog;
  late int entranceTimestamp;
  late int exitTimestamp;
  late String licensePlate;
  late String occupiedSpot;
  late ParkingDailyLogModel dailyLog;

  setUp(() {
    entranceTimestamp = MockModelCollection.entranceTimestamp;
    dailyLog = ParkingDailyLogModel.fromJson(MockModelCollection.dailyLogJson);
    licensePlate = MockModelCollection.licensePlate;
    occupiedSpot = MockModelCollection.occupiedSpot;
    exitTimestamp = MockModelCollection.exitTimestamp;
    fetchDailyLog = FetchDailyLogSpy();
    updateDailyLog = UpdateDailyLogSpy();
    sut = GetxHomePresenter(
        fetchDailyLog: fetchDailyLog,
        updateDailyLog: updateDailyLog,
        formattedDate: MockModelCollection.formattedDate);

    fetchDailyLog.mockRequest(dailyLog);
    updateDailyLog.mockRequest();
  });

  setUpAll(() {
    registerFallbackValue(
        ParkingDailyLogModel.fromJson(MockModelCollection.dailyLogJson));
  });

  group('Create new entrance', () {
    test('Should call method correctly', () async {
      expect(sut.isLoadingStream, emitsInOrder([true, false]));

      final _dailyLog =
          Map<String, dynamic>.from(MockModelCollection.dailyLogJson)
            ..['occupied_spots'].add(MockModelCollection.occupiedSpotVehicle);

      await sut.createEntrance(
        entranceTimestamp: entranceTimestamp,
        license: licensePlate,
        spot: occupiedSpot,
      );

      verify(() => updateDailyLog.update(
          dailyLog: ParkingDailyLogModel.fromJson(_dailyLog))).called(1);
    });

    test('Should emit UiMessage.created if success', () async {
      expect(sut.isLoadingStream, emitsInOrder([true, false]));
      expect(
          sut.messageStream, emitsInOrder([UiMessage.none, UiMessage.created]));

      await sut.createEntrance(
        entranceTimestamp: entranceTimestamp,
        license: licensePlate,
        spot: occupiedSpot,
      );
    });

    test(
        'Should emit UiMessage.unexpected if method throws DomainError.unexpected',
        () async {
      updateDailyLog.mockError(DomainError.unexpected);

      expect(sut.isLoadingStream, emitsInOrder([true, false]));
      expect(sut.messageStream,
          emitsInOrder([UiMessage.none, UiMessage.unexpected]));

      await sut.createEntrance(
        entranceTimestamp: entranceTimestamp,
        license: licensePlate,
        spot: occupiedSpot,
      );
    });
  });
  group('Create new exit', () {
    test('Should call method correctly', () async {
      expect(sut.isLoadingStream, emitsInOrder([true, false]));

      final _dailyLog = Map<String, dynamic>.from(dailyLog.toJson())
        ..addAll({
          'daily_history': [
            Map<String, dynamic>.from(MockModelCollection.occupiedSpotVehicle)
              ..addAll(<String, dynamic>{'exit_time': exitTimestamp})
          ]
        })
        ..['occupied_spots'] = [];

      await sut.createExit(spot: occupiedSpot, exitTimestamp: exitTimestamp);

      verify(() => updateDailyLog.update(
          dailyLog: ParkingDailyLogModel.fromJson(_dailyLog))).called(1);
    });
    test('Should emit UiMessage.created if method passes with no error',
        () async {
      expect(sut.isLoadingStream, emitsInOrder([true, false]));
      expect(
          sut.messageStream, emitsInOrder([UiMessage.none, UiMessage.created]));

      await sut.createExit(spot: occupiedSpot, exitTimestamp: exitTimestamp);
    });
    test(
        'Should emit UiError.unexpected if method throws DomainError.unexpected',
        () async {
      updateDailyLog.mockError(DomainError.unexpected);

      expect(sut.isLoadingStream, emitsInOrder([true, false]));
      expect(sut.messageStream,
          emitsInOrder([UiMessage.none, UiMessage.unexpected]));

      await sut.createExit(spot: occupiedSpot, exitTimestamp: exitTimestamp);
    });
  });
  group('Fetch daily parking lot', () {
    test('Should call method correctly', () async {
      expect(sut.isLoadingStream, emitsInOrder([true, false]));

      await sut.fetchDailyParkingLot();

      verify(() => fetchDailyLog.fetch(
          formattedDate: MockModelCollection.formattedDate)).called(1);
    });
    test('Should create new ParkingDailyLog if fetch returns null', () async {
      expect(sut.isLoadingStream, emitsInOrder([true, false]));

      fetchDailyLog.mockRequest(null);

      await sut.fetchDailyParkingLot();

      verify(() => fetchDailyLog.fetch(
          formattedDate: MockModelCollection.formattedDate)).called(1);
      verify(() => updateDailyLog.update(dailyLog: any(named: 'dailyLog')))
          .called(1);
    });
    test('Should return ParkingDailyLogModel correctly', () async {
      expect(sut.isLoadingStream, emitsInOrder([true, false]));

      final response = await sut.fetchDailyParkingLot();

      expect(response,
          ParkingDailyLogModel.fromJson(MockModelCollection.dailyLogJson));
    });
    test(
        'Should emit UiError.unexpected if method throws DomainError.unexpected',
        () async {
      fetchDailyLog.mockError(DomainError.unexpected);

      expect(sut.isLoadingStream, emitsInOrder([true, false]));
      expect(sut.messageStream,
          emitsInOrder([UiMessage.none, UiMessage.unexpected]));

      await sut.fetchDailyParkingLot();
    });
  });
}
