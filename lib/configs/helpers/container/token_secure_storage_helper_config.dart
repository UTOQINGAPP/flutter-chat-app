import 'package:chat/configs/packages/packages_config.dart';

class TokenSecureStorageHelperConfig {
  static Future<String?> getToken() async {
    const FlutterSecureStorage storage = FlutterSecureStorage();
    final token = await storage.read(key: 'token');
    return token;
  }

  static Future<void> deleteToken() async {
    const FlutterSecureStorage storage = FlutterSecureStorage();
    await storage.delete(key: 'token');
  }

  static Future<void> saveToken(String token) async {
    const FlutterSecureStorage storage = FlutterSecureStorage();
    return await storage.write(key: 'token', value: token);
  }
}
