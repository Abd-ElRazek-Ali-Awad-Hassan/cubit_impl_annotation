import 'package:cubit_impl_annotation/cubit_impl_annotation.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Cubit Impl Annotations', () {
    test('$ShowLoading is a CubitMethodCommand', () {
      expect(const ShowLoading(), isA<CubitMethodCommand>());
    });

    group('$OnEither', () {
      test('$OnEither is a CubitMethodCommand', () {
        expect(const OnEither(), isA<CubitMethodCommand>());
      });

      test('$OnEither requires callback', () {
        expect(const OnEither(), isA<RequiringCallback>());
      });

      group('onSuccessCommands', () {
        for (final e in const [
          ShowSuccess(),
          OnSuccessDo(callbackName: 'callback'),
        ]) {
          test('${e.runtimeType} is an onSuccessCommand', () {
            expect(e, isA<OnSuccessCommand>());
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
          OnFailureDo(callbackName: 'callback'),
        ]) {
          test('${failure.runtimeType} is an onFailureCommand', () {
            expect(failure, isA<OnFailureCommand>());
          });
        }

        test('$OnFailureDo requires callback', () {
          expect(
            const OnFailureDo(callbackName: 'callback'),
            isA<RequiringCallback>(),
          );
        });
      });
    });
  });
}
