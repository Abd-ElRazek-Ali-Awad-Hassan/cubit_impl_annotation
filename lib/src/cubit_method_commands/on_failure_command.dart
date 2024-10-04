import 'package:failures/failures.dart';

import 'interfaces/requiring_callback.dart';

sealed class OnFailureCommand {}

final class ReportServerFailure implements OnFailureCommand {
  const ReportServerFailure();
}

final class ReportNetworkFailure implements OnFailureCommand {
  const ReportNetworkFailure();
}

final class ReportAuthorizedAccessFailure implements OnFailureCommand {
  const ReportAuthorizedAccessFailure();
}

final class OnFailureDo<FailureType extends Failure>
    implements OnFailureCommand, RequiringCallback {
  const OnFailureDo({
    required this.callbackName,
  });

  @override
  final String callbackName;
}
