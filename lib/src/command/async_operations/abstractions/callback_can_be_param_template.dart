import '../interfaces/callback_can_be_param.dart';

abstract class CallbackCanBeParamTemplate<ReturnType>
    implements CallbackCanBeParam {
  const CallbackCanBeParamTemplate();

  @override
  String get returnTypeAsString => '$ReturnType';

  @override
  String get paramTypeAsString =>
      '$returnTypeAsString $Function(${params.map((e) => e.paramTypeAsString).join(', ')})';
}
