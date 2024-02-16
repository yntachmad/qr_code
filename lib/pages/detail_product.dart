import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_code/bloc/bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../models/product.dart';

// import '../models/product.dart';

class DetailProductPage extends StatelessWidget {
  DetailProductPage({required this.productId, required this.data, super.key});
  final String productId;
  final Product data;

  final TextEditingController codeC = TextEditingController();
  final TextEditingController nameC = TextEditingController();
  final TextEditingController qtyC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    codeC.text = data.code!;
    nameC.text = data.name!;
    qtyC.text = data.quantity!.toString();
    return Scaffold(
        appBar: AppBar(
          title: const Text('Detail Product Page'),
          centerTitle: true,
        ),
        body: ListView(
          padding: const EdgeInsets.all(20),
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
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              autocorrect: false,
              controller: codeC,
              keyboardType: TextInputType.number,
              readOnly: true,
              decoration: InputDecoration(
                labelText: "Product Code",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              autocorrect: false,
              controller: nameC,
              // keyboardType: TextInputType.number,
              // readOnly: true,
              decoration: InputDecoration(
                labelText: "Product Name",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              autocorrect: false,
              controller: qtyC,
              keyboardType: TextInputType.number,
              // readOnly: true,
              decoration: InputDecoration(
                labelText: "Product Quantity",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                context.read<ProductBloc>().add(
                      ProductEventEditProduct(
                          productId: data.productID!,
                          name: nameC.text,
                          quantity: int.tryParse(qtyC.text) ?? 0),
                    );
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9),
                ),
              ),
              child: BlocConsumer<ProductBloc, ProductState>(
                listener: (context, state) {
                  if (state is ProductStateEditComplete) {
                    context.pop();
                  }

                  if (state is ProductStateError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.message),
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is ProductStateEditLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return const Text(
                      "UPDATE PRODUCT",
                      // style: TextStyle(color: Colors.red.shade900),
                    );
                  }
                },
              ),
            ),
            TextButton(
              onPressed: () {
                context.read<ProductBloc>().add(
                      ProductEventDeleteProduct(code: data.productID!),
                    );
              },
              child: BlocConsumer<ProductBloc, ProductState>(
                listener: (context, state) {
                  if (state is ProductStateDeleteComplete) {
                    context.pop();
                  }

                  if (state is ProductStateError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.message),
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is ProductStateDeleteLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return Text(
                      "Delete Product",
                      style: TextStyle(color: Colors.red.shade900),
                    );
                  }
                },
              ),
            ),
          ],
        ));
  }
}
