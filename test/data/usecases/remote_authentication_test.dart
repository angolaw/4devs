import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:meta/meta.dart';

class RemoteAuthentication {
  final HttpClient httpClient;
  final String url;

  RemoteAuthentication({@required this.httpClient, @required this.url});
  Future<void> auth() async {
    await httpClient.request(url: url, method: 'post');
  }
}

class HttpClient {
  Future<void> request({@required String url, @required String method}) async {}
}

class HttpClientSpy extends Mock implements HttpClient {}

void main() {
  test('should call httpClient with correct url', () async {
    //arrange
    final httpClient = HttpClientSpy();
    final url = faker.internet.httpUrl();
    final sut = RemoteAuthentication(httpClient: httpClient, url: url);
    //act
    await sut.auth();
    //assert
    verify(httpClient.request(url: url, method: 'post'));
  });
  test('should call httpClient with correct values', () async {
    //arrange
    final httpClient = HttpClientSpy();
    final url = faker.internet.httpUrl();
    final sut = RemoteAuthentication(httpClient: httpClient, url: url);
    //act
    await sut.auth();
    //assert
    verify(httpClient.request(url: url, method: 'post'));
  });
}
