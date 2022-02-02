import 'package:fordevs/data/http/http_error.dart';
import 'package:fordevs/domain/entities/entities.dart';

class RemoteAccountModel {
  final String accessToken;
  RemoteAccountModel(
    this.accessToken,
  );
  factory RemoteAccountModel.fromJson(Map json) {
    if (!json.containsKey('accessToken')) {
      throw HttpError.invalidData;
    }
    return RemoteAccountModel(json['accessToken']);
  }

  AccountEntity toEntity() => AccountEntity(accessToken);
}
