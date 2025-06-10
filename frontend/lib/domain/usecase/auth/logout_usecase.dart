import '../../repositories/auth_repository.dart';


class LogoutUseCase {
  final AuthRepository authRepository;

  LogoutUseCase(this.authRepository);

  Future<bool> execute() async {
    return await authRepository.logout();
  }
}