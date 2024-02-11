part of 'product_bloc.dart';

sealed class ProductState {}
//State / Kondisi saat ini
//Product awal -> initial / state awal
//Product Loading -> proses event
//Product Complete -> fetch data from database
//product error -> proses gagal

final class ProductStateInitial extends ProductState {}

class ProductStateLoading extends ProductState {}

class ProductStateComplete extends ProductState {}

class ProductStateError extends ProductState {
  final String message;

  ProductStateError({required this.message});
}
