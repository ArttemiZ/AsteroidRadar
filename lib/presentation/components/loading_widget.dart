// lib/presentation/components/loading_widget.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../app/app_theme.dart';

class LoadingWidget extends StatefulWidget {
  final String? message;
  const LoadingWidget({super.key, this.message});

  @override
  State<LoadingWidget> createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RotationTransition(
            turns: _controller,
            child: Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppTheme.amber.withOpacity(0.3),
                  width: 2,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppTheme.amber,
                  ),
                  child: const Center(
                    child: Text('☄', style: TextStyle(fontSize: 20)),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            widget.message ?? 'ESCANEANDO ÓRBITAS...',
            style: GoogleFonts.rajdhani(
              color: AppTheme.amber,
              fontSize: 13,
              letterSpacing: 2,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class ErrorWidget extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;

  const ErrorWidget({super.key, required this.message, this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: AppTheme.dangerDim,
                shape: BoxShape.circle,
                border:
                    Border.all(color: AppTheme.danger.withOpacity(0.5), width: 1),
              ),
              child: const Icon(Icons.warning_amber_rounded,
                  color: AppTheme.danger, size: 32),
            ),
            const SizedBox(height: 20),
            Text(
              'FALHA NA CONEXÃO',
              style: GoogleFonts.rajdhani(
                color: AppTheme.danger,
                fontSize: 16,
                letterSpacing: 2,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: GoogleFonts.sourceCodePro(
                color: AppTheme.textSecondary,
                fontSize: 12,
              ),
            ),
            if (onRetry != null) ...[
              const SizedBox(height: 24),
              GestureDetector(
                onTap: onRetry,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24, vertical: 12),
                  decoration: BoxDecoration(
                    border:
                        Border.all(color: AppTheme.amber.withOpacity(0.5)),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'TENTAR NOVAMENTE',
                    style: GoogleFonts.rajdhani(
                      color: AppTheme.amber,
                      fontSize: 13,
                      letterSpacing: 1.5,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
