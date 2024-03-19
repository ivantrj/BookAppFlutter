import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_tabs_starter/data/book.dart';

class BookTile extends StatelessWidget {
  final Book book;
  Function(BuildContext)? deleteFunction;
  Function(BookStatus)? changeBookStatus;

  BookTile({super.key, this.deleteFunction, required this.book, this.changeBookStatus});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Change Status'),
              content: DropdownButton<BookStatus>(
                value: book.status,
                onChanged: (newStatus) {
                  if (newStatus != null && newStatus != book.status) {
                    Navigator.of(context).pop();
                    changeBookStatus!(newStatus);
                  }
                },
                items: BookStatus.values.map((status) {
                  return DropdownMenuItem<BookStatus>(
                    value: status,
                    child: Text(status.toString()),
                  );
                }).toList(),
              ),
            );
          },
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Slidable(
          endActionPane: ActionPane(
            motion: const StretchMotion(),
            children: [
              SlidableAction(
                onPressed: deleteFunction,
                icon: Icons.delete,
                backgroundColor: Colors.red,
                borderRadius: BorderRadius.circular(12),
                padding: const EdgeInsets.all(6),
              ),
            ],
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  offset: const Offset(2, 4),
                  blurRadius: 5,
                )
              ],
            ),
            child: ListTile(
              title: Text(
                book.name,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              subtitle: Text(
                BookStatus.values[book.status.index].toString(),
                style: TextStyle(color: Colors.grey[600]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
