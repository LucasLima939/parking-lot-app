import 'package:mocktail/mocktail.dart';
import 'package:parking_lot_app/data/models/interfaces/i_parking_daily_log.dart';
import 'package:parking_lot_app/domain/helpers/errors/domain_error.dart';
import 'package:parking_lot_app/domain/usecases/fetch_daily_log.dart';

class FetchDailyLogSpy extends Mock implements FetchDailyLog {
  When mockCall() =>
      when(() => fetch(formattedDate: any(named: 'formattedDate')));
  mockRequest(IParkingDailyLog? response) =>
      mockCall().thenAnswer((_) async => response);
  mockError(DomainError error) => mockCall().thenThrow(error);
}
