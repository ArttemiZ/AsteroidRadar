// lib/domain/repository/asteroid_repository.dart

import '../model/asteroid.dart';

abstract class AsteroidRepository {
  Future<List<Asteroid>> getAsteroids({
    required String startDate,
    required String endDate,
  });
}
