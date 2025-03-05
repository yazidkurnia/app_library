import '../../core/constants/app_constant.dart';
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

  // Future<dynamic> getBookById(String bookId) async {
  //   return await apiClient.get('${AppConstants.getBookEndpoint}/$bookId');
  // }

  // Future<dynamic> getBooksByCategory(String categoryId) async {
  //   return await apiClient.get('${AppConstants.getBooksByCategoryEndpoint}/$categoryId');
  // }

  // Future<dynamic> addBook(Map<String, dynamic> bookData) async {
  //   return await apiClient.post(AppConstants.addBookEndpoint, bookData);
  // }

  // Future<dynamic> updateBook(Map<String, dynamic> bookData) async {
  //   return await apiClient.put(AppConstants.updateBookEndpoint, bookData);
  // }

  // Future<dynamic> deleteBook(String bookId) async {
  //   return await apiClient.delete('${AppConstants.deleteBookEndpoint}/$bookId');
  // }
}
