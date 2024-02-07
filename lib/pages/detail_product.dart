import 'package:flutter/material.dart';

class DetailProductPage extends StatelessWidget {
  const DetailProductPage({super.key});
  // final String id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Product Page'),
      ),
      body: const Center(
        child: Text('Detail Product Page'),
      ),
    );
  }
}
