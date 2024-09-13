import 'package:chat/configs/configs.dart';
import 'package:chat/core/rules/rules_core.dart';
import 'package:chat/core/uses/adapters/adapters_use.dart';
import 'package:chat/core/uses/models/models_use.dart';

class ChatSourceUse implements ChatSourceRule {
  final Dio dio;

  ChatSourceUse(this.dio);

  @override
  Future<List<MessageEntityRule>> getChat(String userUid) async {
    try {
      final token = await TokenSecureStorageHelperConfig.getToken();

      final response = await dio.get(
        '/messages/$userUid',
        options: Options(
          headers: {
            'x-token': token,
          },
        ),
      );

      if (response.statusCode == 200) {
        final result = ChatModelUse.fromJson(response.data);

        return result.messages.map((message) {
          return MessageAdapterUse.toEntity(message);
        }).toList();
      } else {
        throw Exception('Error fetching messages: ${response.statusCode}');
      }
    } on DioException catch (_) {
      return [];
    } catch (_) {
      return [];
    }
  }
}
