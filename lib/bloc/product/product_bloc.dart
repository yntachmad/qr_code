import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qr_code/models/product.dart';

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
    on<ProductEventExportToPdfProduct>((event, emit) async {
      // Delete Product to cloud firebase
      try {
        emit(ProductStateExportLoading());
        // await firebaseFirestore.collection("products").doc(event.code).delete();
        //fetching data all Product

        //Create Pdf

        //Open File
        emit(ProductStateExportComplete());
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
  }
}
