import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/errors/failure_hundle.dart';
import '../../../core/provider/item_provider.dart';
import '../../../core/provider/provider.dart';
import '../../../core/utils/SaveJWT.dart';
import '../../../domain/usecase/auth/delete_account_usecase.dart';
import '../../../domain/usecase/auth/login_usecase.dart';
import '../../../domain/usecase/auth/logout_usecase.dart';
import '../../../domain/usecase/auth/register_usecase.dart';
import '../admin/admin_dashboard_provider.dart';
import 'auth_state.dart';
import '../../../domain/entities/user_entity.dart';

class AuthNotifier extends StateNotifier<AuthState> {
  final RegisterUseCase registerUseCase;
  final LoginUseCase loginUseCase;
  final GoRouter router;
  final Ref ref;
  final LogoutUseCase logoutUseCase;
  final DeleteAccountUseCase deleteAccountUseCase;

  AuthNotifier(this.ref,this.registerUseCase, this.loginUseCase, this.router,this.logoutUseCase,this.deleteAccountUseCase): super(AuthState.initial());

  Future<void> register(String name, String email, String password) async {
    state = AuthState.loading();
    final result = await registerUseCase.execute(name, email, password);

    result.fold(
          (failure) => state = AuthState.error(handleFailure(failure)),  // ✅ Use centralized failure handling
          (_) {
        state = AuthState.success();
        ref.read(adminDashboardProvider.notifier).loadStatistics();

        router.go('/login');
      },
    );
  }

  Future<void> login(String email, String password) async {
    state = AuthState.loading();
    final result = await loginUseCase.execute(email, password);

    result.fold(
          (failure) {
        print("❌ Login failed: ${handleFailure(failure)}");
        state = AuthState.error(handleFailure(failure));
      },
          (user) async {
        await saveJWT(user.token);  // ✅ Store JWT centrally
        _handleUserRedirection(user);
        ref.read(itemNotifierProvider.notifier).loadItems(); // ✅ Fetch items
      },
    );
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

  Future<void> logout() async {
    state = const AuthState.loading();

    try {
      final result = await logoutUseCase.execute();
      if (result) {
        await clearJWT();
        state = const AuthState.success();
        router.go('/login');
      } else {
        state = const AuthState.error("Logout failed");
      }
    } catch (e) {
      state = AuthState.error("Logout error: ${e.toString()}");
    }
  }
  Future<void> deleteAccount() async {
    state = const AuthState.loading();

    try {
      final userId = await getUserIdFromToken();
      if (userId == null) {
        state = const AuthState.error("Invalid token or user not logged in.");
        return;
      }

      final result = await deleteAccountUseCase.execute(userId);
      if (result) {
        await clearJWT(); // ✅ Remove token after deletion

        state = const AuthState.success();
        router.go('/login'); // ✅ Redirect to login after account deletion
      } else {
        state = const AuthState.error("Account deletion failed.");
      }
    } catch (e) {
      state = AuthState.error("Delete error: ${e.toString()}");
    }
  }
}