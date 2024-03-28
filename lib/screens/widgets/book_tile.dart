import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_tabs_starter/data/book.dart';

class BookTile extends StatelessWidget {
  final Book book;
  final Function(BuildContext)? deleteFunction;
  final Function(BookStatus)? changeBookStatus;

  const BookTile({super.key, this.deleteFunction, required this.book, this.changeBookStatus});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (context) {
            return SizedBox(
              height: 200,
              child: Column(
                children: [
                  const Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Change Status',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    child: CupertinoPicker(
                      itemExtent: 50,
                      onSelectedItemChanged: (int index) {
                        changeBookStatus!(BookStatus.values[index]);
                        // Navigator.pop(context);
                      },
                      children: BookStatus.values.map((status) {
                        return Center(
                          child: Text(
                            status.toString(),
                            style: TextStyle(fontSize: 18),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
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
