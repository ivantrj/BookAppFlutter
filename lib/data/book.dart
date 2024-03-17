import 'package:hive/hive.dart';

part 'book.g.dart';

@HiveType(typeId: 1)
enum BookStatus {
  @HiveField(0)
  wantToRead,

  @HiveField(1)
  reading,

  @HiveField(2)
  read,
}

@HiveType(typeId: 0) // Ensure typeId is unique for each HiveType
class Book extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  String? author; // Optional field

  @HiveField(2)
  BookStatus status;

  Book({required this.name, this.author, required this.status});
}