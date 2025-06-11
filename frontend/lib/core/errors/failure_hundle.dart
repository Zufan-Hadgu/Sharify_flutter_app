import '../../core/errors/failures.dart';

String handleFailure(Failure failure) {
  return failure.when(
    serverFailure: (message) => message,
    authFailure: (message) => message,
    networkFailure: () => "Network issue occurred",
    cacheFailure: () => "Cache issue occurred",
    unknownFailure: (message) => message.isNotEmpty ? message : "An unknown error occurred", // ✅ Handle empty message
  );
}