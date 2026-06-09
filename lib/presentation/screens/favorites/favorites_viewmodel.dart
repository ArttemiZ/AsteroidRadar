// lib/presentation/screens/favorites/favorites_viewmodel.dart

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../domain/model/asteroid.dart';

class FavoritesViewModel extends ChangeNotifier {
  static const _key = 'favorite_asteroid_ids';

  Set<String> _favoriteIds = {};
  List<Asteroid> _favoriteAsteroids = [];

  Set<String> get favoriteIds => _favoriteIds;
  List<Asteroid> get favoriteAsteroids => _favoriteAsteroids;

  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final ids = prefs.getStringList(_key) ?? [];
    _favoriteIds = ids.toSet();
    notifyListeners();
  }

  bool isFavorite(String id) => _favoriteIds.contains(id);

  Future<void> toggleFavorite(Asteroid asteroid) async {
    final prefs = await SharedPreferences.getInstance();
    if (_favoriteIds.contains(asteroid.id)) {
      _favoriteIds.remove(asteroid.id);
      _favoriteAsteroids.removeWhere((a) => a.id == asteroid.id);
    } else {
      _favoriteIds.add(asteroid.id);
      _favoriteAsteroids.add(asteroid);
    }
    await prefs.setStringList(_key, _favoriteIds.toList());
    notifyListeners();
  }

  void syncAsteroids(List<Asteroid> all) {
    _favoriteAsteroids = all
        .where((a) => _favoriteIds.contains(a.id))
        .toList();
    notifyListeners();
  }
}
