import 'package:hive/hive.dart';
import 'package:parking_lot_app/data/local_storage/local_storage_client.dart';

class HiveLocalStorageAdapter implements LocalStorageClient {
  final Box<dynamic> box;
  HiveLocalStorageAdapter(this.box);

  @override
  Future get({required String key}) async {
    return await box.get(key);
  }

  @override
  Future put({required String key, required data}) async {
    await box.put(key, data);
  }

  @override
  Future remove({required String key}) async {
    await box.delete(key);
  }
}
