import 'package:flutter/cupertino.dart';
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

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: CupertinoSlidingSegmentedControl<BookStatus>(
          groupValue: selectedOption,
          onValueChanged: (BookStatus? value) {
            if (value != null) {
              setState(() {
                selectedOption = value;
                _loadData();
              });
            }
          },
          children: const <BookStatus, Widget>{
            BookStatus.reading: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(Icons.menu_book, color: Colors.purple),
                  Text(
                    'Reading',
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
            BookStatus.read: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(Icons.bookmark_added_sharp, color: Colors.purple),
                  Text(
                    'Read',
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
          },
        ),
      ),
      child: Center(
        child: ListView.builder(
          itemCount: filteredBooks.length,
          itemBuilder: (context, index) {
            return BookTile(book: filteredBooks[index]);
          },
        ),
      ),
    );
  }
}
