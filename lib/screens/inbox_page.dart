import 'package:flutter/material.dart';
import 'package:flutter_tabs_starter/data/book.dart';
import 'package:flutter_tabs_starter/data/book_database.dart';
import 'package:flutter_tabs_starter/data/database_helper.dart';
import 'package:flutter_tabs_starter/screens/widgets/book_tile.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

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
    books = await db.getBooks();
    setState(() {});
  }

  final _controller = TextEditingController();

  void saveNewBook() async {
    await db.insertBook(Book(name: _controller.text, status: BookStatus.wantToRead));
    _controller.clear();
    Navigator.of(context).pop();
    _loadData();
  }

  void addNewBook() {
    showMaterialModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)), // Rounded corners at the top
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.fromLTRB(20, 20, 20, MediaQuery.of(context).viewInsets.bottom + 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ShadInput(
              controller: _controller,
              placeholder: Text("Book Name"),
              // decoration: const InputDecoration(
              //   border: OutlineInputBorder(),
              //   hintText: "Enter book name",
              //   fillColor: Color(0xFFF0F0F0),
              //   filled: true,
              // ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  // Use Expanded for better button alignment and spacing
                  child: ShadButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    // style: ElevatedButton.styleFrom(
                    //   backgroundColor: Colors.grey,
                    // ),
                    text: const Text("Cancel"),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: ShadButton(
                    onPressed: saveNewBook,
                    // style: ElevatedButton.styleFrom(
                    //   backgroundColor: Theme.of(context).primaryColor,
                    // ),
                    text: const Text("Add"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void deleteBook(Book book) async {
    await db.deleteBook(book.id!);
    _loadData(); // Reload data
  }

  void changeBookStatus(Book book, BookStatus newStatus) async {
    await db.updateBookStatus(book.id!, newStatus); // Assuming book.id is non-null
    _loadData();
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
            deleteFunction: (context) => deleteBook(filteredBooks[index]),
            changeBookStatus: (newStatus) => changeBookStatus(filteredBooks[index], newStatus),
          );
        },
      ),
    );
  }
}
