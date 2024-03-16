import 'package:flutter_tabs_starter/data/book.dart';
import 'package:hive_flutter/hive_flutter.dart';

class BookDatabase {
  final _books = Hive.box('books');

  List<Book> books = [];

  // run this method if this is the 1st time ever opening the app
  void createInitialData() {
    books = [Book(name: "Harry Potter", status: BookStatus.wantToRead)];
  }

  // load the data from database
  void loadData() {
    books = _books.get("BOOKS")?.cast<Book>() ?? [];
  }

  // update the database
  void updateDatabase() {
    _books.put("BOOKS", books);
  }
}
