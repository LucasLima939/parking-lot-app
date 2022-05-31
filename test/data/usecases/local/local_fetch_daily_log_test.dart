import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:parking_lot_app/data/models/parking_daily_log_model.dart';
import 'package:parking_lot_app/data/usecases/fetch_daily_log/local_fetch_daily_log.dart';
import 'package:parking_lot_app/domain/helpers/errors/domain_error.dart';

import '../../../mock/local_storage_client_spy.dart';

void main() {
  late LocalFetchDailyLog sut;
  late LocalStorageClientSpy client;
  final String formattedDate = '31/06/2022';
  final Map<String, dynamic> json = <String, dynamic>{
    'total_spots': 10,
    'available_spots': 10,
    'date': formattedDate,
    'occupied_spots': [
      {
        'entrance_time': Random().nextInt(20000),
        'license_plate': 'PKSG-1921',
        'occupied_spot': 'C3',
      }
    ],
    'daily_history': [
      {
        'exit_time': Random().nextInt(20000),
        'entrance_time': Random().nextInt(20000),
        'license_plate': 'PKSG-1921',
        'occupied_spot': 'C3',
      }
    ],
  };

  setUp(() {
    client = LocalStorageClientSpy();
    sut = LocalFetchDailyLog(client: client);

    client.mockGetRequest(json);
  });

  setUpAll(() {
    registerFallbackValue(json);
  });

  test('Should call client method correctly', () async {
    await sut.fetch(formattedDate: formattedDate);

    verify(() => client.get(key: formattedDate)).called(1);
  });

  test('Should return DailyLogModel correctly if has no errors', () async {
    final _model = await sut.fetch(formattedDate: formattedDate);

    expect(_model, ParkingDailyLogModel.fromJson(json));
  });

  test('Should throw DomainError.unexpected if an error occurs', () {
    client.mockGetError(Exception());

    final future = sut.fetch(formattedDate: formattedDate);

    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw DomainError.noRegister if no entry is found', () {
    client.mockGetRequest(null);

    final future = sut.fetch(formattedDate: formattedDate);

    expect(future, throwsA(DomainError.noRegister));
  });
}
