import 'package:chat/configs/configs.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'dio_logic_shared.g.dart';

@Riverpod(keepAlive: true)
Dio dioShared(DioSharedRef ref) {
  return Dio(
    BaseOptions(
      baseUrl: EnvConfig.apiUrl,
      headers: {'Content-Type': 'application/json'},
      receiveDataWhenStatusError: true,
    ),
  );
}
