import 'package:chat/core/core.dart';
import 'package:chat/ui/shared/logic/authentication_source/authentication_source_logic_shared.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'authentication_consumer_logic_shared.g.dart';

@Riverpod(keepAlive: true)
AuthenticationConsumerRule authenticationConsumerLogicShared(
    AuthenticationConsumerLogicSharedRef ref) {
  final source = ref.watch(authenticationSourceLogicSharedProvider);
  return AuthenticationConsumerUse(source);
}
