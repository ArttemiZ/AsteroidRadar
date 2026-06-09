// lib/presentation/screens/list/asteroid_list_viewmodel.dart

import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import '../../../domain/model/asteroid.dart';
import '../../../domain/usecase/get_asteroids_usecase.dart';
import '../../state/ui_state.dart';

enum RiskFilter { all, hazardous, safe }

class AsteroidListViewModel extends ChangeNotifier {
  final GetAsteroidsUseCase _useCase;

  AsteroidListViewModel(this._useCase);

  UiState<List<Asteroid>> _state = const InitialState();
  List<Asteroid> _allAsteroids = [];
  RiskFilter _filter = RiskFilter.all;

  UiState<List<Asteroid>> get state => _state;
  RiskFilter get filter => _filter;

  List<Asteroid> get filteredAsteroids {
    if (_allAsteroids.isEmpty) return [];
    switch (_filter) {
      case RiskFilter.hazardous:
        return _allAsteroids
            .where((a) => a.isPotentiallyHazardous)
            .toList();
      case RiskFilter.safe:
        return _allAsteroids
            .where((a) => !a.isPotentiallyHazardous)
            .toList();
      case RiskFilter.all:
        return _allAsteroids;
    }
  }

  Future<void> loadAsteroids() async {
    _state = const LoadingState();
    notifyListeners();

    try {
      final now = DateTime.now();
      final start = DateFormat('yyyy-MM-dd').format(now);
      final end = DateFormat('yyyy-MM-dd')
          .format(now.add(const Duration(days: 7)));

      final asteroids = await _useCase.execute(
        startDate: start,
        endDate: end,
      );
      _allAsteroids = asteroids;
      _state = SuccessState(filteredAsteroids);
    } catch (e) {
      _state = ErrorState(e.toString());
    }
    notifyListeners();
  }

  void setFilter(RiskFilter f) {
    _filter = f;
    _state = SuccessState(filteredAsteroids);
    notifyListeners();
  }
}
