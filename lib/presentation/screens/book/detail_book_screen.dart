import 'package:app_library/presentation/presenters/book_presenter.dart';
import 'package:app_library/presentation/screens/book/additional_book_screen.dart';
import 'package:app_library/presentation/screens/book/partial/content_detail_book.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/debug_log.dart';
import '../../../data/data_sources/localstorage/shared_preferences_service.dart';
import '../../presenters/transaction_presenter.dart';
import '../../states/books/detail_book_state.dart';
import '../../states/transactions/transaction_state.dart';

class DetailBookScreen extends StatefulWidget {
  final String bookId;
  const DetailBookScreen({super.key, required this.bookId});

  @override
  State<DetailBookScreen> createState() => _DetailBookScreenState();
}

class _DetailBookScreenState extends State<DetailBookScreen> {
  SharedPreferencesService additionalBookId = SharedPreferencesService();
  late String bookId; // Variabel untuk menyimpan bookId
  TransactionState transactionState = TransactionState();

  @override
  void initState() {
    super.initState();

    _fetchDetailBook(widget.bookId);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  _saveTransaction() async {
    List<String>? data = await additionalBookId.getAdditionalBookId();
    DebugLog().printLog(data, 'info');
    final transactionPresenter =
        await Provider.of<TransactionPresenter>(context, listen: false);

    setState(() {
      transactionState.setLoading(true);
    });
    DebugLog().printLog('loading: ${transactionState.isLoading}', 'info');
    bool isSuccess = await transactionPresenter.storeTransaction(data!);
    setState(() {
      transactionState.setLoading(false);
    });

    DebugLog().printLog('loading: ${transactionState.isLoading}', 'info');

    DebugLog().printLog(isSuccess, 'info');
  }

  @override
  Widget build(BuildContext context) {
    Widget bookImage() {
      return Expanded(
        child: SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height / 3,
            child: Image.network(
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSZ4ZFd7IOTkrogQQ7VWVVDQTgb_rdnEGPwU9IbhUJOHtIcI1flMycQD5QWso4UdhgV_Ao&usqp=CAU',
                fit: BoxFit.cover)),
      );
    }

    Widget additionalBook() {
      return Container(
        child: Column(
          children: [
            Row(
              children: [
                OutlinedButton.icon(
                  onPressed: () {
                    additionalBookId.saveAdditionalBook(['${widget.bookId}']);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const AdditionalBookScreen()));
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Add more book'),
                )
              ],
            ),
            const SizedBox(height: 14),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(' judul buku tambahan'),
                Text(' 1x'),
              ],
            )
          ],
        ),
      );
    }

    Widget footer() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width / 2 - 24,
            child: ElevatedButton(
                style:
                    ElevatedButton.styleFrom(backgroundColor: Colors.blue[50]),
                onPressed: () {
                  Navigator.pop(context);
                },
                child:
                    Text('Cancel', style: TextStyle(color: Colors.blue[200]))),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 2 - 24,
            child: ElevatedButton(
                onPressed: () {
                  _saveTransaction();
                },
                child: const Text('Get it now')),
          )
        ],
      );
    }

    Widget bookDetail() {
      return Expanded(
        child: SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height -
              MediaQuery.of(context).size.height / 3,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Consumer<DetailBookState>(
              builder: (context, state, child) {
                if (state.loading) {
                  return const CircularProgressIndicator();
                }

                if (state.detailBook == null) {
                  return const Text(
                      'Maaf data yang dipilih tidak ditemukan sehingga peminjaman tidak dapat dilanjutkan');
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Expanded(
                      child: ContentDetailBook(
                        bookTitle: 'Judul',
                        descBook: 'lorem...',
                      ),
                    ),
                    additionalBook(),
                    const SizedBox(
                      height: 16,
                    ),
                    footer()
                  ],
                );
              },
            ),
          ),
        ),
      );
    }

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            ListView(
              children: [bookImage(), bookDetail()],
            ),
            if (transactionState.isLoading == true) ...[
              Container(
                width: double.infinity,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            ],
          ],
        ),
      ),
    );
  }

  String _testAksesBookId(String? bookId) {
    DebugLog().printLog(bookId, 'info');
    return bookId!;
  }

  void _fetchDetailBook(String book_id) async {
    final detailBookState =
        Provider.of<DetailBookState>(context, listen: false);

    final bookPresenter = Provider.of<BookPresenter>(context, listen: false);

    try {
      final detailBookData = await bookPresenter.getDetailBook(book_id);
      DebugLog().printLog('data detail buku $detailBookData', 'info');
      if (detailBookData != null) {
        detailBookState.setDetailBook(detailBookData);
      } else {
        DebugLog().printLog('data detail buku $detailBookData', 'error');
        detailBookState.setError('Gagal memuat data');
      }
    } catch (e) {
      DebugLog().printLog('data detail buku $e', 'error');
    }
  }
}
