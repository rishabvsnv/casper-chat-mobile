import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:messenger/shared/widgets/custom_appbar.dart';

class FileViewerScreen extends ConsumerWidget {
  const FileViewerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Telegram'),
      body: Center(child: Text('Telegram')),
    );
  }
}
