import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LibraryPage extends StatefulWidget {
  const LibraryPage({super.key});

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  String selectedOption = "Reading";
  // Add a variable to track the selected option
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Library'),
      ),
      body: CupertinoSegmentedControl<String>(
        children: {
          'Reading': Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 18),
            child: Text('Reading'),
          ),
          'Read': Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 18),
            child: Text('Read'),
          ),
        },
        groupValue: selectedOption,
        onValueChanged: (value) {
          setState(() {
            selectedOption = value;
            // Add logic here to filter books based on the selectedOption
          });
        },
      ),
    );
  }
}
