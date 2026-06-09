// lib/presentation/screens/favorites/favorites_screen.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../app/app_theme.dart';
import '../../components/asteroid_card.dart';
import 'favorites_viewmodel.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bgDeep,
      appBar: AppBar(
        backgroundColor: AppTheme.bgDeep,
        title: const Text('FAVORITOS'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppTheme.amber, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(height: 1, color: AppTheme.border),
        ),
      ),
      body: Consumer<FavoritesViewModel>(
        builder: (context, vm, _) {
          final favorites = vm.favoriteAsteroids;

          if (favorites.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.bookmark_border,
                    color: AppTheme.textMuted,
                    size: 48,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'SEM FAVORITOS SALVOS',
                    style: GoogleFonts.rajdhani(
                      color: AppTheme.textMuted,
                      fontSize: 14,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Salve asteroides da lista para\nacessá-los aqui.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.sourceCodePro(
                      color: AppTheme.textMuted.withOpacity(0.6),
                      fontSize: 11,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
            itemCount: favorites.length,
            itemBuilder: (context, i) {
              final a = favorites[i];
              return AsteroidCard(
                asteroid: a,
                isFavorite: true,
                onTap: () =>
                    Navigator.pushNamed(context, '/detail', arguments: a),
                onFavorite: () => vm.toggleFavorite(a),
              );
            },
          );
        },
      ),
    );
  }
}
