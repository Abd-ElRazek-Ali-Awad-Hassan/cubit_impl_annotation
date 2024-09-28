import 'interfaces/cubit_method_command.dart';

final class ShowLoading implements CubitMethodCommand {
  const ShowLoading({this.commandName = 'showLoading'});

  @override
  final String commandName;
}
