import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../routes/router.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('All Product'),
        ),
        body: ListView.builder(
          itemCount: 20,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text('Product ${index + 1}'),
              subtitle: Text('Diskripsi Product ${index + 1}'),
              leading: CircleAvatar(
                child: Text('${index + 1}'),
              ),
              onTap: () {
                // GoRouter.of(context).push('/product');
                // parsing parameters
                // context.go('/product/${index + 1}');

                //pengunaan Routing dynamic goNamed
                context.goNamed(
                  Routers.detailProduct,
                  pathParameters: {
                    'productId': '${index + 1}',
                  },
                  queryParameters: {
                    'id': '${index + 1}',
                    'deskripsi': 'Deskripsi Product ${index + 1}',
                  },
                );
              },
            );
          },
        ));
  }
}
