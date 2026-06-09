// lib/data/model/asteroid_model.dart

import '../../domain/model/asteroid.dart';

class AsteroidModel {
  final String id;
  final String name;
  final double diameterMinKm;
  final double diameterMaxKm;
  final bool isPotentiallyHazardous;
  final double relativeVelocityKmH;
  final double missDistanceKm;
  final String closeApproachDate;
  final String nasaJplUrl;
  final double absoluteMagnitude;

  const AsteroidModel({
    required this.id,
    required this.name,
    required this.diameterMinKm,
    required this.diameterMaxKm,
    required this.isPotentiallyHazardous,
    required this.relativeVelocityKmH,
    required this.missDistanceKm,
    required this.closeApproachDate,
    required this.nasaJplUrl,
    required this.absoluteMagnitude,
  });

  factory AsteroidModel.fromJson(Map<String, dynamic> json) {
    final diameter = json['estimated_diameter']['kilometers'];
    final closeApproach = json['close_approach_data'][0];
    return AsteroidModel(
      id: json['id'],
      name: (json['name'] as String).replaceAll(RegExp(r'[()]'), '').trim(),
      diameterMinKm: (diameter['estimated_diameter_min'] as num).toDouble(),
      diameterMaxKm: (diameter['estimated_diameter_max'] as num).toDouble(),
      isPotentiallyHazardous: json['is_potentially_hazardous_asteroid'],
      relativeVelocityKmH: double.parse(
        closeApproach['relative_velocity']['kilometers_per_hour'],
      ),
      missDistanceKm: double.parse(
        closeApproach['miss_distance']['kilometers'],
      ),
      closeApproachDate: closeApproach['close_approach_date'],
      nasaJplUrl: json['nasa_jpl_url'],
      absoluteMagnitude: (json['absolute_magnitude_h'] as num).toDouble(),
    );
  }

  Asteroid toDomain() => Asteroid(
        id: id,
        name: name,
        diameterMinKm: diameterMinKm,
        diameterMaxKm: diameterMaxKm,
        isPotentiallyHazardous: isPotentiallyHazardous,
        relativeVelocityKmH: relativeVelocityKmH,
        missDistanceKm: missDistanceKm,
        closeApproachDate: closeApproachDate,
        nasaJplUrl: nasaJplUrl,
        absoluteMagnitude: absoluteMagnitude,
      );
}
