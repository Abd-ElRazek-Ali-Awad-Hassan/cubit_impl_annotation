import 'interfaces/requiring_callback.dart';

sealed class OnSuccessAction {}

final class ShowSuccess implements OnSuccessAction {
  const ShowSuccess();
}

final class OnSuccessDo implements OnSuccessAction, RequiringCallback {
  const OnSuccessDo({
    required this.callbackName,
  });

  @override
  final String callbackName;
}
