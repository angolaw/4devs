import 'package:faker/faker.dart';
import 'package:fordevs/domain/usecases/usecases.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:meta/meta.dart';

class RemoteAuthentication {
  final HttpClient httpClient;
  final String url;

  RemoteAuthentication({@required this.httpClient, @required this.url});
  Future<void> auth(AuthenticationParams params) async {
    final body = {
      'email': params.email,
      'password': params.secret,
    };
    await httpClient.request(url: url, method: 'post', body: body);
  }
}

class HttpClient {
  Future<void> request(
      {@required String url, @required String method, Map body}) async {}
}

class HttpClientSpy extends Mock implements HttpClient {}

void main() {
  HttpClientSpy httpClient;
  String url;
  RemoteAuthentication sut;
  AuthenticationParams params;
  setUp(() {
    httpClient = HttpClientSpy();
    url = faker.internet.httpUrl();
    sut = RemoteAuthentication(httpClient: httpClient, url: url);
    params = AuthenticationParams(
        email: faker.internet.email(), secret: faker.internet.password());
  });
  test('should call httpClient with correct url', () async {
    //arrange

    //act
    await sut.auth(params);
    //assert
    verify(httpClient.request(
        url: url,
        method: 'post',
        body: {"email": params.email, "password": params.secret}));
  });
  test('should call httpClient with correct values', () async {
    //arrange
    //act
    await sut.auth(params);
    //assert
    verify(httpClient.request(
        url: url,
        method: 'post',
        body: {"email": params.email, "password": params.secret}));
  });
  test('should call httpClient with correct body', () async {
    //arrange

    //act
    await sut.auth(params);
    //assert
    verify(httpClient.request(
        url: url,
        method: 'post',
        body: {'email': params.email, 'password': params.secret}));
  });
}
