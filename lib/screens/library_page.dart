import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tabs_starter/data/book.dart';
import 'package:flutter_tabs_starter/data/book_database.dart';
import 'package:flutter_tabs_starter/screens/widgets/book_tile.dart';

class LibraryPage extends StatefulWidget {
  const LibraryPage({super.key});

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  final BookDatabase db = BookDatabase(); // Adjusted for sqflite

  BookStatus selectedOption = BookStatus.reading;
  List<Book> books = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    if (selectedOption == BookStatus.reading) {
      books = await db.loadBooksByStatus(BookStatus.reading.toString());
    } else if (selectedOption == BookStatus.read) {
      books = await db.loadBooksByStatus(BookStatus.read.toString());
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
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
                if (books[index].status == BookStatus.reading) {
                  return BookTile(book: books[index]);
                } else {
                  return const SizedBox.shrink(); // Hide non-matching books
                }
              },
            ),
            // Read Tab View
            ListView.builder(
              itemCount: books.length,
              itemBuilder: (context, index) {
                if (books[index].status == BookStatus.read) {
                  return BookTile(book: books[index]);
                } else {
                  return const SizedBox.shrink(); // Hide non-matching books
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
