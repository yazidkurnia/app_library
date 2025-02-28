// lib/presentation/screens/home_screen.dart

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../../../core/errors/failure.dart';
import '../../../data/data_sources/localstorage/shared_preferences_service.dart';
import '../../../domain/usecases/get_user_usecase.dart';

class SignupScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  SignupScreen({super.key});

  get getUserUseCase => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign In')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final getUserUseCase =
                    GetIt.I<GetUserUseCase>(); // Mengambil instance dari GetIt

                try {
                  final user = await getUserUseCase.signUp(
                    emailController.text,
                    passwordController.text,
                  );
                  print('User  signed up: $user');
                } catch (e) {
                  if (e is Failure) {
                    // Handle failure (e.g., show error message)
                    print('Error: ${e.message}');
                  }
                }
              },
              child: const Text('Sign Up'),
            ),
            const SizedBox(height: 20),
            // ElevatedButton(
            //   onPressed: () async {
            //     // Ambil token dari SharedPreferences
            //     final token =
            //         await GetIt.I<SharedPreferencesService>().getToken();
            //     print('Token: $token'); // Tampilkan token di konsol
            //   },
            //   child: Text('Get Token'),
            // ),
          ],
        ),
      ),
    );
  }
}
