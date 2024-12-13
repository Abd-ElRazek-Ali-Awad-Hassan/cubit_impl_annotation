import 'dart:async';

import 'package:equatable/equatable.dart';

import 'abstractions/callback_can_be_param_template.dart';
import 'entities/param_impl.dart';
import 'interfaces/callback_can_be_param.dart';
import 'interfaces/param.dart';

abstract interface class OnSuccessActionVisitor<ReturnType> {
  ReturnType visitOnSuccess(OnSuccess action);
  ReturnType visitShowSuccess(ShowSuccess action);
}

abstract class OnSuccessAction {
  ReturnType accept<ReturnType>(OnSuccessActionVisitor<ReturnType> visitor);
}

final class ShowSuccess extends Equatable implements OnSuccessAction {
  const ShowSuccess();

  @override
  ReturnType accept<ReturnType>(OnSuccessActionVisitor<ReturnType> visitor) {
    return visitor.visitShowSuccess(this);
  }

  @override
  List<Object?> get props => [];
}

abstract interface class OnSuccess
    implements CallbackCanBeParam, OnSuccessAction {}

abstract class OnSuccessDoTemplate
    extends CallbackCanBeParamTemplate<Future<void>> implements OnSuccess {
  const OnSuccessDoTemplate();

  List<Param> get params =>
      [ParamImpl(name: '', paramTypeAsString: successTypeAsString)];

  String get successTypeAsString;

  @override
  ReturnType accept<ReturnType>(OnSuccessActionVisitor<ReturnType> visitor) {
    return visitor.visitOnSuccess(this);
  }
}

final class OnSuccessDo<SuccessType> extends OnSuccessDoTemplate {
  const OnSuccessDo({
    required this.name,
  });

  final String name;

  String get successTypeAsString => '$SuccessType';
}
