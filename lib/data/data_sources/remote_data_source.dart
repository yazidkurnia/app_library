import '../../core/networks/api_client.dart';
import '../../../core/constants/api_endpoint.dart';

class RemoteDataSource {
  final ApiClient apiClient;
  RemoteDataSource(this.apiClient);

  //* remote data auth
  Future<dynamic> signIn(String email, String password) async {
    final payload = {'email': email, 'password': password}; //* defined payload

    return await apiClient.post(
        ApiEndpoint.signInEndpoint, payload); //! return api client
  }

  Future<dynamic> signUp(String email, String password) async {
    final payload = {'email': email, 'password': password};

    return await apiClient.post(
        ApiEndpoint.signUpEndpoint, payload); //! return api client
  }

  //* remote data book source
  Future<dynamic> getAllBooks() async {
    return await apiClient.get(ApiEndpoint.allBookFromCategory);
  }

  Future<dynamic> getTopFiveBook() async {
    return await apiClient.get(ApiEndpoint.topFiveBookEndpointFromCategory);
  }

  Future<dynamic> getBookDetail(String bookId) async {
    return await apiClient.get('${ApiEndpoint.detailBook}$bookId');
  }
}
