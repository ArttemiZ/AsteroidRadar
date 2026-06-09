// lib/app/app.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../app/app_theme.dart';
import '../data/remote/nasa_api_service.dart';
import '../data/repository/asteroid_repository_impl.dart';
import '../domain/usecase/get_asteroids_usecase.dart';
import '../presentation/navigation/app_router.dart';
import '../presentation/screens/favorites/favorites_viewmodel.dart';
import '../presentation/screens/list/asteroid_list_viewmodel.dart';

class AsteroidRadarApp extends StatelessWidget {
  const AsteroidRadarApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Dependency injection manual
    final apiService = NasaApiService();
    final repository = AsteroidRepositoryImpl(apiService);
    final useCase = GetAsteroidsUseCase(repository);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AsteroidListViewModel(useCase),
        ),
        ChangeNotifierProvider(
          create: (_) => FavoritesViewModel()..loadFavorites(),
        ),
      ],
      child: MaterialApp(
        title: 'Asteroid Radar',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.dark,
        initialRoute: '/',
        onGenerateRoute: AppRouter.generateRoute,
      ),
    );
  }
}
