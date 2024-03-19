import 'package:flutter_tabs_starter/data/database_helper.dart';
import 'package:flutter_tabs_starter/data/book.dart';

class BookDatabase {
  final dbHelper = DatabaseHelper.instance;

  // Data Management Methods
  Future<int> insertBook(Book book) async {
    final db = await dbHelper.database;
    return await db.insert('books', book.copyWith(author: book.author ?? 'Unknown').toMap());
  }

  Future<List<Book>> getBooks() async {
    final db = await dbHelper.database;
    final maps = await db.query('books');
    return List.generate(maps.length, (index) => Book.fromMap(maps[index]));
  }

  Future<List<Book>> getBooksByStatus(BookStatus status) async {
    final db = await dbHelper.database;
    final maps = await db.query(
      'books',
      where: 'status = ?',
      whereArgs: [status.index],
    );
    return List.generate(maps.length, (index) => Book.fromMap(maps[index]));
  }

  Future<int> updateBook(Book book) async {
    final db = await dbHelper.database;
    return await db.update(
      'books',
      book.toMap(),
      where: 'id = ?',
      whereArgs: [book.id],
    );
  }

  Future<int> updateBookStatus(int bookId, BookStatus newStatus) async {
    final db = await dbHelper.database;
    return await db.update(
      'books',
      {'status': newStatus.index},
      where: 'id = ?',
      whereArgs: [bookId],
    );
  }

  Future<int> deleteBook(int id) async {
    final db = await dbHelper.database;
    return await db.delete(
      'books',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
