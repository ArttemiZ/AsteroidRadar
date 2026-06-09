// lib/domain/usecase/get_asteroids_usecase.dart

import '../model/asteroid.dart';
import '../repository/asteroid_repository.dart';

class GetAsteroidsUseCase {
  final AsteroidRepository _repository;

  GetAsteroidsUseCase(this._repository);

  Future<List<Asteroid>> execute({
    required String startDate,
    required String endDate,
  }) async {
    final asteroids = await _repository.getAsteroids(
      startDate: startDate,
      endDate: endDate,
    );
    // Ordena: mais perigosos primeiro
    asteroids.sort((a, b) {
      if (a.isPotentiallyHazardous != b.isPotentiallyHazardous) {
        return a.isPotentiallyHazardous ? -1 : 1;
      }
      return a.missDistanceKm.compareTo(b.missDistanceKm);
    });
    return asteroids;
  }
}
