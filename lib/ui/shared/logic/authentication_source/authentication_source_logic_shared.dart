import 'package:chat/core/core.dart';
import 'package:chat/ui/shared/logic/dio/dio_logic_shared.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'authentication_source_logic_shared.g.dart';

@Riverpod(keepAlive: true)
AuthenticationSourceRule authenticationSourceLogicShared(
    AuthenticationSourceLogicSharedRef ref) {
  final dio = ref.watch(dioSharedProvider);
  return AuthenticationSourceUse(dio);
}
