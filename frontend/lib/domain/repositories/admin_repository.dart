import 'package:dartz/dartz.dart';

import '../../core/errors/failures.dart';
import '../entities/dashboard_stats_entity.dart';

abstract class AdminRepository {
  Future<int> getTotalUsers();
  Future<int> getTotalItems();

}
