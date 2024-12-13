import 'async_operations/async_operation.dart';
import 'async_operations/interfaces/has_params.dart';
import 'async_operations/interfaces/param.dart';

final class Command implements HasParams {
  const Command([this.operations = const []]);

  final List<AsyncOperation> operations;

  @override
  List<Param> get params =>
      operations.whereType<HasParams>().expand((e) => e.params).toList();
}
