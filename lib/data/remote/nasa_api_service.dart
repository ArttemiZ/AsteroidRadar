// lib/data/remote/nasa_api_service.dart

import 'package:dio/dio.dart';
import '../model/asteroid_model.dart';

class NasaApiService {
  static const _baseUrl = 'https://api.nasa.gov/neo/rest/v1';
  static const _apiKey = 'Trhk9ov5vRQjWZevh3G1SrsnmnOvWmDn0CDHAs29';

  late final Dio _dio;

  NasaApiService() {
    _dio = Dio(
      BaseOptions(
        baseUrl: _baseUrl,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
      ),
    );
  }

  Future<List<AsteroidModel>> fetchAsteroids({
    required String startDate,
    required String endDate,
  }) async {
    final response = await _dio.get(
      '/feed',
      queryParameters: {
        'start_date': startDate,
        'end_date': endDate,
        'api_key': _apiKey,
      },
    );

    final nearEarthObjects =
        response.data['near_earth_objects'] as Map<String, dynamic>;

    final List<AsteroidModel> asteroids = [];
    for (final dateKey in nearEarthObjects.keys) {
      final list = nearEarthObjects[dateKey] as List<dynamic>;
      asteroids.addAll(
        list.map((json) => AsteroidModel.fromJson(json as Map<String, dynamic>)),
      );
    }
    return asteroids;
  }
}
