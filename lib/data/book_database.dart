import 'package:flutter_tabs_starter/data/database_helper.dart';
import 'package:flutter_tabs_starter/data/book.dart';

class BookDatabase {
  final dbHelper = DatabaseHelper.instance;

  Future<void> createInitialData() async {
    final db = await dbHelper.database;
    await db.insert('books', Book(name: "Harry Potter", status: BookStatus.wantToRead).toMap());
  }

  Future<List<Book>> loadBooks() async {
    final db = await dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('books');

    return List.generate(maps.length, (i) {
      return Book.fromMap(maps[i]);
    });
  }

  Future<void> updateDatabase(List<Book> books) async {
    final db = await dbHelper.database;
    for (var book in books) {
      await db.update('books', book.toMap(), where: 'id = ?', whereArgs: [book.id]);
    }
  }

  // Method to insert a new book
  Future<void> createBook(Book book) async {
    final db = await dbHelper.database;
    await db.insert('books', {
      'name': book.name,
      'author': book.author ?? '', // Ensure author is provided or set to an empty string
      'status': book.status.toString(), // Store BookStatus as a string
    });
  }

  // Method to delete a book by ID
  Future<void> deleteBook(int? id) async {
    final db = await dbHelper.database;
    await db.delete('books', where: 'id = ?', whereArgs: [id]);
  }

// Method to load books by status
  Future<List<Book>> loadBooksByStatus(String status) async {
    final db = await dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('books', where: 'status = ?', whereArgs: [status]);

    return List.generate(maps.length, (i) {
      return Book.fromMap(maps[i]);
    });
  }

  // Method to update a book's status
  Future<void> updateBookStatus(int? id, BookStatus newStatus) async {
    final db = await dbHelper.database;
    await db.update('books', {'status': newStatus.toString()}, where: 'id = ?', whereArgs: [id]);
  }
}
