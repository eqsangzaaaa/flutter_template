// ignore_for_file: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_template/features/product/domain/model/product_model.dart';
import 'package:flutter_template/features/product/domain/usecases/product_usecases.dart';


part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductUseCase productUseCase;

  ProductBloc({this.productUseCase = const ProductUseCasesImpl()})
      : super(ProductInitial()) {
    on<ProductEvent>((event, emit) async {
      emit(ProductLoading());

      final product = await productUseCase.getProduct();

      emit(GetProductStateSuccess(products: product));
    });
  }
}