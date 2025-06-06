import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/provider/provider.dart';
import '../../../domain/usecase/auth/login_usecase.dart';
import '../../../domain/usecase/auth/register_usecase.dart';

import '../../../router/navigation.dart';
import 'auth_state.dart';
import '../../../domain/entities/user_entity.dart';

class AuthNotifier extends StateNotifier<AuthState> {
  final RegisterUseCase registerUseCase;
  final LoginUseCase loginUseCase;
  final GoRouter router;

  AuthNotifier(this.registerUseCase, this.loginUseCase, this.router) : super(AuthState.initial());

  /// Register a new user
  Future<void> register(String name, String email, String password) async {
    state = AuthState.loading();
    final result = await registerUseCase.execute(name, email, password);

    result.fold(
          (failure) {
        print("Registration failed: ${failure.toString()}");
        state = AuthState.error(failure.map(
          serverFailure: (f) => f.message,
          authFailure: (f) => f.message,
          networkFailure: (_) => "Network issue occurred",
          cacheFailure: (_) => "Cache issue occurred",
        ));
      },
          (_) {
        print("Registration successful! Redirecting to login...");
        state = AuthState.success();
        router.go('/login'); // ✅ Redirect users to login after registering
      },
    );
  }
  Future<void> login(String email, String password) async {
    state = AuthState.loading();
    final result = await loginUseCase.execute(email, password);

    result.fold(
          (failure) => state = AuthState.error(
        failure.map(
          serverFailure: (f) => f.message,
          authFailure: (f) => f.message,
          networkFailure: (_) => "Network issue occurred",
          cacheFailure: (_) => "Cache issue occurred",
        ),
      ),
          (user) {
        state = AuthState.success();
        print("registration successful redirecting to login ---");
        _handleUserRedirection(user);
      },
    );
  }

  void _handleUserRedirection(UserEntity user) {
    if (user.role == "admin") {
      router.go('/admin_home');
    } else {
      router.go('/user_home');
    }
  }
}

final authNotifierProvider =
StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final registerUseCase = ref.watch(registerUseCaseProvider);
  final loginUseCase = ref.watch(loginUseCaseProvider);
  final router = ref.watch(goRouterProvider);
  return AuthNotifier(registerUseCase, loginUseCase, router);
});