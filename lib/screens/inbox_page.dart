import 'package:flutter/material.dart';
import 'package:flutter_tabs_starter/data/book.dart';
import 'package:flutter_tabs_starter/data/book_database.dart';
import 'package:flutter_tabs_starter/screens/widgets/book_tile.dart';
import 'package:flutter_tabs_starter/screens/widgets/dialog_box.dart';

class InboxPage extends StatefulWidget {
  const InboxPage({super.key});

  @override
  State<InboxPage> createState() => _InboxPageState();
}

class _InboxPageState extends State<InboxPage> {
  final BookDatabase db = BookDatabase();
  List<Book> books = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    books = await db.loadBooks();
    setState(() {});
  }

  final _controller = TextEditingController();

  void saveNewBook() async {
    await db.createBook(Book(name: _controller.text, status: BookStatus.wantToRead));
    _controller.clear();
    Navigator.of(context).pop();
    _loadData();
  }

  void addNewBook() {
    showDialog(
      context: context,
      builder: ((context) {
        return DialogBox(
          controller: _controller,
          onSave: saveNewBook,
          onCancel: () => Navigator.of(context).pop(),
        );
      }),
    );
  }

  void deleteBook(int index) async {
    await db.deleteBook(books[index].id);
    _loadData(); // Reload data
  }

  void changeBookStatus(Book book, BookStatus newStatus) async {
    await db.updateBookStatus(book.id, newStatus);
    setState(() {
      book.status = newStatus; // Update the book status locally
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Book> filteredBooks = books.where((book) => book.status == BookStatus.wantToRead).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Inbox"),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addNewBook,
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: filteredBooks.length,
        itemBuilder: (context, index) {
          return BookTile(
            book: filteredBooks[index],
            deleteFunction: (BuildContext) => deleteBook(index),
            changeBookStatus: (newStatus) => changeBookStatus(filteredBooks[index], newStatus),
          );
        },
      ),
    );
  }
}
