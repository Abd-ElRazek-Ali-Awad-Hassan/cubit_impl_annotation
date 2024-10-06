import 'package:failures/failures.dart';

import 'interfaces/requiring_callback.dart';
import 'on_failure_action.dart';
import 'on_success_action.dart';

sealed class AsyncOperationThatEmits {}

final class ShowLoading implements AsyncOperationThatEmits {
  const ShowLoading();
}

final class OnEither<FailureType extends Failure, SuccessType>
    implements AsyncOperationThatEmits, RequiringCallback {
  const OnEither({
    this.onSuccess = const [],
    this.onFailure = const [],
    this.callbackName = 'callback',
  });

  @override
  final String callbackName;

  final List<OnSuccessAction> onSuccess;
  final List<OnFailureAction> onFailure;
}
