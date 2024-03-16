import 'package:flutter/material.dart';
import 'package:flutter_tabs_starter/data/database.dart';
import 'package:flutter_tabs_starter/screens/widgets/book_tile.dart';
import 'package:flutter_tabs_starter/screens/widgets/dialog_box.dart';
import 'package:hive_flutter/hive_flutter.dart';

class InboxPage extends StatefulWidget {
  const InboxPage({super.key});

  @override
  State<InboxPage> createState() => _InboxPageState();
}

class _InboxPageState extends State<InboxPage> {
  final _myBox = Hive.box('books');
  BookDatabase db = BookDatabase();

  @override
  void initState() {
    // if first time ever opening the app
    if (_myBox.get("BOOKS") == null) {
      db.createInitialData();
    } else {
      // load data from database
      db.loadData();
    }

    super.initState();
  }

  // text controller
  final _controller = TextEditingController();

  void saveNewBook() {
    setState(() {
      db.books.add(_controller.text);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDatabase();
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
    db.updateDatabase();
  }

  void deleteBook(int index) {
    setState(() {
      db.books.removeAt(index);
    });
    db.updateDatabase();
  }

  @override
  Widget build(BuildContext context) {
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
        itemCount: db.books.length,
        itemBuilder: (context, index) {
          return BookTile(
            bookName: db.books[index],
            deleteFunction: (context) => deleteBook(index),
          );
        },
      ),
    );
  }
}
