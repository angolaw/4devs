import '../entities/entities.dart';
import 'package:meta/meta.dart';

abstract class Authentication {
  Future<AccountEntity> auth(
      {@required String email, @required String password});
}

class AuthenticationParams {
  final String email;
  final String secret;

  AuthenticationParams({@required this.email, @required this.secret});
}
