import 'package:equatable/equatable.dart';
import 'package:failures/failures.dart';
import 'package:fpdart/fpdart.dart';

import 'abstractions/callback_can_be_param_template.dart';
import 'interfaces/callback_can_be_param.dart';
import 'interfaces/has_params.dart';
import 'interfaces/param.dart';
import 'on_failure_action.dart';
import 'on_success_action.dart';

sealed class AsyncOperation {}

final class ShowLoading extends Equatable implements AsyncOperation {
  const ShowLoading();

  @override
  List<Object?> get props => [];
}

final class OnEither implements AsyncOperation, HasParams {
  const OnEither({
    this.onSuccess = const [],
    this.onFailure = const [],
    required this.eitherCallback,
  });

  final List<OnSuccessAction> onSuccess;
  final List<OnFailureAction> onFailure;
  final CallbackCanBeParam eitherCallback;

  @override
  List<Param> get params => [
        eitherCallback,
        ...onSuccess.whereType<Param>(),
        ...onFailure.whereType<Param>(),
      ];
}

abstract class EitherCallbackTemplate extends CallbackCanBeParamTemplate {
  const EitherCallbackTemplate();

  @override
  List<Param> get params => [];

  String get failureTypeAsString;

  String get successTypeAsString;

  @override
  String get returnTypeAsString {
    final buffer = StringBuffer()
      ..write(_removeTypeArgs('$Future'))
      ..write('<')
      ..write(_removeTypeArgs('$Either'))
      ..write('<$failureTypeAsString, $successTypeAsString>')
      ..write('>');
    return buffer.toString();
  }

  String _removeTypeArgs(String typeAsString) {
    return typeAsString.replaceAll(RegExp(r'<.*?>'), '');
  }
}

final class EitherCallback<FailureType extends Failure, SuccessType>
    extends EitherCallbackTemplate {
  @override
  final String name;

  const EitherCallback({
    required this.name,
  });

  @override
  String get failureTypeAsString => '$FailureType';

  @override
  String get successTypeAsString => '$SuccessType';
}
