// lib/presentation/screens/detail/asteroid_detail_screen.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../app/app_theme.dart';
import '../../../domain/model/asteroid.dart';
import '../../components/risk_badge.dart';
import '../favorites/favorites_viewmodel.dart';

class AsteroidDetailScreen extends StatelessWidget {
  const AsteroidDetailScreen({super.key});

  String _formatKm(double km) {
    return NumberFormat('#,###').format(km.toInt());
  }

  @override
  Widget build(BuildContext context) {
    final asteroid = ModalRoute.of(context)!.settings.arguments as Asteroid;
    final isHazardous = asteroid.isPotentiallyHazardous;

    return Scaffold(
      backgroundColor: AppTheme.bgDeep,
      body: CustomScrollView(
        slivers: [
          // Custom SliverAppBar with visual flair
          SliverAppBar(
            backgroundColor: AppTheme.bgDeep,
            expandedHeight: 220,
            pinned: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios,
                  color: AppTheme.amber, size: 18),
              onPressed: () => Navigator.pop(context),
            ),
            actions: [
              Consumer<FavoritesViewModel>(
                builder: (context, favVm, _) => IconButton(
                  icon: Icon(
                    favVm.isFavorite(asteroid.id)
                        ? Icons.bookmark
                        : Icons.bookmark_border,
                    color: AppTheme.amber,
                  ),
                  onPressed: () => favVm.toggleFavorite(asteroid),
                ),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  // Gradient background
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          isHazardous
                              ? AppTheme.danger.withOpacity(0.15)
                              : AppTheme.amber.withOpacity(0.1),
                          AppTheme.bgDeep,
                        ],
                      ),
                    ),
                  ),
                  // Asteroid visual
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 40),
                        Text(
                          '☄',
                          style: TextStyle(
                            fontSize: 72,
                            color: isHazardous
                                ? AppTheme.danger
                                : AppTheme.amber,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name + badge
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          asteroid.name,
                          style: GoogleFonts.rajdhani(
                            color: AppTheme.textPrimary,
                            fontSize: 28,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1,
                            height: 1.1,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      RiskBadge(risk: asteroid.riskLevel),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'NASA ID: ${asteroid.id}  ·  ${asteroid.closeApproachDate}',
                    style: GoogleFonts.sourceCodePro(
                      color: AppTheme.textMuted,
                      fontSize: 11,
                    ),
                  ),
                  const SizedBox(height: 32),

                  //Aproximação
                  _SectionTitle(title: 'APROXIMAÇÃO ORBITAL'),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      _DetailCard(
                        icon: Icons.straighten,
                        label: 'DISTÂNCIA',
                        value: '${_formatKm(asteroid.missDistanceKm)} km',
                        sub: '${(asteroid.missDistanceKm / 384400).toStringAsFixed(1)}x distância lunar',
                        color: isHazardous ? AppTheme.danger : AppTheme.safe,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      _DetailCard(
                        icon: Icons.speed,
                        label: 'VELOCIDADE',
                        value:
                            '${_formatKm(asteroid.relativeVelocityKmH)} km/h',
                        sub: '${(asteroid.relativeVelocityKmH / 3600).toStringAsFixed(1)} km/s',
                        color: AppTheme.amber,
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),

                  // Físico
                  _SectionTitle(title: 'DADOS FÍSICOS'),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      Expanded(
                        child: _SmallCard(
                          label: 'DIÂM. MÍN.',
                          value:
                              '${asteroid.diameterMinKm.toStringAsFixed(3)} km',
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _SmallCard(
                          label: 'DIÂM. MÁX.',
                          value:
                              '${asteroid.diameterMaxKm.toStringAsFixed(3)} km',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: _SmallCard(
                          label: 'MAGNITUDE',
                          value: asteroid.absoluteMagnitude.toStringAsFixed(1),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _SmallCard(
                          label: 'CLASSIFICAÇÃO',
                          value: isHazardous ? 'PERIGOSO' : 'SEGURO',
                          valueColor:
                              isHazardous ? AppTheme.danger : AppTheme.safe,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),

                  // Warning bar
                  if (isHazardous)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppTheme.dangerDim,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: AppTheme.danger.withOpacity(0.4),
                        ),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.warning_amber_rounded,
                              color: AppTheme.danger, size: 20),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'Este objeto está classificado como Potencialmente Perigoso pela NASA.',
                              style: GoogleFonts.sourceCodePro(
                                color: AppTheme.danger,
                                fontSize: 12,
                                height: 1.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(width: 3, height: 14, color: AppTheme.amber),
        const SizedBox(width: 10),
        Text(
          title,
          style: GoogleFonts.rajdhani(
            color: AppTheme.textSecondary,
            fontSize: 11,
            letterSpacing: 2,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

class _DetailCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final String sub;
  final Color color;

  const _DetailCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.sub,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppTheme.bgCard,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: color.withOpacity(0.2)),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: GoogleFonts.rajdhani(
                      color: AppTheme.textMuted,
                      fontSize: 9,
                      letterSpacing: 1.5,
                    ),
                  ),
                  Text(
                    value,
                    style: GoogleFonts.sourceCodePro(
                      color: color,
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    sub,
                    style: GoogleFonts.sourceCodePro(
                      color: AppTheme.textMuted,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SmallCard extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;

  const _SmallCard({required this.label, required this.value, this.valueColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: AppTheme.bgCard,
        borderRadius: BorderRadius.circular(10),
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
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: GoogleFonts.sourceCodePro(
              color: valueColor ?? AppTheme.amber,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
