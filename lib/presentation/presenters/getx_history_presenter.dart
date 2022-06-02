import 'package:get/get.dart';
import 'package:parking_lot_app/domain/helpers/errors/domain_error.dart';
import 'package:parking_lot_app/domain/usecases/fetch_daily_log.dart';
import 'package:parking_lot_app/ui/helpers/message/ui_error.dart';
import 'package:parking_lot_app/data/models/interfaces/i_parking_daily_log.dart';
import 'package:parking_lot_app/ui/pages/history/history_presenter.dart';

class GetxHistoryPresenter extends GetxController implements HistoryPresenter {
  final FetchDailyLog fetchDailyLog;
  GetxHistoryPresenter({required this.fetchDailyLog});

  final _message = UiMessage.none.obs;
  final _isLoading = false.obs;
  final _parkingDailyLog = Rx<IParkingDailyLog?>(null);

  @override
  Stream<UiMessage> get messageStream => _message.stream;

  @override
  Stream<bool> get isLoadingStream => _isLoading.stream;

  @override
  Stream<IParkingDailyLog> get parkingDailyLogStream =>
      _parkingDailyLog.stream.map<IParkingDailyLog>((event) => event!);

  @override
  Future<void> fetchDailyParkingLot({required String formattedDate}) async {
    _isLoading.value = true;
    _message.value = UiMessage.none;
    try {
      final response = await fetchDailyLog.fetch(formattedDate: formattedDate);

      if (response == null) throw DomainError.noRegister;

      _parkingDailyLog.value = response;

      _message.value = UiMessage.none;
    } catch (e) {
      switch (e) {
        case DomainError.noRegister:
          _message.value = UiMessage.noRegister;
          break;
        default:
          _message.value = UiMessage.unexpected;
          break;
      }
    } finally {
      _isLoading.value = false;
    }
  }
}
