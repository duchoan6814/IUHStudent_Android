import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:stateprovider/stateprovider.dart';

class GlobalStorage  {
  static final _storage = new FlutterSecureStorage();

  static final String keyStorage = "__access__token__";

  static Future<String?> getToken() async =>
    await _storage.read(key: keyStorage);


  static Future setToken(String token) async =>
    await _storage.write(key: keyStorage, value: token);


  static Future deleteToken() async =>
    await _storage.delete(key: keyStorage);

}