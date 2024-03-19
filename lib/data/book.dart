enum BookStatus { wantToRead, reading, read }

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
      'status': status.toString().split('.').last, // Store status as a string
    };
  }

  static Book fromMap(Map<String, dynamic> map) {
    return Book(
      id: map['id'],
      name: map['name'],
      author: map['author'],
      status: map['status'] != null
          ? (int.tryParse(map['status']) != null
              ? BookStatus.values[int.parse(map['status'])]
              : BookStatus.values.byName(map['status'])) // Handles numeric and string values
          : BookStatus.wantToRead,
    );
  }

  Book copyWith({
    int? id,
    String? name,
    String? author,
    BookStatus? status,
  }) {
    return Book(
      id: id ?? this.id, // Use the new value if provided, otherwise keep the existing 'id'
      name: name ?? this.name,
      author: author ?? this.author,
      status: status ?? this.status,
    );
  }
}
