import 'package:failures/failures.dart';

import '../../interfaces/requiring_callback.dart';
import '../interfaces/on_failure_command.dart';

final class ReportFailureByCalling<FailureType extends Failure>
    implements OnFailureCommand, RequiringCallback {
  const ReportFailureByCalling({
    required this.callbackName,
  });

  @override
  final String callbackName;
}
