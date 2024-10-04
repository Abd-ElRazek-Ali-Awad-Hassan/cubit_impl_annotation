import 'interfaces/requiring_callback.dart';

sealed class OnSuccessCommand {}

final class ShowSuccess implements OnSuccessCommand {
  const ShowSuccess();
}

final class OnSuccessDo implements OnSuccessCommand, RequiringCallback {
  const OnSuccessDo({
    required this.callbackName,
  });

  @override
  final String callbackName;
}
