import 'package:flutter/material.dart';
import 'package:messenger/core/theme/app_colors.dart';
import 'package:messenger/widgets/custom_appbar.dart';
import 'package:messenger/widgets/custom_drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
