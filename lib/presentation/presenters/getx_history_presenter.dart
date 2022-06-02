import 'package:get/get.dart';
import 'package:parking_lot_app/domain/helpers/errors/domain_error.dart';
import 'package:parking_lot_app/domain/usecases/fetch_daily_log.dart';
import 'package:parking_lot_app/ui/helpers/message/ui_error.dart';
import 'package:parking_lot_app/data/models/interfaces/i_parking_daily_log.dart';
import 'package:parking_lot_app/ui/pages/history/history_presenter.dart';

class GetxHistoryPresenter extends GetxController implements HistoryPresenter {
  final FetchDailyLog fetchDailyLog;
  GetxHistoryPresenter({required this.fetchDailyLog});

  final _message = UiError.none.obs;
  final _isLoading = false.obs;

  @override
  Stream<UiError> get messageStream => _message.stream;

  @override
  Stream<bool> get isLoadingStream => _isLoading.stream;

  @override
  Future<IParkingDailyLog?> fetchDailyParkingLot(
      {required String formattedDate}) async {
    _isLoading.value = true;
    _message.value = UiError.none;

    IParkingDailyLog? response;

    try {
      response = await fetchDailyLog.fetch(formattedDate: formattedDate);

      if (response == null) throw DomainError.noRegister;
    } catch (e) {
      switch (e) {
        case DomainError.noRegister:
          _message.value = UiError.noRegister;
          break;
        default:
          _message.value = UiError.unexpected;
          break;
      }
    } finally {
      _isLoading.value = false;
      return response;
    }
  }
}
