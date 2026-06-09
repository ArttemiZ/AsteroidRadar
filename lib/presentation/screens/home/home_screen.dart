// lib/presentation/screens/home/home_screen.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../app/app_theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeIn;
  late Animation<Offset> _slideUp;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );
    _fadeIn = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
          parent: _controller,
          curve: const Interval(0.2, 1.0, curve: Curves.easeOut)),
    );
    _slideUp = Tween<Offset>(
      begin: const Offset(0, 0.08),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
          parent: _controller,
          curve: const Interval(0.2, 1.0, curve: Curves.easeOut)),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bgDeep,
      body: Stack(
        children: [
          // Starfield background
          _StarField(),
          // Glow orb
          Positioned(
            top: -100,
            right: -80,
            child: Container(
              width: 350,
              height: 350,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppTheme.amber.withOpacity(0.12),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          SafeArea(
            child: FadeTransition(
              opacity: _fadeIn,
              child: SlideTransition(
                position: _slideUp,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 28),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 60),
                      // Label
                      _ScanLine(label: 'FIAP · GLOBAL SOLUTION 2026.1'),
                      const SizedBox(height: 32),
                      // Title
                      Text(
                        'ASTEROID',
                        style: GoogleFonts.rajdhani(
                          color: AppTheme.textPrimary,
                          fontSize: 56,
                          fontWeight: FontWeight.w700,
                          height: 0.9,
                          letterSpacing: 4,
                        ),
                      ),
                      Text(
                        'RADAR',
                        style: GoogleFonts.rajdhani(
                          color: AppTheme.amber,
                          fontSize: 56,
                          fontWeight: FontWeight.w700,
                          height: 0.9,
                          letterSpacing: 4,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Monitoramento em tempo real de\nobjetos próximos à Terra via\ndados NASA NeoWs API.',
                        style: GoogleFonts.sourceCodePro(
                          color: AppTheme.textSecondary,
                          fontSize: 13,
                          height: 1.7,
                        ),
                      ),
                      const SizedBox(height: 48),
                      // Stats row
                      Row(
                        children: [
                          _StatBox(
                            value: '7',
                            label: 'DIAS\nRASTREADOS',
                          ),
                          const SizedBox(width: 12),
                          _StatBox(
                            value: 'NASA',
                            label: 'FONTE\nOFICIAL',
                          ),
                          const SizedBox(width: 12),
                          _StatBox(
                            value: '4',
                            label: 'NÍVEIS\nDE RISCO',
                          ),
                        ],
                      ),
                      const Spacer(),
                      // CTA Button
                      _RadarButton(
                        onTap: () => Navigator.pushNamed(context, '/list'),
                      ),
                      const SizedBox(height: 48),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ScanLine extends StatelessWidget {
  final String label;
  const _ScanLine({required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 24,
          height: 1,
          color: AppTheme.amber,
        ),
        const SizedBox(width: 10),
        Text(
          label,
          style: GoogleFonts.rajdhani(
            color: AppTheme.amber,
            fontSize: 11,
            letterSpacing: 2,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class _StatBox extends StatelessWidget {
  final String value;
  final String label;
  const _StatBox({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppTheme.bgCard,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppTheme.border),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: GoogleFonts.rajdhani(
                color: AppTheme.amber,
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              label,
              textAlign: TextAlign.center,
              style: GoogleFonts.rajdhani(
                color: AppTheme.textMuted,
                fontSize: 9,
                letterSpacing: 1,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RadarButton extends StatefulWidget {
  final VoidCallback onTap;
  const _RadarButton({required this.onTap});

  @override
  State<_RadarButton> createState() => _RadarButtonState();
}

class _RadarButtonState extends State<_RadarButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulse;

  @override
  void initState() {
    super.initState();
    _pulse = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulse.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: AnimatedBuilder(
        animation: _pulse,
        builder: (_, __) => Container(
          width: double.infinity,
          height: 58,
          decoration: BoxDecoration(
            color: AppTheme.amber,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: AppTheme.amber
                    .withOpacity(0.2 + _pulse.value * 0.2),
                blurRadius: 20 + _pulse.value * 10,
                spreadRadius: 0,
              ),
            ],
          ),
          child: Center(
            child: Text(
              'INICIAR RASTREAMENTO ›',
              style: GoogleFonts.rajdhani(
                color: AppTheme.bgDeep,
                fontSize: 16,
                fontWeight: FontWeight.w800,
                letterSpacing: 2,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Simple starfield painter
class _StarField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _StarPainter(),
      size: Size.infinite,
    );
  }
}

class _StarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white;
    final stars = [
      [0.1, 0.08, 1.2], [0.3, 0.15, 0.8], [0.7, 0.05, 1.5],
      [0.9, 0.12, 1.0], [0.05, 0.35, 0.6], [0.55, 0.25, 1.3],
      [0.85, 0.4, 0.9], [0.2, 0.55, 0.7], [0.65, 0.5, 1.1],
      [0.4, 0.7, 0.8], [0.8, 0.65, 1.4], [0.15, 0.8, 1.0],
      [0.5, 0.85, 0.6], [0.92, 0.78, 1.2], [0.35, 0.92, 0.9],
      [0.75, 0.9, 0.7], [0.6, 0.3, 1.6], [0.25, 0.45, 0.5],
    ];
    for (final s in stars) {
      paint.color = Colors.white.withOpacity(0.4 + s[2] * 0.2);
      canvas.drawCircle(
        Offset(size.width * s[0], size.height * s[1]),
        s[2],
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
