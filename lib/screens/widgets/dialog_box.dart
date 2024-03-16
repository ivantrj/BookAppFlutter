import 'package:flutter/material.dart';
import 'package:flutter_tabs_starter/screens/widgets/my_button.dart';

class DialogBox extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;

  DialogBox({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.purple[200],
      content: Container(
        height: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              controller: controller,
              decoration: const InputDecoration(border: OutlineInputBorder(), hintText: "Enter book name"),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MyButton(text: "Cancel", onPressed: onCancel),
                const SizedBox(
                  width: 8,
                ),
                MyButton(text: "Add", onPressed: onSave),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
