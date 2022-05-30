import 'package:parking_lot_app/data/local_storage/local_storage_configure.dart';
import 'package:parking_lot_app/intra/local_storage/hive_local_storage_configure.dart';

LocalStorageConfigure makeLocalStorageConfigure() =>
    HiveLocalStorageConfigure();
