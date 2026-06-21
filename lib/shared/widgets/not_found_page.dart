import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:messenger/core/constants/image.dart';

class NotFoundPage extends ConsumerWidget {
  final String? redirectRoute;

  const NotFoundPage({super.key, this.redirectRoute = "/login"});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.blue,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 404 Illustration
                Container(
                  // height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Image.asset(Images.notFoundPage),
                ),

                const SizedBox(height: 16),

                // Title & Message
                Text(
                  "Page Not Found",
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Text(
                  "The page you are looking for doesn’t exist\nor has been moved.",
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: Colors.white70,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 40),

                // Back button
                ElevatedButton.icon(
                  onPressed: () => context.go(redirectRoute!),
                  icon: const Icon(Icons.home, color: Colors.white),
                  label: const Text(
                    "Back to Home",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
