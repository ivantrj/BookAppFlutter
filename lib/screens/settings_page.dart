import 'package:flutter/material.dart';
import 'package:flutter_tabs_starter/screens/widgets/settings_tile.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('App', style: Theme.of(context).textTheme.titleMedium),
          ),
          const Divider(),
          SettingsTile(
            icon: Icons.palette,
            label: 'Theme',
            onTap: () {},
          ),
          SettingsTile(
            icon: Icons.import_export,
            label: 'Import/Export Data',
            onTap: () {},
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('General', style: Theme.of(context).textTheme.titleMedium),
          ),
          const Divider(),
          SettingsTile(
            icon: Icons.language,
            label: 'Website',
            onTap: () {},
          ),
          SettingsTile(
            icon: Icons.follow_the_signs,
            label: 'Follow on Twitter',
            onTap: () {},
          ),
          SettingsTile(
            icon: Icons.lock_outline,
            label: 'Privacy Policy',
            onTap: () {},
          ),
          SettingsTile(
            icon: Icons.description_outlined,
            label: 'Terms of Service',
            onTap: () {},
          ),
          SettingsTile(
            icon: Icons.star,
            label: 'Rate the app',
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
