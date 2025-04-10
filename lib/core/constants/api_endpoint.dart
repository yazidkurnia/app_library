import 'base_url.dart';

class ApiEndpoint {
  //--------------------------------------------------------------------------------------------|
  //                                        ENDPOINT                                            |
  //--------------------------------------------------------------------------------------------|

  static String detail_transaction_endpoint =
      '${BaseUrl.endpoint_url}/transaction-detail';

  //* endpoint auth
  static String signInEndpoint = '${BaseUrl.endpoint_url}/sign-in';
  static String signUpEndpoint = '${BaseUrl.endpoint_url}/Sign-up';

  //* endpoint book
  static String topFiveBookEndpointFromCategory =
      '${BaseUrl.endpoint_url}/best_five_books';
  static String allBookFromCategory = '${BaseUrl.endpoint_url}/all-book';
  static String detailBook =
      '${BaseUrl.endpoint_url}/book/detail/'; //* membutuhkan parameter id

  //* endpoint transaction
  static String storeTransactionEndpoint =
      '${BaseUrl.endpoint_url}/api/send-data';
  static String getStatusTransactionEndpoint =
      '${BaseUrl.endpoint_url}/get/status-transaksi/';
}
