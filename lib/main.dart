import 'package:app_library/data/data_sources/remote_data_source.dart';
import 'package:app_library/domain/usecases/get_user_usecase.dart';
import 'package:app_library/presentation/presenters/book_presenter.dart';
import 'package:app_library/presentation/presenters/transaction_presenter.dart';
import 'package:app_library/presentation/screens/auth/login_screen.dart';
import 'package:app_library/presentation/screens/home/home_screen.dart';
import 'package:app_library/presentation/states/books/all_book_state.dart';
import 'package:app_library/presentation/states/books/detail_book_state.dart';
import 'package:app_library/presentation/states/books/topfivebook_state.dart';
import 'package:app_library/presentation/states/transactions/transaction_state.dart';
import 'package:app_library/presentation/states/user_state.dart';
import 'package:app_library/providers/api_provider.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import 'core/networks/api_client.dart';
import 'core/service_locator.dart';
import 'data/data_sources/localstorage/shared_preferences_service.dart';
import 'data/repositories/user_repository.dart';

void main() {
  setupLocator();
  runApp(
    ChangeNotifierProvider(
      create: (context) => ApiProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // final token =
    //             await GetIt.I<SharedPreferencesService>().getToken();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserState()),
        Provider<BookPresenter>(
          create: (context) => GetIt.I<BookPresenter>(),
        ),

        Provider<TransactionPresenter>(
            create: (context) => GetIt.I<TransactionPresenter>()),
        ChangeNotifierProvider<TopFiveBookState>(
          create: (context) => TopFiveBookState(),
        ),
        ChangeNotifierProvider<AllBookState>(
          create: (context) => AllBookState(),
        ),
        ChangeNotifierProvider<DetailBookState>(
          create: (context) => DetailBookState(),
        ),
        ChangeNotifierProvider<TransactionState>(
          create: (context) => TransactionState(),
        ),
        Provider(create: (context) => ApiClient()),
        Provider(
            create: (context) => SharedPreferencesService()), // Tambahkan ini
        ProxyProvider<ApiClient, RemoteDataSource>(
          update: (context, apiClient, previous) => RemoteDataSource(apiClient),
        ),
        ProxyProvider2<RemoteDataSource, SharedPreferencesService,
            UserRepository>(
          update:
              (context, remoteDataSource, sharedPreferencesService, previous) =>
                  UserRepository(remoteDataSource, sharedPreferencesService),
        ),
        ProxyProvider<UserRepository, GetUserUseCase>(
          update: (context, userRepository, previous) =>
              GetUserUseCase(userRepository),
        ),
      ],
      child: MaterialApp(
        title: 'User  Sign In',
        routes: {'/home': (context) => const HomeScreen()},
        theme: ThemeData(primarySwatch: Colors.blue),
        home: FutureBuilder<String?>(
          future: GetIt.I<SharedPreferencesService>().getToken(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // Tampilkan loading indicator saat menunggu token
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData && snapshot.data != 'No token found') {
              // Jika token ada, arahkan ke HomeScreen
              return const HomeScreen();
            } else {
              // Jika token tidak ada, arahkan ke LoginScreen
              return LoginScreen();
            }
          },
        ),
      ),
    );
  }
}
