import 'package:flutter_template/features/product/data/repositories/product_repository.dart';
import 'package:flutter_template/features/product/domain/model/product_model.dart';

abstract class ProductUseCase {
  Future<List<ProductModel>> getProduct();
}

class ProductUseCasesImpl implements ProductUseCase {
  final ProductRepository productRepository;

  const ProductUseCasesImpl(
      {this.productRepository = const ProductRepositoryImpl()});

  @override
  Future<List<ProductModel>> getProduct() async {
    List<ProductModel> products = [];
    final result = await productRepository.getProduct();
    if (result.isNotEmpty) {
      products = result
          .map((e) => ProductModel(
              id: e.id, name: e.name, price: e.price, image: e.image))
          .toList();
      return products;
    }
    return products;
  }
}
