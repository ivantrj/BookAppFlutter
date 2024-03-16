import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class BookTile extends StatelessWidget {
  final String bookName;
  Function(BuildContext)? deleteFunction;

  BookTile({super.key, required this.bookName, required this.deleteFunction});

  @override
  Widget build(BuildContext context) {
    return Padding(
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
              padding: EdgeInsets.all(6),
            ),
          ],
        ),
        child: Container(
          padding: EdgeInsets.all(12),
          child: Row(
            children: [
              Text(bookName),
            ],
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
