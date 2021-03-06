import 'package:parking_lot_app/factories/usecases/fetch_daily_log.dart';
import 'package:parking_lot_app/presentation/presenters/getx_history_presenter.dart';
import 'package:parking_lot_app/ui/pages/history/history_presenter.dart';

HistoryPresenter makeHistoryPresenter() =>
    GetxHistoryPresenter(fetchDailyLog: makeFetchDailyLog());
