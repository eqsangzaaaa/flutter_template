// ignore_for_file: must_be_immutable

part of 'product_bloc.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {
  @override
  String toString() => 'Loading...';
}

class ProductError extends ProductState {
  final String message;
  const ProductError({required this.message});
}

class GetProductStateSuccess extends ProductState {
  List<ProductModel> products;
  GetProductStateSuccess({required this.products});
}
