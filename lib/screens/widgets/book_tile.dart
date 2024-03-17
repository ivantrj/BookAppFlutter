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
                  Navigator.of(context).pop();
                  changeBookStatus!(newStatus!);
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
          child: Card(
            elevation: 3,
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Text(book.name),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
