import 'package:hive_flutter/hive_flutter.dart';

class BookDatabase {
  final _books = Hive.box('books');

  List books = [];

  // run this method if this is the 1st time ever opening the app
  void createInitialData() {
    books = ["Lord of the Rings"];
  }

  // load the data from database
  void loadData() {
    books = _books.get("BOOKS") ?? [];
  }

  // update the database
  void updateDatabase() {
    _books.put("BOOKS", books);
  }
}
