import '../../core/constants/app_constant.dart';
import '../../core/networks/api_client.dart';

class RemoteDataSource {
  final ApiClient apiClient;
  RemoteDataSource(this.apiClient);

  //* param string email
  //* param string password
  Future<dynamic> signIn(String email, String password) async {
    final payload = {'email': email, 'password': password}; //* defined payload

    return await apiClient.post(
        AppConstants.signInEndpoint, payload); //! return api client
  }

  Future<dynamic> signUp(String email, String password) async {
    final payload = {'email': email, 'password': password};

    return await apiClient.post(
        AppConstants.signUpEndpoint, payload); //! return api client
  }
}
