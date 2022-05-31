import 'package:mocktail/mocktail.dart';
import 'package:parking_lot_app/data/local_storage/local_storage_client.dart';

class LocalStorageClientSpy extends Mock implements LocalStorageClient {
  When mockGetCall() => when(() => get(key: any(named: 'key')));
  mockGetRequest(response) => mockGetCall().thenAnswer((_) async => response);
  mockGetError(error) => mockGetCall().thenThrow(error);

  When mockPutCall() =>
      when(() => put(key: any(named: 'key'), data: any(named: 'data')));
  mockPutRequest() => mockPutCall().thenAnswer((_) async {});
  mockPutError(error) => mockPutCall().thenThrow(error);

  When mockRemoveCall() => when(() => remove(key: any(named: 'key')));
  mockRemoveRequest() => mockRemoveCall().thenAnswer((_) async {});
  mockRemoveError(error) => mockRemoveCall().thenThrow(error);
}
