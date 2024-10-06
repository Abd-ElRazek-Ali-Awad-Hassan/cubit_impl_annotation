import 'package:failures/failures.dart';

import 'interfaces/requiring_callback.dart';

sealed class OnFailureAction {}

final class ReportServerFailure implements OnFailureAction {
  const ReportServerFailure();
}

final class ReportNetworkFailure implements OnFailureAction {
  const ReportNetworkFailure();
}

final class ReportAuthorizedAccessFailure implements OnFailureAction {
  const ReportAuthorizedAccessFailure();
}

final class OnFailureDo<FailureType extends Failure>
    implements OnFailureAction, RequiringCallback {
  const OnFailureDo({
    required this.callbackName,
  });

  @override
  final String callbackName;
}
