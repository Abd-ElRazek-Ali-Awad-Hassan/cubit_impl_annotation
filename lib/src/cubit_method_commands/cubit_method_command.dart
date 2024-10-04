import 'package:failures/failures.dart';

import 'interfaces/requiring_callback.dart';
import 'on_failure_command.dart';
import 'on_success_command.dart';

sealed class CubitMethodCommand {}

final class ShowLoading implements CubitMethodCommand {
  const ShowLoading();
}

final class OnEither<FailureType extends Failure, SuccessType>
    implements CubitMethodCommand, RequiringCallback {
  const OnEither({
    this.onSuccess = const [],
    this.onFailure = const [],
    this.callbackName = 'callback',
  });

  @override
  final String callbackName;

  final List<OnSuccessCommand> onSuccess;
  final List<OnFailureCommand> onFailure;
}
