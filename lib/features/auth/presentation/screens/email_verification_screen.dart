import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:messenger/shared/widgets/custom_appbar.dart';

class EmailVerificationScreen extends ConsumerWidget {
  const EmailVerificationScreen({super.key, required String email});

  // final String email;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Email Verification Screen'),
      body: Center(child: Text('Email Verification Screen')),
    );
  }
}
