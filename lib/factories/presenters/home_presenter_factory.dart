import 'package:intl/intl.dart';
import 'package:parking_lot_app/factories/usecases/fetch_daily_log.dart';
import 'package:parking_lot_app/factories/usecases/update_daily_log.dart';
import 'package:parking_lot_app/presentation/presenters/getx_home_presenter.dart';
import 'package:parking_lot_app/ui/pages/home/home_presenter.dart';

HomePresenter makeHomePresenter() => GetxHomePresenter(
    fetchDailyLog: makeFetchDailyLog(),
    updateDailyLog: makeUpdateDailyLog(),
    formattedDate: DateFormat('dd/MM/yyyy').format(DateTime.now()));
