// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../bloc/bloc.dart';

import '../routes/router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        centerTitle: true,
      ),
      body: BlocListener<ProductBloc, ProductState>(
        listener: (context, state) {
          if (state is ProductStateDetailComplete) {
            context.goNamed(
              Routers.detailProduct,
              pathParameters: {
                'productId': state.code,
              },
              extra: state.product,
              // extra: Product,
              // // queryParameters: {},
            );
          }

          if (state is ProductStateErrorDetail) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                duration: const Duration(seconds: 2),
              ),
            );
          }
        },
        child: GridView.builder(
          padding: const EdgeInsets.all(20),
          itemCount: 4,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
          ),
          itemBuilder: (context, index) {
            late String title;
            late IconData icon;
            late VoidCallback onTap;

            switch (index) {
              case 0:
                title = 'Add Product';
                icon = Icons.post_add_rounded;
                onTap = () => context.goNamed(Routers.addProduct);
                break;
              case 1:
                title = 'Products';
                icon = Icons.list_alt_outlined;
                onTap = () => context.goNamed(Routers.product);
                break;
              case 2:
                title = 'QR Code';
                icon = Icons.qr_code;
                onTap = () async {
                  String barcode = await FlutterBarcodeScanner.scanBarcode(
                    '#000000',
                    "CANCEL",
                    true,
                    ScanMode.QR,
                  );

                  context.read<ProductBloc>().add(
                        ProductEventDetailProduct(code: barcode),
                      );

                  // SnackBar(
                  //   content: Text(barcode),
                  //   duration: const Duration(seconds: 2),
                  // );

                  // ScaffoldMessenger.of(context).showSnackBar(barcode);

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(barcode),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                };
                break;
              case 3:
                title = 'Katalog';
                icon = Icons.document_scanner_outlined;
                onTap = () {
                  context.read<ProductBloc>().add(
                        ProductEventExportToPdfProduct(),
                      );
                };
                break;
            }

            return Material(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(9),
              child: InkWell(
                  onTap: onTap,
                  borderRadius: BorderRadius.circular(9),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      (index == 3)
                          ? BlocConsumer<ProductBloc, ProductState>(
                              listener: (context, state) {},
                              builder: (context, state) {
                                if (state is ProductStateExportLoading) {
                                  return const CircularProgressIndicator();
                                }
                                return SizedBox(
                                  height: 50,
                                  width: 50,
                                  child: Icon(
                                    icon,
                                    size: 50,
                                  ),
                                );
                              },
                            )
                          : SizedBox(
                              height: 50,
                              width: 50,
                              child: Icon(
                                icon,
                                size: 50,
                              ),
                            ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(title),
                    ],
                  )),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<AuthBloc>().add(AuthEventLogout());
        },
        child: const Icon(Icons.logout),
      ),
    );
  }
}
