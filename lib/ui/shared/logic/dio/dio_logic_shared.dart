import 'package:chat/configs/configs.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'dio_logic_shared.g.dart';

// Reading type logic that contains the basic configuration for the connection with the server
@Riverpod(keepAlive: true)
Dio dioShared(DioSharedRef ref) {
  return Dio(
    BaseOptions(
      baseUrl: EnvConfig.apiUrl(),
      headers: {
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*'
      },
      receiveDataWhenStatusError: true,
    ),
  );
}
