import '../../interfaces/requiring_callback.dart';
import '../interfaces/on_success_command.dart';

final class ShowSuccessByCalling
    implements OnSuccessCommand, RequiringCallback {
  const ShowSuccessByCalling({
    required this.callbackName,
  });

  @override
  final String callbackName;
}
