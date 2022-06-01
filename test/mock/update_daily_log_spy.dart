import 'package:mocktail/mocktail.dart';
import 'package:parking_lot_app/domain/helpers/errors/domain_error.dart';
import 'package:parking_lot_app/domain/usecases/update_daily_log.dart';

class UpdateDailyLogSpy extends Mock implements UpdateDailyLog {
  When mockCall() => when(() => update(dailyLog: any(named: 'dailyLog')));
  mockRequest() => mockCall().thenAnswer((_) async {});
  mockError(DomainError error) => mockCall().thenThrow(error);
}
