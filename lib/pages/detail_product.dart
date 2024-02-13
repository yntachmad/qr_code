import 'package:flutter/material.dart';

import '../models/product.dart';

// import '../models/product.dart';

class DetailProductPage extends StatelessWidget {
  const DetailProductPage(
      {required this.productId, required this.data, super.key});
  final String productId;
  final Product data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Product Page'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'Test',
        ),
      ),
    );
  }
}
