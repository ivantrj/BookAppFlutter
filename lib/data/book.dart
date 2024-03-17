enum BookStatus {
  wantToRead,
  reading,
  read,
}

class Book {
  final int? id;
  final String name;
  final String? author;
  BookStatus status;

  Book({this.id, required this.name, this.author, required this.status});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'author': author,
      'status': status,
    };
  }

  static Book fromMap(Map<String, dynamic> map) {
    return Book(
      id: map['id'],
      name: map['name'],
      author: map['author'],
      status: map['status'] != null
          ? BookStatus.values.firstWhere(
              (e) => e.toString() == 'BookStatus.' + map['status'],
              orElse: () => BookStatus.wantToRead, // Provide a default value
            )
          : BookStatus.wantToRead,
    );
  }
}
