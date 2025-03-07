// ignore_for_file: use_build_context_synchronously

import 'package:app_library/presentation/screens/auth/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_constant.dart';
import '../../../core/errors/network_failure.dart';
import '../../../core/errors/server_failure.dart';
import '../../../domain/usecases/get_user_usecase.dart';
import '../../states/user_state.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserState(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Sign In')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Consumer<UserState>(
            builder: (context, userState, child) {
              return userState.loading == true
                  ? const Center(child: CircularProgressIndicator())
                  : Column(
                      children: [
                        TextField(
                          controller: emailController,
                          decoration: const InputDecoration(labelText: 'Email'),
                        ),
                        TextField(
                          controller: passwordController,
                          decoration:
                              const InputDecoration(labelText: 'Password'),
                          obscureText: true,
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () async {
                            userState.setLoading(true); // Set loading true
                            final getUserUseCase = Provider.of<GetUserUseCase>(
                                context,
                                listen: false);

                            try {
                              AppConstants()
                                  .printLog('Trying to login...', 'info');
                              final user = await getUserUseCase.call(
                                emailController.text,
                                passwordController.text,
                              );

                              if (user.email != '') {
                                userState.setUser(user); // Set user state
                                AppConstants().printLog(
                                    'Login successful: $user', 'info');
                                // Navigate to home screen
                                Navigator.pushNamed(context, '/home');
                              } else {
                                userState.setError(
                                    'Login failed'); // Set error message
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Login failed')),
                                );
                              }
                            } catch (e) {
                              if (e is ServerFailure) {
                                AppConstants().printLog(e.toString(), 'error');
                                userState
                                    .setError(e.message); // Set error message
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      backgroundColor: Colors.red,
                                      content:
                                          Text('Login failed: ${e.message}')),
                                );
                                AppConstants()
                                    .printLog('Error: ${e.message}', 'error');
                              } else if (e is NetworkFailure) {
                                AppConstants().printLog(e.toString(), 'error');
                                // Tangani kesalahan jaringan
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      backgroundColor: Colors.red,
                                      content:
                                          Text('Network error: ${e.message}')),
                                );
                              } else {
                                // Tangani kesalahan lain jika perlu
                                // AppConstants().printLog(e.toString(), 'error');
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      backgroundColor: Colors.red,
                                      content: Text(
                                          'An unexpected error occurred: $e')),
                                );
                              }
                            } finally {
                              userState.setLoading(false); // Set loading false
                            }
                          },
                          child: const Text('Sign In'),
                        ),
                        const SizedBox(height: 20),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignupScreen()));
                          },
                          child: const Text('Daftar sekarang'),
                        ),
                      ],
                    );
            },
          ),
        ),
      ),
    );
  }
}
