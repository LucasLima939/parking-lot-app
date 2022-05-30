abstract class LocalStorageClient {
  Future get({required String key});
  Future put({required String key, required dynamic data});
  Future remove({required String key});
}
