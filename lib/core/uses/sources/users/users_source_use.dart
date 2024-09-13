import 'package:chat/configs/configs.dart';
import 'package:chat/core/rules/rules_core.dart';
import 'package:chat/core/uses/adapters/adapters_use.dart';
import 'package:chat/core/uses/models/models_use.dart';

class UsersSourceUse implements UsersSourceRule {
  final Dio dio;

  // Recibir Dio a través del constructor
  UsersSourceUse(this.dio);

  @override
  Future<List<UserEntityRule>> getUsuarios() async {
    try {
      final String? token = await TokenSecureStorageHelperConfig.getToken();

      final response = await dio.get(
        '/users',
        options: Options(
          headers: {
            'x-token': token!,
          },
        ),
      );

      if (response.statusCode == 200) {
        final result = UsersModelUse.fromJson(response.data);
        return result.users.map((user) {
          return UserAdapterUse.toEntity(user);
        }).toList();
      } else {
        throw Exception('Error al obtener usuarios: ${response.statusCode}');
      }
    } on DioException catch (_) {
      return [];
    } catch (_) {
      return [];
    }
  }
}
