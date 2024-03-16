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
      body: Column(
        children: [
          SizedBox(
            height: 50,
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedOption = 'Reading'; // Update selected option
                      });
                    },
                    child: Container(
                      color: selectedOption == 'Reading' ? Colors.blue : Colors.grey[300], // Indicator color
                      child: Center(child: Text('Reading')),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedOption = 'Read'; // Update selected option
                      });
                    },
                    child: Container(
                      color: selectedOption == 'Read' ? Colors.blue : Colors.grey[300], // Indicator color
                      child: Center(child: Text('Read')),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
