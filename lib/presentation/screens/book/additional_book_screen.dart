import 'package:app_library/presentation/screens/book/detail_book_screen.dart';
import 'package:flutter/material.dart';
import 'package:multiple_search_selection/createable/create_options.dart';
import 'package:multiple_search_selection/multiple_search_selection.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/debug_log.dart';
import '../../../data/data_sources/localstorage/shared_preferences_service.dart';
import '../../../domain/entities/book_entity.dart';
import '../../presenters/book_presenter.dart';
import '../../states/books/all_book_state.dart';

class AdditionalBookScreen extends StatefulWidget {
  final String? firstBookId;
  const AdditionalBookScreen({super.key, this.firstBookId});

  @override
  State<AdditionalBookScreen> createState() => _AdditionalBookScreenState();
}

class _AdditionalBookScreenState extends State<AdditionalBookScreen> {
  TextStyle kStyleDefault = const TextStyle(
    color: Colors.black,
    fontSize: 14,
    fontWeight: FontWeight.normal,
  );

  var listChoosedBook;

  List<BookEntity>? books; // Menyimpan daftar buku

  @override
  void initState() {
    super.initState();
    _initData();
    _fetchAllBooks();
  }

  void _fetchAllBooks() async {
    final allBookState = Provider.of<AllBookState>(context, listen: false);
    final bookPresenter = Provider.of<BookPresenter>(context, listen: false);

    allBookState.setLoading(true);

    try {
      final fetchedBooks = await bookPresenter.getAllBook();

      if (fetchedBooks.isNotEmpty) {
        allBookState.setAllBooks(fetchedBooks);
        // DebugLog().printLog();
      } else {
        allBookState.setError('Maaf buku tidak ditemukan');
      }
    } catch (e) {
      allBookState.setError('Gagal memuat data: $e');
    } finally {
      allBookState.setLoading(false);
    }
  }

  _initData() async {
    var data = await SharedPreferencesService().getAdditionalBookId();
    listChoosedBook = data;
    DebugLog().printLog(listChoosedBook, 'info');
  }

  resetSharePreferencesListBookValue(List<String> listChoosedBook) async {
    await SharedPreferencesService().saveAdditionalBook(listChoosedBook);

    var newList = await SharedPreferencesService().getAdditionalBookId();
    DebugLog().printLog(newList.toString(), 'info');
  }

  @override
  Widget build(BuildContext context) {
    final allBookState = Provider.of<AllBookState>(context);
    books = allBookState.allBooksFromCategory; // Ambil daftar buku dari state
    SharedPreferencesService additionalBookId = SharedPreferencesService();

    MultipleSearchController controller = MultipleSearchController();

    return SafeArea(
      child: Scaffold(
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          children: [
            MultipleSearchSelection<BookEntity>.creatable(
              itemsVisibility: ShowedItemsVisibility.onType,
              searchField: TextField(
                decoration: InputDecoration(
                  hintText: 'Search books',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ),
              createOptions: CreateOptions(
                create: (text) {
                  return BookEntity(
                      title: text); // Ganti dengan konstruktor yang sesuai
                },
                // validator: (book) {
                //   return book.length > 2;
                // },
                onDuplicate: (item) {
                  DebugLog().printLog('Duplicate item $item', 'info');
                },
                allowDuplicates: false,
                onCreated: (book) =>
                    DebugLog().printLog('Book ${book.title} created', 'info'),
                createBuilder: (text) => Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Create "$text"'),
                  ),
                ),
                pickCreated: true,
              ),
              controller: controller,
              title: Text(
                'Books',
                style: kStyleDefault.copyWith(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onItemAdded: (book) {
                controller.getAllItems();
                controller.getPickedItems();
              },
              clearSearchFieldOnSelect: true,
              items: books ?? [], // Gunakan daftar buku
              fieldToCheck: (book) {
                return book.title!; // Ganti dengan field yang sesuai
              },
              itemBuilder: (book, index, isPicked) {
                // DebugLog().printLog(listChoosedBook[0], 'info');
                List<String> newChosedBook = [
                  listChoosedBook[0],
                  book.bookId.toString()
                ];
                resetSharePreferencesListBookValue(newChosedBook);

                return Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 20.0,
                        horizontal: 12,
                      ),
                      child:
                          Text(book.title!), // Ganti dengan field yang sesuai
                    ),
                  ),
                );
              },
              pickedItemBuilder: (book) {
                // resetSharePreferencesListBookValue(
                //     [listChoosedBook[0], book.bookId!]);
                DebugLog().printLog(book.bookId, 'info');
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey[400]!),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(book.title!), // Ganti dengan field yang sesuai
                  ),
                );
              },
              sortShowedItems: true,
              sortPickedItems: true,
              selectAllButton: Padding(
                padding: const EdgeInsets.all(0),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue),
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.blue),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Select All',
                      style: kStyleDefault.copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ),
              clearAllButton: Padding(
                padding: const EdgeInsets.all(12.0),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.red),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Clear All',
                      style: kStyleDefault,
                    ),
                  ),
                ),
              ),
              caseSensitiveSearch: false,
              fuzzySearch: FuzzySearch.none,
              showSelectAllButton: true,
              maximumShowItemsHeight: 200,
            ),
            const Spacer(),
            TextButton(
              onPressed: () async {
                // Ambil item yang dipilih
                final pickedItems = controller.getPickedItems();

                // Tampilkan data yang dipilih dalam dialog
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Selected Items'),
                      content: SingleChildScrollView(
                        child: ListBody(
                          children: pickedItems.map((item) {
                            return Text(
                                item.title); // Ganti dengan field yang sesuai
                          }).toList(),
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('OK'),
                          onPressed: () async {
                            // Debug log untuk additionalBookId
                            final pickedItem = controller.getPickedItems();

                            List<String> selectedBookIds = pickedItem
                                .map((item) => item.bookId.toString())
                                .toList();
                            selectedBookIds.add(listChoosedBook[0]);
                            DebugLog().printLog(selectedBookIds, 'info');
                            // DebugLog().printLog(listChoosedBook, 'info');

                            // resetSharePreferencesListBookValue(
                            //     [listChoosedBook, ]);
                            Navigator.of(context).pop();
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DetailBookScreen(
                                          bookId: listChoosedBook[0],
                                        )),
                                (route) => false);
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              child: const Text('Confirm'),
            ),
          ],
        ),
      ),
    );
  }
}
