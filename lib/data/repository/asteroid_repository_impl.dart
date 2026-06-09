// lib/data/repository/asteroid_repository_impl.dart

import '../../domain/model/asteroid.dart';
import '../../domain/repository/asteroid_repository.dart';
import '../remote/nasa_api_service.dart';

class AsteroidRepositoryImpl implements AsteroidRepository {
  final NasaApiService _apiService;

  AsteroidRepositoryImpl(this._apiService);

  @override
  Future<List<Asteroid>> getAsteroids({
    required String startDate,
    required String endDate,
  }) async {
    final models = await _apiService.fetchAsteroids(
      startDate: startDate,
      endDate: endDate,
    );
    return models.map((m) => m.toDomain()).toList();
  }
}
