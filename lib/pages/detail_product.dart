import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

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
        body: ListView(
          padding: EdgeInsets.all(20),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 200,
                  width: 200,
                  child: QrImageView(
                    data: data.code!,
                  ),
                )
              ],
            )
          ],
        ));
  }
}
