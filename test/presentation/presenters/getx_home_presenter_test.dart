import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:parking_lot_app/data/models/parking_daily_log_model.dart';
import 'package:parking_lot_app/domain/helpers/errors/domain_error.dart';
import 'package:parking_lot_app/presentation/presenters/getx_home_presenter.dart';
import 'package:parking_lot_app/ui/helpers/message/ui_error.dart';

import '../../mock/fetch_daily_log_spy.dart';
import '../../mock/update_daily_log_spy.dart';

void main() {
  late GetxHomePresenter sut;
  late FetchDailyLogSpy fetchDailyLog;
  late UpdateDailyLogSpy updateDailyLog;

  final totalSpots = 16;
  final availableSpots = 16;
  final String formattedDate = '31/06/2022';
  final licensePlate = 'PKSG-1921';
  final occupiedSpot = 'C3';
  final entranceTimestamp = DateTime.now().millisecondsSinceEpoch;
  final exitTimestamp = DateTime.now().millisecondsSinceEpoch;
  final occupiedSpotVehicle = <String, dynamic>{
    'entrance_time': entranceTimestamp,
    'license_plate': licensePlate,
    'occupied_spot': occupiedSpot,
  };
  final historySpotVehicle = Map<String, dynamic>.from(occupiedSpotVehicle)
    ..addAll(<String, dynamic>{'exit_time': exitTimestamp});

  final dailyLogJson = <String, dynamic>{
    'total_spots': totalSpots,
    'available_spots': availableSpots,
    'date': formattedDate,
  };
  final dailyLog = ParkingDailyLogModel.fromJson(dailyLogJson);

  setUp(() {
    fetchDailyLog = FetchDailyLogSpy();
    updateDailyLog = UpdateDailyLogSpy();
    sut = GetxHomePresenter(
        fetchDailyLog: fetchDailyLog,
        updateDailyLog: updateDailyLog,
        formattedDate: formattedDate);

    fetchDailyLog.mockRequest(dailyLog);
    updateDailyLog.mockRequest();
  });

  setUpAll(() {
    registerFallbackValue(dailyLog);
  });

  group('Create new entrance', () {
    test('Should call method correctly', () async {
      expect(sut.isLoadingStream, emitsInOrder([true, false]));

      final _dailyLog = Map<String, dynamic>.from(dailyLogJson)
        ..addAll({
          'occupied_spots': [occupiedSpotVehicle]
        });

      await sut.createEntrance(
          entranceTimestamp: entranceTimestamp,
          license: licensePlate,
          spot: occupiedSpot,
          onSuccess: () {});

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
          onSuccess: () {});
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
          onSuccess: () {});
    });
  });
  group('Create new exit', () {
    test('Should call method correctly', () async {
      expect(sut.isLoadingStream, emitsInOrder([true, false]));

      final _dailyLog = Map<String, dynamic>.from(dailyLogJson)
        ..addAll({
          'daily_history': [historySpotVehicle]
        });

      await sut.createExit(
          spot: occupiedSpot, exitTimestamp: exitTimestamp, onSuccess: () {});

      verify(() => updateDailyLog.update(
          dailyLog: ParkingDailyLogModel.fromJson(_dailyLog))).called(1);
    });
    test('Should call onSuccess CallBack if method has no error', () async {
      expect(sut.isLoadingStream, emitsInOrder([true, false]));
      expect(
          sut.messageStream, emitsInOrder([UiMessage.none, UiMessage.created]));

      final onSuccessCallback = () {};

      await sut.createExit(
          spot: occupiedSpot,
          exitTimestamp: exitTimestamp,
          onSuccess: onSuccessCallback);

      verify(() => onSuccessCallback).called(1);
    });
    test(
        'Should emit UiError.unexpected if method throws DomainError.unexpected',
        () async {
      updateDailyLog.mockError(DomainError.unexpected);

      expect(sut.isLoadingStream, emitsInOrder([true, false]));
      expect(sut.messageStream,
          emitsInOrder([UiMessage.none, UiMessage.unexpected]));

      await sut.createExit(
          spot: occupiedSpot, exitTimestamp: exitTimestamp, onSuccess: () {});
    });
  });
  group('Fetch daily parking lot', () {
    test('Should call method correctly', () async {
      expect(sut.isLoadingStream, emitsInOrder([true, false]));

      await sut.fetchDailyParkingLot();

      verify(() => fetchDailyLog.fetch(formattedDate: formattedDate)).called(1);
    });
    test('Should create new ParkingDailyLog if fetch returns null', () async {
      expect(sut.isLoadingStream, emitsInOrder([true, false]));

      fetchDailyLog.mockRequest(null);

      await sut.fetchDailyParkingLot();

      verify(() => fetchDailyLog.fetch(formattedDate: formattedDate)).called(1);
      verify(() => updateDailyLog.update(dailyLog: any(named: 'dailyLog')))
          .called(1);
    });
    test('Should return ParkingDailyLogModel correctly', () async {
      expect(sut.isLoadingStream, emitsInOrder([true, false]));

      final response = await sut.fetchDailyParkingLot();

      expect(response, ParkingDailyLogModel.fromJson(dailyLogJson));
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
