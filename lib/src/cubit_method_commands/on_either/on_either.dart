import 'package:failures/failures.dart';

import '../interfaces/cubit_method_command.dart';
import '../interfaces/requiring_callback.dart';
import 'interfaces/on_failure_command.dart';
import 'interfaces/on_success_command.dart';

final class OnEither<FailureType extends Failure, SuccessType>
    implements CubitMethodCommand, RequiringCallback {
  const OnEither({
    this.onSuccess = const [],
    this.onFailure = const [],
    this.commandName = 'onEither',
    this.callbackName = 'callback',
  });

  @override
  final String commandName;

  @override
  final String callbackName;

  final List<OnSuccessCommand> onSuccess;
  final List<OnFailureCommand> onFailure;
}
