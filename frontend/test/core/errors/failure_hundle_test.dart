import 'package:flutter_test/flutter_test.dart';
import 'package:sharify_flutter_app/core/errors/failure_hundle.dart';
import 'package:sharify_flutter_app/core/errors/failures.dart';

void main() {
  group('handleFailure', () {
    test('returns correct message for ServerFailure', () {
      const failure = Failure.serverFailure('Server error occurred');
      final result = handleFailure(failure);
      expect(result, 'Server error occurred');
    });

    test('returns correct message for AuthFailure', () {
      const failure = Failure.authFailure('Authentication failed');
      final result = handleFailure(failure);
      expect(result, 'Authentication failed');
    });

    test('returns correct message for NetworkFailure', () {
      const failure = Failure.networkFailure();
      final result = handleFailure(failure);
      expect(result, 'Network issue occurred');
    });

    test('returns correct message for CacheFailure', () {
      const failure = Failure.cacheFailure();
      final result = handleFailure(failure);
      expect(result, 'Cache issue occurred');
    });
  });
}
