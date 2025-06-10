import 'package:dartz/dartz.dart';
import '../../core/errors/failures.dart';
import '../entities/user_entity.dart';

abstract class AuthRepository {
  /// Registers a new user with default "user" role
  Future<Either<Failure, void>> register(String name, String email, String password);
  Future<Either<Failure, UserEntity>> login(String email, String password);
  Future<bool>logout();
  Future<bool>deleteAccount();
}