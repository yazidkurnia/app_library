// lib/core/service_locator.dart

import 'package:app_library/data/data_sources/remote_data_source/rds_transaction.dart';
import 'package:app_library/data/repositories/book_repository.dart';
import 'package:app_library/data/repositories/transaction_repository.dart';
import 'package:app_library/domain/repositories/transaction_repository_interface.dart';
import 'package:app_library/domain/usecases/transactions/post_transaction_usecase.dart';
import 'package:app_library/presentation/presenters/transaction_presenter.dart';
import 'package:get_it/get_it.dart';
import '../data/data_sources/localstorage/shared_preferences_service.dart';
import '../data/data_sources/remote_data_source.dart';
import '../data/repositories/user_repository.dart';
import '../domain/repositories/book_repository_interface.dart';
import '../domain/usecases/books/get_book_usecase.dart';
import '../domain/usecases/get_user_usecase.dart';
import '../domain/usecases/transactions/get_transaction_usecase.dart';
import '../presentation/presenters/book_presenter.dart';
import 'networks/api_client.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  //* Register services
  locator.registerLazySingleton<SharedPreferencesService>(
      () => SharedPreferencesService());
  locator.registerLazySingleton<ApiClient>(() => ApiClient());

  //* Register data sources
  locator.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSource(locator<ApiClient>()));

  //* Register repositories
  locator.registerLazySingleton<UserRepository>(() => UserRepository(
      locator<RemoteDataSource>(), locator<SharedPreferencesService>()));

  //* Register BookRepositoryInterface
  locator.registerLazySingleton<BookRepositoryInterface>(
      () => BookRepository(locator<RemoteDataSource>()));

  //* Register use cases
  locator.registerLazySingleton<GetUserUseCase>(
      () => GetUserUseCase(locator<UserRepository>()));

  locator.registerLazySingleton<GetBookUseCase>(
      () => GetBookUseCase(locator<BookRepositoryInterface>()));

  //* Register BookPresenter
  locator.registerLazySingleton<BookPresenter>(
      () => BookPresenter(locator<GetBookUseCase>()));

  //* Register transaction data source
  locator.registerLazySingleton<RdsTransaction>(
      () => RdsTransaction(locator<ApiClient>()));

  //* Register transaction repository
  locator.registerLazySingleton<TransactionRepository>(
      () => TransactionRepository(locator<RdsTransaction>()));

  //* Register transaction repository interface
  locator.registerLazySingleton<TransactionRepositoryInterface>(
      () => TransactionRepository(locator<RdsTransaction>()));

  //* Register transaction use case
  locator.registerLazySingleton<PostTransactionUseCase>(
      () => PostTransactionUseCase(locator<TransactionRepository>()));

  //* Register transaction presenter
  locator.registerLazySingleton<TransactionPresenter>(() =>
      TransactionPresenter(
          locator<PostTransactionUseCase>(), locator<GetTransactionUseCase>()));

  locator.registerLazySingleton<GetTransactionUseCase>(
      () => GetTransactionUseCase(locator<TransactionRepository>()));
}
