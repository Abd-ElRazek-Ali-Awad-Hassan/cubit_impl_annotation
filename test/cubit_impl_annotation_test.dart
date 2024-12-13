import 'dart:async';

import 'package:cubit_impl_annotation/cubit_impl_annotation.dart';
import 'package:cubit_impl_annotation/src/command/async_operations/entities/param_impl.dart';
import 'package:failures/failures.dart';
import 'package:fpdart/fpdart.dart';
import 'package:test/test.dart';

void main() {
  group('Cubit Impl Annotations', () {
    _testObjectIsA<List<AsyncOperation>>(
      const Command([
        ShowLoading(),
        OnEither(
          onFailure: [
            ReportServerFailure(),
            ReportNetworkFailure(),
            ReportAuthorizedAccessFailure(),
          ],
          onSuccess: [ShowSuccess()],
          eitherCallback: EitherCallback<Failure, int>(name: ''),
        ),
      ]).operations,
      description: '$Command takes a ${List<AsyncOperation>}',
    );

    _testObjectIsA<AsyncOperation>(const ShowLoading());

    group('$OnEither', () {
      _testObjectIsA<AsyncOperation>(const OnEither(
        eitherCallback: EitherCallback<Failure, int>(name: ''),
      ));

      _testObjectIsCallback<Future<Either<Failure, int>>>(
        description: '$OnEither requires callback',
        object: OnEither(
          eitherCallback: EitherCallback<Failure, int>(name: ''),
        ).eitherCallback,
        expectedParams: [],
      );

      group('${OnSuccessAction}s', () {
        for (final e in const [
          ShowSuccess(),
          const OnSuccessDo(name: 'callback'),
        ]) {
          _testObjectIsA<OnSuccessAction>(e);
        }

        _testObjectIsCallback<Future<void>>(
          object: const OnSuccessDo(name: ''),
          expectedParams: [
            ParamImpl(name: '', paramTypeAsString: '$dynamic'),
          ],
        );
      });

      group('${OnFailureAction}s', () {
        for (final failure in const [
          ReportServerFailure(),
          ReportNetworkFailure(),
          ReportAuthorizedAccessFailure(),
          OnFailureDo(name: 'callback'),
        ]) {
          _testObjectIsA<OnFailureAction>(failure);
        }

        _testObjectIsCallback<Future<void>>(
          object: const OnFailureDo<Failure>(name: 'callback'),
          expectedParams: [
            ParamImpl(name: 'failure', paramTypeAsString: '$Failure'),
          ],
        );
      });
    });
  });
}

void _testObjectIsA<ExpectedType>(
  Object object, {
  String? description,
}) =>
    test(
      description ?? '${object.runtimeType} is an $ExpectedType',
      () => expect(object, isA<ExpectedType>()),
    );

void _testObjectIsCallback<ExpectedReturnType>({
  String? description,
  required Object object,
  List<Param> expectedParams = const [],
}) {
  test(description ?? '${object.runtimeType} is a $Callback', () {
    expect(object, isA<Callback>());
    Callback callback = object as Callback;
    expect(callback.returnTypeAsString, '$ExpectedReturnType');
    expect(callback.params, expectedParams);
  });
}
