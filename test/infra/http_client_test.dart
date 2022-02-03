import 'dart:convert';

import 'package:faker/faker.dart';
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:meta/meta.dart';

class HttpAdapter {
  final ClientSpy client;

  HttpAdapter(this.client);
  Future<void> request(
      {@required String url, @required String method, Map body}) async {
    final headers = {
      'content-type': 'application/json',
      'accept': 'application/json',
    };
    final jsonBody = body != null ? json.encode(body) : null;
    await client.post(url, headers: headers, body: jsonBody);
  }
}

class ClientSpy extends Mock implements Client {}

void main() {
  ClientSpy client;
  HttpAdapter sut;
  String url;

  setUp(() {
    client = ClientSpy();
    sut = HttpAdapter(client);
    url = faker.internet.httpUrl();
  });
  group('POST method', () {
    test('should call POST with correct values', () async {
      //arrange

      //act
      await sut.request(url: url, method: 'post');
      //assert
      verify(client.post(url, headers: {
        'content-type': 'application/json',
        'accept': 'application/json'
      }));
    });
    test('should pass json content type in headers', () async {
      //arrange
      //act
      await sut.request(url: url, method: 'post');
      //assert
      verify(client.post(url, headers: {
        'content-type': 'application/json',
        'accept': 'application/json'
      }));
    });
    test('should call POST with correct body', () async {
      //arrange

      //act
      await sut
          .request(url: url, method: 'post', body: {'any_key': 'any_value'});
      //assert
      verify(client.post(url,
          headers: {
            'content-type': 'application/json',
            'accept': 'application/json'
          },
          //stringified
          body: '{"any_key":"any_value"}'));
    });
  });
}
