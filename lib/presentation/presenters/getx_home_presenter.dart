import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:parking_lot_app/data/models/parking_daily_log_model.dart';
import 'package:parking_lot_app/data/models/vehicle_log_model.dart';
import 'package:parking_lot_app/domain/helpers/errors/domain_error.dart';
import 'package:parking_lot_app/domain/usecases/fetch_daily_log.dart';
import 'package:parking_lot_app/domain/usecases/update_daily_log.dart';
import 'package:parking_lot_app/ui/helpers/message/ui_error.dart';
import 'package:parking_lot_app/data/models/interfaces/i_parking_daily_log.dart';
import 'package:parking_lot_app/ui/pages/home/home_presenter.dart';

class GetxHomePresenter extends GetxController implements HomePresenter {
  final FetchDailyLog fetchDailyLog;
  final UpdateDailyLog updateDailyLog;
  final String formattedDate;
  GetxHomePresenter(
      {required this.fetchDailyLog,
      required this.updateDailyLog,
      required this.formattedDate});

  final _isLoading = false.obs;
  final _message = UiMessage.none.obs;
  int _totalSpots = 16;
  IParkingDailyLog? _dailyLog;

  @override
  Stream<UiMessage> get messageStream => _message.stream;

  @override
  Stream<bool> get isLoadingStream => _isLoading.stream;

  @override
  Future<void> createEntrance(
      {required String license,
      required String spot,
      required int entranceTimestamp,
      VoidCallback? onSuccess}) async {
    _message.value = UiMessage.none;
    _isLoading.value = true;
    try {
      _dailyLog ??= await fetchDailyParkingLot();

      _dailyLog!.entrance(VehicleLogModel(entranceTimestamp, license, spot));

      await updateDailyLog.update(dailyLog: _dailyLog!);

      if (onSuccess != null) onSuccess();

      _message.value = UiMessage.created;
    } catch (e) {
      _message.value = UiMessage.unexpected;
    } finally {
      _isLoading.value = false;
    }
  }

  @override
  Future<void> createExit(
      {required String spot,
      required int exitTimestamp,
      VoidCallback? onSuccess}) async {
    _message.value = UiMessage.none;
    _isLoading.value = true;
    try {
      _dailyLog ??= await fetchDailyParkingLot();

      final _vehicle = _dailyLog!.occupiedSpots?.firstWhere(
        (element) => element.occupiedSpot == spot,
        orElse: () => throw DomainError.noRegister,
      );

      if (_vehicle == null) throw DomainError.noRegister;

      _dailyLog!.exit(_vehicle, exitTimestamp);

      await updateDailyLog.update(dailyLog: _dailyLog!);

      if (onSuccess != null) onSuccess();

      _message.value = UiMessage.created;
    } on DomainError catch (error) {
      switch (error) {
        case DomainError.noRegister:
          _message.value = UiMessage.noRegister;
          break;
        default:
          _message.value = UiMessage.unexpected;
          break;
      }
    } catch (e) {
      _message.value = UiMessage.unexpected;
    } finally {
      _isLoading.value = false;
    }
  }

  @override
  Future<IParkingDailyLog?> fetchDailyParkingLot() async {
    _message.value = UiMessage.none;
    _isLoading.value = true;
    IParkingDailyLog? _response;
    try {
      _response = await fetchDailyLog.fetch(formattedDate: formattedDate);
      if (_response == null) {
        final _newDailyLog = ParkingDailyLogModel(
            totalSpots: _totalSpots, availableSpots: _totalSpots);
        await updateDailyLog.update(dailyLog: _newDailyLog);
      }
    } catch (e) {
      _message.value = UiMessage.unexpected;
    } finally {
      _isLoading.value = false;
    }
    return _response;
  }
}
