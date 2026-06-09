// lib/presentation/screens/list/asteroid_list_screen.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../app/app_theme.dart';
import '../../../domain/model/asteroid.dart';
import '../../components/asteroid_card.dart';
import '../../components/loading_widget.dart' as lw;
import '../../state/ui_state.dart';
import '../favorites/favorites_viewmodel.dart';
import 'asteroid_list_viewmodel.dart';

class AsteroidListScreen extends StatefulWidget {
  const AsteroidListScreen({super.key});

  @override
  State<AsteroidListScreen> createState() => _AsteroidListScreenState();
}

class _AsteroidListScreenState extends State<AsteroidListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AsteroidListViewModel>().loadAsteroids();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bgDeep,
      appBar: AppBar(
        backgroundColor: AppTheme.bgDeep,
        title: const Text('RASTREAMENTO ATIVO'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppTheme.amber, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.bookmark, color: AppTheme.amber),
            onPressed: () => Navigator.pushNamed(context, '/favorites'),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(height: 1, color: AppTheme.border),
        ),
      ),
      body: Consumer<AsteroidListViewModel>(
        builder: (context, vm, _) {
          return Column(
            children: [
              // Filter chips
              _FilterRow(
                current: vm.filter,
                onChanged: vm.setFilter,
              ),
              // Content
              Expanded(child: _buildBody(vm)),
            ],
          );
        },
      ),
    );
  }

  Widget _buildBody(AsteroidListViewModel vm) {
    final state = vm.state;
    if (state is InitialState || state is LoadingState) {
      return const lw.LoadingWidget();
    }
    if (state is ErrorState) {
      return lw.ErrorWidget(
        message: (state as ErrorState).message,
        onRetry: vm.loadAsteroids,
      );
    }
    final asteroids = (state as SuccessState<List<Asteroid>>).data;
    if (asteroids.isEmpty) {
      return Center(
        child: Text(
          'NENHUM ASTEROIDE ENCONTRADO',
          style: GoogleFonts.rajdhani(
            color: AppTheme.textMuted,
            fontSize: 14,
            letterSpacing: 2,
          ),
        ),
      );
    }

    return Consumer<FavoritesViewModel>(
      builder: (context, favVm, _) {
        favVm.syncAsteroids(asteroids);
        return ListView.builder(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
          itemCount: asteroids.length,
          itemBuilder: (context, i) {
            final a = asteroids[i];
            return AsteroidCard(
              asteroid: a,
              isFavorite: favVm.isFavorite(a.id),
              onTap: () =>
                  Navigator.pushNamed(context, '/detail', arguments: a),
              onFavorite: () => favVm.toggleFavorite(a),
            );
          },
        );
      },
    );
  }
}

class _FilterRow extends StatelessWidget {
  final RiskFilter current;
  final ValueChanged<RiskFilter> onChanged;

  const _FilterRow({required this.current, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      color: AppTheme.bgDeep,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          _Chip(
            label: 'TODOS',
            active: current == RiskFilter.all,
            onTap: () => onChanged(RiskFilter.all),
          ),
          const SizedBox(width: 8),
          _Chip(
            label: 'PERIGOSOS',
            active: current == RiskFilter.hazardous,
            onTap: () => onChanged(RiskFilter.hazardous),
            activeColor: AppTheme.danger,
          ),
          const SizedBox(width: 8),
          _Chip(
            label: 'SEGUROS',
            active: current == RiskFilter.safe,
            onTap: () => onChanged(RiskFilter.safe),
            activeColor: AppTheme.safe,
          ),
        ],
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  final String label;
  final bool active;
  final VoidCallback onTap;
  final Color activeColor;

  const _Chip({
    required this.label,
    required this.active,
    required this.onTap,
    this.activeColor = AppTheme.amber,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: active ? activeColor.withOpacity(0.15) : AppTheme.bgCard,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: active ? activeColor.withOpacity(0.6) : AppTheme.border,
          ),
        ),
        child: Text(
          label,
          style: GoogleFonts.rajdhani(
            color: active ? activeColor : AppTheme.textMuted,
            fontSize: 11,
            letterSpacing: 1.5,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
