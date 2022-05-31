import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:parking_lot_app/data/models/parking_daily_log_model.dart';
import 'package:parking_lot_app/data/usecases/update_daily_log/local_update_daily_log.dart';
import 'package:parking_lot_app/domain/helpers/errors/domain_error.dart';

import '../../../mock/local_storage_client_spy.dart';

void main() {
  late LocalUpdateDailyLog sut;
  late LocalStorageClientSpy clientSpy;
  late ParkingDailyLogModel dailyLog;

  setUp(() {
    dailyLog = ParkingDailyLogModel(availableSpots: 10, totalSpots: 10);
    clientSpy = LocalStorageClientSpy();
    sut = LocalUpdateDailyLog(client: clientSpy);

    clientSpy.mockPutRequest();
  });

  test('should call client correctly', () async {
    await sut.update(dailyLog: dailyLog);

    verify(() => clientSpy.put(key: dailyLog.date, data: dailyLog.toJson()))
        .called(1);
  });
  test('should complete method if has no errors', () {
    final future = sut.update(dailyLog: dailyLog);

    expect(future, completes);
  });
  test('should throws DomainError.unexpected if method emits error ', () {
    clientSpy.mockPutError(Exception());

    final future = sut.update(dailyLog: dailyLog);

    expect(future, throwsA(DomainError.unexpected));
  });
}
