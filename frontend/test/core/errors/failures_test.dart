// test/core/errors/failures_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:sharify_flutter_app/core/errors/failures.dart';

void main() {
  group('Failures', () {
    test('ServerFailure should be equatable', () {
      const failure1 = ServerFailure('Server error');
      const failure2 = ServerFailure('Server error');

      expect(failure1, equals(failure2));
      expect(failure1.toString(), contains('Server error'));
    });

    test('UnknownFailure should contain message', () {
      const failure = UnknownFailure('Something went wrong');

      expect(failure.message, contains('Something went wrong'));
    });
  });
}
