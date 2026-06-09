// lib/presentation/components/risk_badge.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../app/app_theme.dart';

class RiskBadge extends StatelessWidget {
  final String risk;

  const RiskBadge({super.key, required this.risk});

  Color get _color {
    switch (risk) {
      case 'CRÍTICO':
        return AppTheme.danger;
      case 'ALTO':
        return const Color(0xFFE85020);
      case 'MÉDIO':
        return AppTheme.amber;
      default:
        return AppTheme.safe;
    }
  }

  Color get _bg {
    switch (risk) {
      case 'CRÍTICO':
        return AppTheme.dangerDim;
      case 'ALTO':
        return const Color(0xFF5C2010);
      case 'MÉDIO':
        return AppTheme.amberDim;
      default:
        return AppTheme.safeDim;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: _bg,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: _color.withOpacity(0.6), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: _color,
              shape: BoxShape.circle,
              boxShadow: [BoxShadow(color: _color, blurRadius: 4)],
            ),
          ),
          const SizedBox(width: 6),
          Text(
            risk,
            style: GoogleFonts.rajdhani(
              color: _color,
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
