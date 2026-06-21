import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:messenger/shared/widgets/custom_appbar.dart';

class MediaGalleryScreen extends ConsumerWidget {
  final String mediaId;
  const MediaGalleryScreen({super.key, required this.mediaId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Telegram'),
      body: Center(child: Text('Telegram')),
    );
  }
}
