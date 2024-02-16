// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'product_bloc.dart';

sealed class ProductEvent {}

//Event - Action (Trigger menjalankan fungsi)
//1. Add Product
//2. Edit Product
//3. Delete Product

class ProductEventAddProduct extends ProductEvent {
  // final Product product;
  final String code;
  final String name;
  final int quantity;
  ProductEventAddProduct(
      {required this.code, required this.name, required this.quantity});
}

class ProductEventEditProduct extends ProductEvent {
  final String name;
  final int quantity;
  final String productId;
  ProductEventEditProduct(
      {required this.name, required this.quantity, required this.productId});
}

class ProductEventDeleteProduct extends ProductEvent {
  final String code;
  ProductEventDeleteProduct({
    required this.code,
  });
}

class ProductEventExportToPdfProduct extends ProductEvent {}
