import 'package:flutter/material.dart';
import 'package:flutter_tabs_starter/data/book.dart';
import 'package:flutter_tabs_starter/data/book_database.dart';
import 'package:flutter_tabs_starter/screens/widgets/book_tile.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

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
    showMaterialModalBottomSheet(
      context: context,
      backgroundColor: Colors.white, // Set the background color
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)), // Rounded corners at the top
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(20), // Overall padding for the modal content
        child: Column(
          mainAxisSize: MainAxisSize.min, // Adjust size to content
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter book name",
                fillColor: Color(0xFFF0F0F0),
                filled: true,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  // Use Expanded for better button alignment and spacing
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                    ),
                    child: const Text("Cancel"),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: ElevatedButton(
                    onPressed: saveNewBook,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                    child: const Text("Add"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
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
