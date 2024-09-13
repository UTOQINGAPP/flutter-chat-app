import 'package:chat/configs/configs.dart';
import 'package:chat/core/rules/rules_core.dart';
import 'package:chat/core/uses/adapters/adapters_use.dart';
import 'package:chat/core/uses/models/models_use.dart';

class AuthenticationSourceUse implements AuthenticationSourceRule {
  final Dio dio;

  AuthenticationSourceUse(this.dio);
  @override
  Future<(bool, UserEntityRule)> login(String email, String password) async {
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
        return (result.ok, UserAdapterUse.toEntity(result.user));
      } else {
        throw Exception('Server error: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception(e.response?.data['msg'].toString());
    }
  }

  @override
  Future<(bool, UserEntityRule)> register(
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
        return (result.ok, UserAdapterUse.toEntity(result.user));
      } else {
        throw Exception('Server error: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception(e.response?.data['msg'].toString());
    }
  }

  @override
  Future<(bool, UserEntityRule?)> isLoggedIn() async {
    try {
      final token = await TokenSecureStorageHelperConfig.getToken();

      if (token == null) {
        return (false, null);
      }

      final response = await dio.get(
        '/login/renew',
        options: Options(headers: {'x-token': token}),
      );

      if (response.statusCode == 200) {
        var result = LoginModelAuthenticationUse.fromJson(response.data);
        return (result.ok, UserAdapterUse.toEntity(result.user));
      } else {
        return (false, null);
      }
    } on DioException catch (_) {
      return (false, null);
    }
  }

  @override
  Future<bool> logout() async {
    await TokenSecureStorageHelperConfig.deleteToken();

    if (await TokenSecureStorageHelperConfig.getToken() == null) {
      return true;
    }
    return false;
  }
}
