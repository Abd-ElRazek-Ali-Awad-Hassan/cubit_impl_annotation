import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:failures/failures.dart';

import 'abstractions/callback_can_be_param_template.dart';
import 'entities/param_impl.dart';
import 'interfaces/callback_can_be_param.dart';
import 'interfaces/param.dart';

abstract interface class OnFailureActionVisitor<ReturnType> {
  ReturnType visitReportServerFailure(ReportServerFailure action);
  ReturnType visitReportNetworkFailure(ReportNetworkFailure action);
  ReturnType visitReportAuthorizedAccessFailure(
    ReportAuthorizedAccessFailure action,
  );
  ReturnType visitOnFailure(OnFailure action);
}

abstract class OnFailureAction {
  ReturnType accept<ReturnType>(
    OnFailureActionVisitor<ReturnType> visitor,
  );
}

final class ReportServerFailure extends Equatable implements OnFailureAction {
  const ReportServerFailure();

  @override
  List<Object?> get props => [];

  @override
  ReturnType accept<ReturnType>(OnFailureActionVisitor<ReturnType> visitor) {
    return visitor.visitReportServerFailure(this);
  }
}

final class ReportNetworkFailure extends Equatable implements OnFailureAction {
  const ReportNetworkFailure();

  @override
  List<Object?> get props => [];

  @override
  ReturnType accept<ReturnType>(OnFailureActionVisitor<ReturnType> visitor) {
    return visitor.visitReportNetworkFailure(this);
  }
}

final class ReportAuthorizedAccessFailure extends Equatable
    implements OnFailureAction {
  const ReportAuthorizedAccessFailure();

  @override
  List<Object?> get props => [];

  @override
  ReturnType accept<ReturnType>(OnFailureActionVisitor<ReturnType> visitor) {
    return visitor.visitReportAuthorizedAccessFailure(this);
  }
}

abstract interface class OnFailure
    implements CallbackCanBeParam, OnFailureAction {}

abstract class OnFailureDoTemplate
    extends CallbackCanBeParamTemplate<Future<void>> implements OnFailure {
  const OnFailureDoTemplate();

  List<Param> get params =>
      [ParamImpl(paramTypeAsString: failureTypeAsString, name: 'failure')];

  String get failureTypeAsString;

  @override
  ReturnType accept<ReturnType>(OnFailureActionVisitor<ReturnType> visitor) {
    return visitor.visitOnFailure(this);
  }
}

final class OnFailureDo<FailureType extends Failure>
    extends OnFailureDoTemplate {
  const OnFailureDo({
    required this.name,
  });

  @override
  final String name;

  String get failureTypeAsString => '$FailureType';
}
