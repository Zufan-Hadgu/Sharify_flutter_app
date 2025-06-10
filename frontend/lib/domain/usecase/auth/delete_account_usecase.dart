import '../../repositories/auth_repository.dart';

class DeleteAccountUseCase {
  final AuthRepository authRepository;

  DeleteAccountUseCase(this.authRepository);

  Future<bool> execute(String userId) async {
    return await authRepository.deleteAccount();
  }
}