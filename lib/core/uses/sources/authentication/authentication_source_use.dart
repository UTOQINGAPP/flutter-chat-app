import 'package:chat/configs/configs.dart';
import 'package:chat/core/rules/rules_core.dart';
import 'package:chat/core/uses/adapters/adapters_use.dart';
import 'package:chat/core/uses/models/models_use.dart';

class AuthenticationSourceUse implements AuthenticationSourceRule {
  @override
  late UserEntityRule? user;

  final Dio dio;

  AuthenticationSourceUse(this.dio);
  @override
  Future<LoginModelAuthenticationUse> login(
      String email, String password) async {
    final data = {
      'email': email,
      'password': password,
    };

    try {
      final response = await dio.post(
        '/login/',
        data: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        var result = LoginModelAuthenticationUse.fromJson(response.data);
        await TokenSecureStorageHelperConfig.saveToken(result.token);
        user = UserAdapterUse.toEntity(result.user);
        return result;
      } else {
        throw Exception('Server error: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception(e.response?.data['msg'].toString());
    }
  }

  @override
  Future<LoginModelAuthenticationUse> register(
      String fullName, String email, String password) async {
    final data = {
      'name': fullName,
      'email': email,
      'password': password,
    };
    try {
      final response = await dio.post(
        '/login/new',
        data: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        var result = LoginModelAuthenticationUse.fromJson(response.data);
        await TokenSecureStorageHelperConfig.saveToken(result.token);
        user = UserAdapterUse.toEntity(result.user);
        //msg = response.data['msg'] ?? '';
        return result;
      } else {
        throw Exception('Server error: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception(e.response?.data['msg'].toString());
    }
  }

  @override
  Future<LoginModelAuthenticationUse?> isLoggedIn() async {
    try {
      final token = await TokenSecureStorageHelperConfig.getToken();
      if (token == null) {
        return null;
      }
      final response = await dio.get(
        '/login/renew',
        options: Options(headers: {'x-token': token}),
      );

      if (response.statusCode == 200) {
        var result = LoginModelAuthenticationUse.fromJson(response.data);
        user = UserAdapterUse.toEntity(result.user);

        //msg = response.data['msg'] ?? '';

        return result;
      } else {
        throw Exception('Server error: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception(e.response?.data['msg'].toString());
    }
  }

  @override
  Future<bool> logout() async {
    await TokenSecureStorageHelperConfig.deleteToken();

    if (await TokenSecureStorageHelperConfig.getToken() == null) {
      user = null;
      return true;
    }
    return false;
  }
}
