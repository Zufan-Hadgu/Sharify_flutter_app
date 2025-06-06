import 'package:dartz/dartz.dart';
import '../../core/errors/failures.dart';

import '../../../domain/repositories/auth_repository.dart';
import '../../../domain/entities/user_entity.dart';
import '../datasources/local/auth_local.dart';
import '../datasources/remote/auth_remote.dart';
import '../models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthLocal authLocal;
  final AuthRemote authRemote;

  AuthRepositoryImpl(this.authLocal, this.authRemote);

  @override
  Future<Either<Failure, void>> register(String name, String email, String password) async {
    try {
      final user = UserModel(
        id: "", // API will generate the actual ID
        name: name,
        email: email,
        password: password,
        role: "user", profilePicture: '',
      );

      await authRemote.registerUser(user); // Call API
      await authLocal.saveUser(user); // Save locally
      return const Right(null);
    } catch (e) {
      return Left(Failure.serverFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> login(String email, String password) async {
    try {
      final user = await authRemote.login(email, password);

      if (user != null) {
        await authLocal.saveUser(user); // Save after login
        return Right(UserEntity(
          id: user.id,
          name: user.name,
          email: user.email,
          role: user.role,
          profilePicture: user.profilePicture,
        ));
      }


      final localUser = await authLocal.getUserByEmail(email);
      if (localUser != null) {
        return Right(UserEntity(
          id: localUser.id,
          name: localUser.name,
          email: localUser.email,
          role: localUser.role,
          profilePicture: localUser.profilePicture,
        ));
      }

      return Left(Failure.authFailure("Invalid email or password"));
    } catch (e) {
      return Left(Failure.serverFailure(e.toString()));
    }
  }
}