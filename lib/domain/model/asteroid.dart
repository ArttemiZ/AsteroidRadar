// lib/domain/model/asteroid.dart

class Asteroid {
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

  const Asteroid({
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

  String get riskLevel {
    if (isPotentiallyHazardous && missDistanceKm < 500000) return 'CRÍTICO';
    if (isPotentiallyHazardous) return 'ALTO';
    if (missDistanceKm < 1000000) return 'MÉDIO';
    return 'BAIXO';
  }

  double get diameterAvgKm => (diameterMinKm + diameterMaxKm) / 2;
}
