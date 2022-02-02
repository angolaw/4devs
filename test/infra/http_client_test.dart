import 'package:http/http.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:meta/meta.dart';

class HttpAdapter {
  final Client client;

  HttpAdapter(this.client);
  Future<void> request({@required String url, @required String method}) async {}
}

class ClientSpy extends Mock implements Client {}

void main() {
  group('POST method', () {
    test('should call POST with correct values', () async {
      //arrange
      final client = ClientSpy();
      final sut = HttpAdapter(client);
      //act

      //assert
    });
  });
}
