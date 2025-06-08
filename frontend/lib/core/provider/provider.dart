import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/usecase/auth/login_usecase.dart';
import '../../domain/usecase/auth/register_usecase.dart';
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
    AuthLocal(), // SQLite
    AuthRemote(dio), // API
  );
});
final registerUseCaseProvider = Provider((ref) => RegisterUseCase(ref.watch(authRepositoryProvider)));
final loginUseCaseProvider = Provider((ref) => LoginUseCase(ref.watch(authRepositoryProvider)));


