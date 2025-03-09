import '../../core/constants/app_constant.dart';
import '../../core/constants/debug_log.dart';
import '../../core/networks/api_client.dart';

class RemoteDataSource {
  final ApiClient apiClient;
  RemoteDataSource(this.apiClient);

  //* remote data auth
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

  //* remote data book source
  Future<dynamic> getAllBooks() async {
    return await apiClient.get(AppConstants.allBook);
  }

  Future<dynamic> getTopFiveBook() async {
    return await apiClient.get(AppConstants.topFiveBookEndpoint);
  }

  Future<dynamic> getBookDetail(String bookId) async {
    DebugLog().printLog('endpoint: ${AppConstants.detailBook}$bookId', 'info');
    final response = await apiClient.get('${AppConstants.detailBook}$bookId');
    DebugLog().printLog('response: $response', 'info');
    return await apiClient.get('${AppConstants.detailBook}$bookId');
  }
}
