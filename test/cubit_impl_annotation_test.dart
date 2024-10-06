import 'package:cubit_impl_annotation/cubit_impl_annotation.dart';
import 'package:failures/failures.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Cubit Impl Annotations', () {
    test('$ShowLoading is an $AsyncOperationThatEmits', () {
      expect(const ShowLoading(), isA<AsyncOperationThatEmits>());
    });

    group('$OnEither', () {
      test('$OnEither is an $AsyncOperationThatEmits', () {
        expect(const OnEither(), isA<AsyncOperationThatEmits>());
      });

      test('$OnEither requires callback', () {
        expect(const OnEither(), isA<RequiringCallback>());
      });

      group('onSuccessCommands', () {
        for (final e in const [
          ShowSuccess(),
          OnSuccessDo(callbackName: 'callback'),
        ]) {
          test('${e.runtimeType} is an $OnSuccessAction', () {
            expect(e, isA<OnSuccessAction>());
          });
        }

        test('$OnSuccessDo requires callback', () {
          expect(
            const OnSuccessDo(callbackName: 'callback'),
            isA<RequiringCallback>(),
          );
        });
      });

      group('onFailureCommands', () {
        for (final failure in const [
          ReportServerFailure(),
          ReportNetworkFailure(),
          ReportAuthorizedAccessFailure(),
          OnFailureDo<CacheFailure>(callbackName: 'callback'),
        ]) {
          test('${failure.runtimeType} is an $OnFailureAction', () {
            expect(failure, isA<OnFailureAction>());
          });
        }

        test('${OnFailureDo<CacheFailure>} requires callback', () {
          expect(
            const OnFailureDo<CacheFailure>(callbackName: 'callback'),
            isA<RequiringCallback>(),
          );
        });
      });
    });
  });
}
