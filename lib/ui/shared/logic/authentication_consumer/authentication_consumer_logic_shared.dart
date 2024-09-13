import 'package:chat/core/core.dart';
import 'package:chat/ui/shared/logic/dio/dio_logic_shared.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'authentication_consumer_logic_shared.g.dart';

// Intermediary logic between the authentic consumer and the IU of reading
// type that makes basic communication to log in,
// register, verify if it is already authenticated and close the current session.
@Riverpod(keepAlive: true)
AuthenticationConsumerRule authenticationConsumerLogicShared(
    AuthenticationConsumerLogicSharedRef ref) {
  final source = AuthenticationSourceUse(ref.watch(dioSharedProvider));
  return AuthenticationConsumerUse(source);
}
