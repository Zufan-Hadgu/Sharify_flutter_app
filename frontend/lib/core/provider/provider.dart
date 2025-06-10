import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sharify_flutter_app/domain/usecase/auth/delete_account_usecase.dart';
import 'package:sharify_flutter_app/domain/usecase/auth/logout_usecase.dart'; // ✅ Added logout use case
import '../../domain/usecase/auth/login_usecase.dart';
import '../../domain/usecase/auth/register_usecase.dart';
import '../../presentation/providers/auth/auth_notifier.dart';
import '../../presentation/providers/auth/auth_state.dart';
import '../../router/navigation.dart';
import '../network/dio_client.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../infrastructure/repositories/auth_repository_impl.dart';
import '../../infrastructure/datasources/remote/auth_remote.dart';
import '../../infrastructure/datasources/local/auth_local.dart';
import 'package:go_router/go_router.dart';
final dioProvider = Provider((ref) => DioClient().dio);

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return AuthRepositoryImpl(
    AuthLocal(), // SQLite storage
    AuthRemote(dio), // API calls
  );
});

final registerUseCaseProvider = Provider((ref) => RegisterUseCase(ref.watch(authRepositoryProvider)));
final loginUseCaseProvider = Provider((ref) => LoginUseCase(ref.watch(authRepositoryProvider)));
final deleteAccountUseCaseProvider = Provider((ref) => DeleteAccountUseCase(ref.watch(authRepositoryProvider)));
final logoutUseCaseProvider = Provider((ref) => LogoutUseCase(ref.watch(authRepositoryProvider)));

final authNotifierProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final registerUseCase = ref.watch(registerUseCaseProvider);
  final loginUseCase = ref.watch(loginUseCaseProvider);
  final deleteAccountUseCase = ref.watch(deleteAccountUseCaseProvider);
  final logoutUseCase = ref.watch(logoutUseCaseProvider); // ✅ Include logout use case
  final router = ref.watch(goRouterProvider);

  return AuthNotifier(ref,registerUseCase, loginUseCase,router,logoutUseCase, deleteAccountUseCase); // ✅ Pass all use cases
});