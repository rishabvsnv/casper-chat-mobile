import 'package:flutter/material.dart';
import 'package:messenger/shared/widgets/custom_appbar.dart';
import 'package:messenger/shared/widgets/custom_drawer.dart';

class FolderScreen extends StatelessWidget {
  const FolderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Telegram Messaging'),
      drawer: CustomDrawer(),
      body: Column(
        children: [
          TabBar(tabs: [Text('data'), Text('data'), Text('data')]),
          TabBarView(
            children: [
              Center(child: Text('Home Screen')),
              Center(child: Text('Home Screen')),
              Center(child: Text('Home Screen')),
            ],
          ),
        ],
      ),
    );
  }
}
