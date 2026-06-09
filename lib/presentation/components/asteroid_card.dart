// lib/presentation/components/asteroid_card.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../domain/model/asteroid.dart';
import '../../app/app_theme.dart';
import 'risk_badge.dart';

class AsteroidCard extends StatelessWidget {
  final Asteroid asteroid;
  final bool isFavorite;
  final VoidCallback onTap;
  final VoidCallback onFavorite;

  const AsteroidCard({
    super.key,
    required this.asteroid,
    required this.isFavorite,
    required this.onTap,
    required this.onFavorite,
  });

  String _formatDistance(double km) {
    if (km >= 1000000) {
      return '${(km / 1000000).toStringAsFixed(2)} M km';
    }
    return '${NumberFormat('#,###').format(km.toInt())} km';
  }

  @override
  Widget build(BuildContext context) {
    final isHazardous = asteroid.isPotentiallyHazardous;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: AppTheme.bgCard,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isHazardous
                ? AppTheme.danger.withOpacity(0.3)
                : AppTheme.border,
            width: 1,
          ),
          boxShadow: isHazardous
              ? [
                  BoxShadow(
                    color: AppTheme.danger.withOpacity(0.08),
                    blurRadius: 20,
                    spreadRadius: 0,
                  )
                ]
              : null,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  // Asteroid icon
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: isHazardous
                          ? AppTheme.dangerDim
                          : AppTheme.bgSurface,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: isHazardous
                            ? AppTheme.danger.withOpacity(0.5)
                            : AppTheme.border,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        '☄',
                        style: TextStyle(
                          fontSize: 20,
                          color: isHazardous
                              ? AppTheme.danger
                              : AppTheme.amber,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          asteroid.name,
                          style: GoogleFonts.rajdhani(
                            color: AppTheme.textPrimary,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.5,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          'ID: ${asteroid.id}',
                          style: GoogleFonts.sourceCodePro(
                            color: AppTheme.textMuted,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: onFavorite,
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 200),
                      child: Icon(
                        isFavorite ? Icons.bookmark : Icons.bookmark_border,
                        key: ValueKey(isFavorite),
                        color: isFavorite ? AppTheme.amber : AppTheme.textMuted,
                        size: 22,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              // Data row
              Row(
                children: [
                  _DataChip(
                    label: 'DISTÂNCIA',
                    value: _formatDistance(asteroid.missDistanceKm),
                  ),
                  const SizedBox(width: 8),
                  _DataChip(
                    label: 'DIÂMETRO',
                    value:
                        '~${asteroid.diameterAvgKm.toStringAsFixed(2)} km',
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  RiskBadge(risk: asteroid.riskLevel),
                  const Spacer(),
                  Text(
                    asteroid.closeApproachDate,
                    style: GoogleFonts.sourceCodePro(
                      color: AppTheme.textMuted,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DataChip extends StatelessWidget {
  final String label;
  final String value;

  const _DataChip({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: AppTheme.bgSurface,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: AppTheme.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: GoogleFonts.rajdhani(
                color: AppTheme.textMuted,
                fontSize: 9,
                letterSpacing: 1.5,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              value,
              style: GoogleFonts.sourceCodePro(
                color: AppTheme.amber,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
