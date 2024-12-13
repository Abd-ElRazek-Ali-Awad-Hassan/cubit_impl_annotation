import 'package:equatable/equatable.dart';

import '../interfaces/param.dart';

final class ParamImpl extends Equatable implements Param {
  const ParamImpl({
    required this.name,
    required this.paramTypeAsString,
  });

  @override
  final String name;

  @override
  final String paramTypeAsString;

  @override
  List<Object?> get props => [name, paramTypeAsString];
}
