import 'package:cubit_impl_annotation/cubit_impl_annotation.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Cubit Impl Annotations', () {
    test('showLoading is a CubitMethodCommand', () {
      expect(const ShowLoading(), isA<CubitMethodCommand>());
    });

    test('showLoadingByCalling is a CubitMethodCommand', () {
      expect(const ShowLoadingByCalling(), isA<CubitMethodCommand>());
    });

    test('showLoadingByCalling requires callback', () {
      expect(const ShowLoadingByCalling(), isA<RequiringCallback>());
    });

    group('onEither', () {
      test('onEither is a CubitMethodCommand', () {
        expect(const OnEither(), isA<CubitMethodCommand>());
      });

      test('onEither requires callback', () {
        expect(const OnEither(), isA<RequiringCallback>());
      });

      group('onSuccessCommands', () {
        for (final e in const [
          ShowSuccess(),
          ShowSuccessByCalling(callbackName: 'callback'),
        ]) {
          test('${e.runtimeType} is an onSuccessCommand', () {
            expect(e, isA<OnSuccessCommand>());
          });
        }

        test('showSuccessByCalling requires callback', () {
          expect(
            const ShowSuccessByCalling(callbackName: 'callback'),
            isA<RequiringCallback>(),
          );
        });
      });

      group('onFailureCommands', () {
        for (final failure in const [
          ReportServerFailure(),
          ReportNetworkFailure(),
          ReportAuthorizedAccessFailure(),
          ReportFailureByCalling(callbackName: 'callback'),
        ]) {
          test('${failure.runtimeType} is an onFailureCommand', () {
            expect(failure, isA<OnFailureCommand>());
          });
        }

        test('ReportFailureByCalling requires callback', () {
          expect(
            const ReportFailureByCalling(callbackName: 'callback'),
            isA<RequiringCallback>(),
          );
        });
      });
    });
  });
}
