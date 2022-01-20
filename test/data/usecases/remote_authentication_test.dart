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
    final body = RemoteAuthenticationParams.fromDomain(params).toJson();
    try {
      await httpClient.request(url: url, method: 'post', body: body);
    } on HttpError {
      throw DomainError.unexpected;
    }
  }
}

class HttpClient {
  Future<void> request(
      {@required String url, @required String method, Map body}) async {}
}

class HttpClientSpy extends Mock implements HttpClient {}

class RemoteAuthenticationParams {
  final String email;
  final String password;

  RemoteAuthenticationParams({@required this.email, @required this.password});
  Map toJson() => {
        'email': email,
        'password': password,
      };
  factory RemoteAuthenticationParams.fromDomain(AuthenticationParams params) =>
      RemoteAuthenticationParams(email: params.email, password: params.secret);
}

//domain/helpers/domain_error.dart
enum DomainError { unexpected }
//data/http/http_error.dart
enum HttpError { badRequest, notFound }

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
    verify(httpClient.request(url: url, method: 'post', body: {
      'email': params.email,
      'password': params.secret,
    }));
  });
  test('should call httpClient with correct values', () async {
    //arrange
    //act
    await sut.auth(params);
    //assert
    verify(httpClient.request(url: url, method: 'post', body: {
      'email': params.email,
      'password': params.secret,
    }));
  });
  test('should call httpClient with correct body', () async {
    //arrange

    //act
    await sut.auth(params);
    //assert
    verify(httpClient.request(url: url, method: 'post', body: {
      'email': params.email,
      'password': params.secret,
    }));
  });
  test('should throw UnexpectedError if HttpClient return 400', () async {
    //arrange
    when(httpClient.request(
            url: anyNamed("url"),
            method: anyNamed('method'),
            body: anyNamed('body')))
        .thenThrow(HttpError.badRequest);
    //act
    final future = sut.auth(params);
    //assert
    expect(future, throwsA(DomainError.unexpected));
  });
  test('should return UnexpectedError if HttpClient returns 404', () async {
    //arrange
    when(httpClient.request(
            url: anyNamed("url"),
            method: anyNamed('method'),
            body: anyNamed('body')))
        .thenThrow(HttpError.notFound);
    //act
    final future = sut.auth(params);

    //assert
    expect(future, throwsA(DomainError.unexpected));
  });
}
