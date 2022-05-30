import 'package:hive/hive.dart';
import 'package:parking_lot_app/data/local_storage/local_storage_configure.dart';
import 'package:path_provider/path_provider.dart';

class HiveLocalStorageConfigure implements LocalStorageConfigure {
  @override
  Future<void> configure() async {
    try {
      var dir = await getApplicationDocumentsDirectory();
      Hive.init(dir.path);
      await Hive.openBox('db');
    } catch (e) {
      print(e);
    }
  }
}
