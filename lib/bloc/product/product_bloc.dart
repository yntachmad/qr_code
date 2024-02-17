import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:qr_code/models/product.dart';
import 'package:pdf/widgets.dart' as pw;
// import '../../models/product.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  Stream<QuerySnapshot<Product>> streamProducts() async* {
    yield* firebaseFirestore
        .collection("products")
        .withConverter<Product>(
          fromFirestore: (snapshot, _) => Product.fromJson(snapshot.data()!),
          toFirestore: (product, _) => product.toJson(),
        )
        .snapshots();
  }

  ProductBloc() : super(ProductStateInitial()) {
    on<ProductEventAddProduct>((event, emit) async {
      // Add Product to cloud firebase
      try {
        emit(ProductStateAddLoading());
        var hasil = await firebaseFirestore.collection("products").add(
          {"name": event.name, "code": event.code, "quantity": event.quantity},
        );
        await firebaseFirestore
            .collection("products")
            .doc(hasil.id)
            .update({"productID": hasil.id});
        emit(ProductStateAddComplete());
      } on FirebaseException catch (e) {
        emit(
          ProductStateError(message: e.message ?? "Tidak dapat maenambah data"),
        );
      } catch (e) {
        emit(
          ProductStateError(message: "Tidak dapat maenambah data"),
        );
      }
    });
    on<ProductEventEditProduct>((event, emit) async {
      // Edit Product to cloud firebase
      try {
        emit(ProductStateEditLoading());
        await firebaseFirestore
            .collection("products")
            .doc(event.productId)
            .update({"name": event.name, "quantity": event.quantity});
        emit(ProductStateEditComplete());
      } on FirebaseException catch (e) {
        emit(
          ProductStateError(message: e.message ?? "Tidak dapat mengubah data"),
        );
      } catch (e) {
        emit(
          ProductStateError(message: "Tidak dapat mengubah data"),
        );
      }
    });
    on<ProductEventDeleteProduct>((event, emit) async {
      // Delete Product to cloud firebase
      try {
        emit(ProductStateDeleteLoading());
        await firebaseFirestore.collection("products").doc(event.code).delete();
        emit(ProductStateDeleteComplete());
      } on FirebaseException catch (e) {
        emit(
          ProductStateError(
              message: e.message ?? "Tidak dapat menghapus data FireBase"),
        );
      } catch (e) {
        emit(
          ProductStateError(message: "Tidak dapat menghapus data"),
        );
      }
    });
    on<ProductEventDetailProduct>((event, emit) async {
      // Delete Product to cloud firebase
      try {
        emit(ProductStateDeleteLoading());
        var querySnap = await firebaseFirestore
            .collection("products")
            .where('code', isEqualTo: event.code)
            .withConverter<Product>(
              fromFirestore: (snapshot, _) =>
                  Product.fromJson(snapshot.data()!),
              toFirestore: (product, _) => product.toJson(),
            )
            .get();

        // Map<String, dynamic> pro = Product.fromJson(querySnap.dcos.f);

        emit(ProductStateDetailComplete(
            product: querySnap.docs.first.data(), code: event.code));
      } on FirebaseException catch (e) {
        emit(
          ProductStateError(
              message: e.message ?? "Tidak dapat menghapus data FireBase"),
        );
      } catch (e) {
        emit(
          ProductStateError(message: "Tidak dapat menghapus data"),
        );
      }
    });
    on<ProductEventExportToPdfProduct>((event, emit) async {
      // Delete Product to cloud firebase
      try {
        emit(ProductStateExportLoading());
        // print('test export');

        //fetching data all Product
        var querySnap = await firebaseFirestore
            .collection("products")
            .withConverter<Product>(
              fromFirestore: (snapshot, _) =>
                  Product.fromJson(snapshot.data()!),
              toFirestore: (product, _) => product.toJson(),
            )
            .get();

        List<Product> allProduct = [];
        for (var element in querySnap.docs) {
          Product product = element.data();
          allProduct.add(product);
        }
        //Create Pdf

        final pdf = pw.Document();

        var data =
            await rootBundle.load("assets/fonts/opensans/OpenSans-Regular.ttf");

        var myFont = pw.Font.ttf(data);

        var myStyle = pw.TextStyle(font: myFont);

        pdf.addPage(
          pw.MultiPage(
            pageFormat: PdfPageFormat.a4,
            build: (context) {
              return [
                pw.Text("Test", style: myStyle),
              ];
            },
          ),
        );

        Uint8List byte = await pdf.save();

        //Open File
        final dir = await getApplicationDocumentsDirectory();
        File file = File('${dir.path}/myProducts.pdf');

        //masukin data bytes ke pdf
        await file.writeAsBytes(byte);

        OpenFile.open(file.path);

        emit(ProductStateExportComplete());
      } on FirebaseException catch (e) {
        emit(
          ProductStateError(
              message: e.message ?? "Tidak dapat mengExport data FireBase"),
        );
      } catch (e) {
        emit(
          ProductStateError(message: "Tidak dapat mengExport data"),
        );
      }
    });
  }
}
