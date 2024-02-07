import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                GoRouter.of(context).go('/settings');
                // context.go('/setting');
              },
              child: const Text('Settings Pages'),
            ),
            ElevatedButton(
              onPressed: () {
                // GoRouter.of(context).push('/setting');
                context.go('/product');
              },
              child: const Text('All Product'),
            ),
          ],
        ),
      ),
    );
  }
}
