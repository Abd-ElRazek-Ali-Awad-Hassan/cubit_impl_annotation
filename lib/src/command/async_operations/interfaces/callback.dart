import 'has_name.dart';
import 'has_params.dart';
import 'param.dart';

abstract interface class Callback implements HasName, HasParams {
  List<Param> get params;

  String get returnTypeAsString;
}
