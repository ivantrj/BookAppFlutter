import 'package:flutter/material.dart';
import 'package:flutter_tabs_starter/data/book.dart';
import 'package:flutter_tabs_starter/data/book_database.dart';
import 'package:flutter_tabs_starter/data/database_helper.dart';
import 'package:flutter_tabs_starter/screens/widgets/book_tile.dart';

class LibraryPage extends StatefulWidget {
  const LibraryPage({super.key});

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  final BookDatabase db = BookDatabase();

  BookStatus selectedOption = BookStatus.reading;
  List<Book> books = [];

  // _LibraryPageState() {
  //   db = DatabaseHelper.instance;
  // }
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    if (selectedOption == BookStatus.reading) {
      books = await db.getBooksByStatus(BookStatus.reading);
    } else if (selectedOption == BookStatus.read) {
      books = await db.getBooksByStatus(BookStatus.read);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    List<Book> filteredBooks = books.where((book) => book.status == selectedOption).toList();

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Library'),
          bottom: TabBar(
              tabs: const [
                Tab(text: 'Reading'),
                Tab(text: 'Read'),
              ],
              onTap: (index) {
                setState(() {
                  selectedOption = index == 0 ? BookStatus.reading : BookStatus.read;
                  _loadData();
                });
              }),
        ),
        body: TabBarView(
          children: [
            // Reading Tab View
            ListView.builder(
              itemCount: books.length,
              itemBuilder: (context, index) {
                return BookTile(book: filteredBooks[index]);
              },
            ),
            // Read Tab View
            ListView.builder(
              itemCount: books.length,
              itemBuilder: (context, index) {
                return BookTile(book: filteredBooks[index]);
              },
            ),
          ],
        ),
      ),
    );
  }
}
