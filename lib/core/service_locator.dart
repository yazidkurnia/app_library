// lib/core/service_locator.dart

import 'package:get_it/get_it.dart';
import '../data/data_sources/localstorage/shared_preferences_service.dart';
import '../data/data_sources/remote_data_source.dart';
import '../data/repositories/user_repository.dart';
import '../domain/usecases/get_user_usecase.dart';
import 'networks/api_client.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  // Register services
  locator.registerLazySingleton<SharedPreferencesService>(
      () => SharedPreferencesService());
  locator.registerLazySingleton<ApiClient>(() => ApiClient());

  // Register data sources
  locator.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSource(locator<ApiClient>()));

  // Register repositories
  locator.registerLazySingleton<UserRepository>(() => UserRepository(
      locator<RemoteDataSource>(), locator<SharedPreferencesService>()));

  // Register use cases
  locator.registerLazySingleton<GetUserUseCase>(
      () => GetUserUseCase(locator<UserRepository>()));
}
