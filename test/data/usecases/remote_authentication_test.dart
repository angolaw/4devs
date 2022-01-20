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
  HttpClientSpy httpClient;
  String url;
  RemoteAuthentication sut;
  setUp(() {
    httpClient = HttpClientSpy();
    url = faker.internet.httpUrl();
    sut = RemoteAuthentication(httpClient: httpClient, url: url);
  });
  test('should call httpClient with correct url', () async {
    //arrange

    //act
    await sut.auth();
    //assert
    verify(httpClient.request(url: url, method: 'post'));
  });
  test('should call httpClient with correct values', () async {
    //arrange

    //act
    await sut.auth();
    //assert
    verify(httpClient.request(url: url, method: 'post'));
  });
}
