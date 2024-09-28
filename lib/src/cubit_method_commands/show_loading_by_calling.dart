import 'interfaces/cubit_method_command.dart';
import 'interfaces/requiring_callback.dart';

final class ShowLoadingByCalling
    implements RequiringCallback, CubitMethodCommand {
  const ShowLoadingByCalling({
    this.callbackName = 'callback',
    this.commandName = 'showLoadingByCalling',
  });

  @override
  final String callbackName;

  @override
  final String commandName;
}
