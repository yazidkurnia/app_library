import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../domain/entities/book_entity.dart';
import '../../../presenters/book_presenter.dart';
import '../../../states/books/all_book_state.dart';
import '../../../states/books/topfivebook_state.dart';
import '../../../widgets/custom_shimmer.dart';
import '../../book/detail_book_screen.dart';

class Content extends StatefulWidget {
  const Content({super.key});

  @override
  State<Content> createState() => _ContentState();
}

class _ContentState extends State<Content> with SingleTickerProviderStateMixin {
  final TextEditingController _searchBookController = TextEditingController();
  late TabController _tabController;
  final List<String> _tabTitles = [
    'Mobile',
    'Web',
    'Artificial Intelligence',
    'Desktop'
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabTitles.length, vsync: this);

    // Panggil API untuk mendapatkan data buku terbaik
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchTopFiveBooks();
      _fetchAllBooks();
    });
  }

  void _fetchTopFiveBooks() async {
    final topFiveBookState =
        Provider.of<TopFiveBookState>(context, listen: false);
    final bookPresenter = Provider.of<BookPresenter>(context, listen: false);

    topFiveBookState.setLoading(true);

    try {
      final books = await bookPresenter.getTopFiveBooks();

      // Perbarui state dengan buku yang diterima dari API
      if (books.isNotEmpty) {
        // Asumsikan bahwa kita telah mengubah TopFiveBookState untuk menerima list
        topFiveBookState.setTopFiveBooks(books as List<BookEntity>);
      } else {
        topFiveBookState.setError('Tidak ada buku yang ditemukan');
      }
    } catch (e) {
      topFiveBookState.setError('Gagal memuat data: $e');
    } finally {
      topFiveBookState.setLoading(false);
    }
  }

  void _fetchAllBooks() async {
    final allBookState = Provider.of<AllBookState>(context, listen: false);
    final bookPresenter = Provider.of<BookPresenter>(context, listen: false);

    allBookState.setLoading(true);

    try {
      final books = await bookPresenter.getAllBook();

      if (books.isNotEmpty) {
        // Asumsikan bahwa kita telah mengubah allbooks menjadi list
        allBookState.setAllBooks(books);
      } else {
        allBookState.setError('Maaf buku tidak ditemukan');
      }
    } catch (e) {
      allBookState.setError('Gagal memuat data: $e');
    } finally {
      allBookState.setLoading(false);
    }
  }

  @override
  void dispose() {
    _searchBookController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  Widget _buildSearchField() {
    return TextField(
      controller: _searchBookController,
      decoration: InputDecoration(
        hintText: 'Cari buku...',
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      ),
    );
  }

  Widget _buildTabBar() {
    return TabBar(
      controller: _tabController,
      isScrollable: true,
      labelColor: Theme.of(context).secondaryHeaderColor,
      unselectedLabelColor: Colors.blue[800],
      indicatorSize: TabBarIndicatorSize.label,
      tabs: _tabTitles.map((title) => Tab(text: title)).toList(),
    );
  }

  Widget _buildBookCard(BookEntity book) {
    return GestureDetector(
      onTap: () {
        // Navigator.pushNamed(context, '/detail-book',
        //     arguments: {'bookId': book.bookId});
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailBookScreen(
                      bookId: book.bookId!,
                    )));
      },
      child: Container(
        width: MediaQuery.of(context).size.width - 100,
        margin: const EdgeInsets.only(right: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 130,
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(8),
                // Jika book memiliki coverUrl, gunakan NetworkImage
                image: book.imageUrl != null && book.imageUrl!.isNotEmpty
                    ? DecorationImage(
                        image: NetworkImage(book.imageUrl!),
                        fit: BoxFit.cover,
                      )
                    : null,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              book.title ?? 'Judul Tidak Tersedia',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            if (book.bookId != null && book.bookId!.isNotEmpty)
              Text(
                book.bookId!,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildBestBooksSection(String sectionTitle) {
    return Consumer<TopFiveBookState>(
      builder: (context, state, child) {
        if (state.loading) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Row(
                  children: [
                    Text(
                      sectionTitle,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              CustomShimmer(
                width: MediaQuery.of(context).size.width - 100,
                height: 130,
                child: Container(
                  color: Colors.white, // Ini adalah konten yang akan dishimmer
                ),
              ),
            ],
          );
        }

        if (state.errorMessage != null) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Text(
                  sectionTitle,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 180,
                child: Center(
                  child: Text(
                    state.errorMessage!,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              ),
            ],
          );
        }

        // Jika tidak ada data, gunakan placeholder atau data statis
        if (state.topFiveBooks == null || state.topFiveBooks!.isEmpty) {
          // Data statis sebagai fallback
          final bookTitles = [
            'Tutorial Mahir Flutter',
            'Belajar React.js untuk Pemula',
            'Dasar-dasar Machine Learning',
            'Mobile App Development dengan Kotlin',
            'Frontend Web Development'
          ];

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Row(
                  children: [
                    Text(
                      sectionTitle,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "(Data Lokal)",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 180,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: bookTitles.length,
                  itemBuilder: (context, index) {
                    // Buat BookEntity sementara dari data statis
                    final tempBook = BookEntity(
                      bookId: index.toString(),
                      title: bookTitles[index],
                      imageUrl: null,
                      // author: 'Penulis Contoh',
                    );
                    return _buildBookCard(tempBook);
                  },
                ),
              ),
            ],
          );
        }

        // Menampilkan data yang berhasil diambil dari API
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Row(
                children: [
                  Text(
                    sectionTitle,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 180,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: state.topFiveBooks!.length,
                itemBuilder: (context, index) =>
                    _buildBookCard(state.topFiveBooks![index]),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildAllBookWidget(String sectionTitle) {
    return Consumer<AllBookState>(
      builder: (context, state, child) {
        if (state.loading) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Text(
                  sectionTitle,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 180,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ],
          );
        }

        // todo menampilkan pesan error
        if (state.errorMessage != null) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Text(
                  sectionTitle,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 180,
                child: Center(
                  child: Text(
                    state.errorMessage!,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              ),
            ],
          );
        }

        // todo Jika tidak ada data, gunakan placeholder atau data statis
        if (state.allBooksFromCategory == null ||
            state.allBooksFromCategory!.isEmpty) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Text(
                  sectionTitle,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 180,
                child: Center(
                  child: Text(
                    'Tidak ada buku yang ditemukan.',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
            ],
          );
        }

        // todo Menampilkan semua buku yang berhasil diambil dari API
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Text(
                sectionTitle,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics:
                  const NeverScrollableScrollPhysics(), // Disable scrolling for this ListView
              itemCount: state.allBooksFromCategory!.length,
              itemBuilder: (context, index) => Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: Expanded(
                    child: Row(children: [
                      Image.network(
                        width: 50,
                        height: 50,
                        state.allBooksFromCategory![index].imageUrl.toString(),
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                state.allBooksFromCategory![index].title
                                    .toString(),
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 3),
                              Text(
                                state.allBooksFromCategory![index].description
                                    .toString(),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ]),
                      )
                    ]),
                  )),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTabContent(String title) {
    if (title == 'Mobile') {
      return ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          _buildBestBooksSection('5 Buku $title Terbaik'),
          const SizedBox(height: 16),
          _buildAllBookWidget('All book')
        ],
      );
    } else {
      return Center(
        child: Text(title),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Katalog Buku'),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(48),
            child: _buildTabBar(),
          ),
          actions: [
            // Menambahkan tombol refresh
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: _fetchTopFiveBooks,
              tooltip: 'Refresh Data',
            ),
          ],
        ),
        body: Column(
          children: [
            // Search field stays static here
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: _buildSearchField(),
            ),

            // Tab content takes remaining space
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children:
                    _tabTitles.map((title) => _buildTabContent(title)).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
