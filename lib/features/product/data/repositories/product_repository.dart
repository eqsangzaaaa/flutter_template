import 'dart:convert';

import 'package:flutter_template/features/product/data/datasources/product_api.dart';
import 'package:flutter_template/features/product/data/enum/product_provider.dart';
import 'package:flutter_template/features/product/data/models/product_response.dart';
import 'package:flutter_template/shared/models/api_status.dart';

abstract class ProductRepository {
  Future<List<ProductResponse>> getProduct();
}

class ProductRepositoryImpl implements ProductRepository {
   const ProductRepositoryImpl();
  @override
  Future<List<ProductResponse>> getProduct() async {
      final prodcutApi = ProductApiImpl(provider: ProductProvider.getProduct);
     final result = await prodcutApi.execute();
      if (result is Success<String>) {
        print(result.response);
         final response = productResponseFromJson(result.response);
      return response;
    }
     return [];
  }
}
