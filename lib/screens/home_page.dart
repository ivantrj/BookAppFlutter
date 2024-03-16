import 'package:flutter/material.dart';
import 'package:flutter_tabs_starter/screens/inbox_page.dart';
import 'package:flutter_tabs_starter/screens/library_page.dart';
import 'package:flutter_tabs_starter/screens/settings_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final _tabs = <_HomeTab>[
    _HomeTab(
      label: 'Inbox',
      icon: Icons.inbox,
      builder: (context) => const InboxPage(),
    ),
    _HomeTab(
      label: 'Library',
      icon: Icons.library_books_rounded,
      builder: (context) => const LibraryPage(),
    ),
    _HomeTab(
      label: 'Settings',
      icon: Icons.settings,
      builder: (context) => const SettingsPage(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final Widget body;
    final Widget? bottomNavigationBar;
    final content = _tabs[_selectedIndex].builder(context);

    body = SafeArea(child: content);
    bottomNavigationBar = NavigationBar(
      onDestinationSelected: (value) {
        setState(() => _selectedIndex = value);
      },
      indicatorColor: Colors.purple[200],
      selectedIndex: _selectedIndex,
      destinations: [
        for (final tab in _tabs)
          NavigationDestination(
            label: tab.label,
            icon: Icon(tab.icon),
          ),
      ],
    );

    return Scaffold(
      body: body,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}

class _HomeTab {
  const _HomeTab({
    required this.label,
    required this.icon,
    required this.builder,
  });

  final String label;
  final IconData icon;
  final WidgetBuilder builder;
}
