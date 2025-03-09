import 'package:app_library/presentation/presenters/book_presenter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/debug_log.dart';
import '../../states/books/detail_book_state.dart';

class DetailBookScreen extends StatefulWidget {
  final String bookId;
  const DetailBookScreen({super.key, required this.bookId});

  @override
  State<DetailBookScreen> createState() => _DetailBookScreenState();
}

class _DetailBookScreenState extends State<DetailBookScreen> {
  late String bookId; // Variabel untuk menyimpan bookId

  @override
  void initState() {
    super.initState();

    _fetchDetailBook(widget.bookId);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Mengambil argumen di sini
    // final Map<String, dynamic> args =
    //     ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    // bookId = args['bookId']; // Menyimpan nilai bookId ke dalam variabel kelas

    // Sekarang Anda bisa memanggil fungsi lain di sini jika perlu
    // _testAksesBookId(bookId);
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
                    Text(
                      state.detailBook!.title.toString(),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      state.detailBook!.description.toString(),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    const Spacer(),
                    const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [Text('Tahun terbit'), Text('2023')]),
                    const SizedBox(
                      height: 12,
                    ),
                    const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [Text('Penulis'), Text('Rio Ferdinan')]),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 2 - 24,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue[50]),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('Cancel',
                                  style: TextStyle(color: Colors.blue[200]))),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 2 - 24,
                          child: ElevatedButton(
                              onPressed: () {},
                              child: const Text('Get it now')),
                        )
                      ],
                    )
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
        body: ListView(
          children: [bookImage(), bookDetail()],
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
