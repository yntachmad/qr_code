import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:qr_code/models/product.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../bloc/bloc.dart';

import '../routes/router.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    ProductBloc productBloc = context.read<ProductBloc>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Products'),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot<Product>>(
        stream: productBloc.streamProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (!snapshot.hasData) {
            return const Center(
              child: Text('Tidak ada data'),
            );
          }
          if (snapshot.hasError) {
            return const Center(
              child: Text('Error proses ambil data'),
            );
          }
          List<Product> allProducts = [];
          for (var element in snapshot.data!.docs) {
            allProducts.add(element.data());
          }
          return ListView.builder(
              itemCount: allProducts.length,
              itemBuilder: (context, index) {
                Product product = allProducts[index];
                return Card(
                  elevation: 5,
                  margin: const EdgeInsets.only(bottom: 5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(9),
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(9),
                    onTap: () {
                      context.goNamed(
                        Routers.detailProduct,
                        pathParameters: {
                          'productId': product.code.toString(),
                        },
                        extra: product,
                        // extra: Product,
                        // // queryParameters: {},
                      );
                    },
                    child: Container(
                      height: 110,
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.code!,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 2,
                                ),
                                Text(product.name!),
                                Text("Jumlah : ${product.quantity!}"),
                              ],
                            ),
                          ),
                          Container(
                            height: 70,
                            width: 70,
                            color: Colors.amber,
                            child: QrImageView(
                              data: product.code!,
                              size: 200.0,
                              version: QrVersions.auto,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              });
        },
      ),
    );
  }
}
