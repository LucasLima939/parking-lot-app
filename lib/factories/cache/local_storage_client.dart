import 'package:hive/hive.dart';
import 'package:parking_lot_app/data/local_storage/local_storage_client.dart';
import 'package:parking_lot_app/intra/local_storage/hive_local_storage_adapter.dart';

LocalStorageClient makeLocalStorageClient() =>
    HiveLocalStorageAdapter(Hive.box('db'));
