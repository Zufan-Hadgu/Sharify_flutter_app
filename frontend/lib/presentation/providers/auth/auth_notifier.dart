import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/errors/failure_hundle.dart';
import '../../../core/provider/item_provider.dart';
import '../../../core/provider/provider.dart';
import '../../../core/utils/SaveJWT.dart';
import '../../../domain/usecase/auth/login_usecase.dart';
import '../../../domain/usecase/auth/register_usecase.dart';
import '../../../router/navigation.dart';
import 'auth_state.dart';
import '../../../domain/entities/user_entity.dart';

class AuthNotifier extends StateNotifier<AuthState> {
  final RegisterUseCase registerUseCase;
  final LoginUseCase loginUseCase;
  final GoRouter router;
  final Ref ref;

  AuthNotifier(this.ref,this.registerUseCase, this.loginUseCase, this.router): super(AuthState.initial());

  /// Register a new user via API
  Future<void> register(String name, String email, String password) async {
    state = AuthState.loading();
    final result = await registerUseCase.execute(name, email, password);

    result.fold(
          (failure) => state = AuthState.error(handleFailure(failure)),  // ✅ Use centralized failure handling
          (_) {
        print("✅ Registration successful! Redirecting to login...");
        state = AuthState.success();
        router.go('/login');
      },
    );
  }

  /// Login via backend API
  Future<void> login(String email, String password) async {
    print("🔍 Starting login process for user: $email");

    state = AuthState.loading();
    final result = await loginUseCase.execute(email, password);

    result.fold(
          (failure) {
        print("❌ Login failed: ${handleFailure(failure)}");
        state = AuthState.error(handleFailure(failure));
      },
          (user) async {
        print("✅ Login successful! User Role: ${user.role}, User ID: ${user.id}");

        print("💾 Storing JWT Token...");
        await saveJWT(user.token);  // ✅ Store JWT centrally

        print("🔄 Redirecting user based on role...");
        _handleUserRedirection(user);

        print("🔄 Fetching items after login...");
        ref.read(itemNotifierProvider.notifier).loadItems(); // ✅ Fetch items
      },
    );

    print("🔚 Login process completed.");
  }

  void _handleUserRedirection(UserEntity user) async {
    final token = await getJWT();

    if (token == null || token.isEmpty) {
      router.go('/login');
    } else if (user.role == "admin") {
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

  return AuthNotifier(ref, registerUseCase, loginUseCase, router); // ✅ Pass ref here
});