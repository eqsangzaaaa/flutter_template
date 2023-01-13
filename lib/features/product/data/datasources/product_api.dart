import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_template/features/product/data/enum/product_provider.dart';
import 'package:flutter_template/shared/abstract/target_type.dart';
import 'package:flutter_template/shared/constant/api_status_code.dart';
import 'package:flutter_template/shared/constant/api_status_message.dart';
import 'package:flutter_template/shared/models/api_status.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

abstract class ProductApi {
  Future<dynamic> execute();
}

class ProductApiImpl implements ProductApi, TargetType {
  ProductProvider provider;

  ProductApiImpl({required this.provider});

  @override
  String get baseURL {
    String url;
    switch (provider) {
      case ProductProvider.getProduct:
        url = dotenv.get('API_URL');
        break;
    }
    return url;
  }

  @override
  String get path {
    String pathReq;
    switch (provider) {
      case ProductProvider.getProduct:
        pathReq = "/getAll";
        break;
    }
    return pathReq;
  }

  @override
  String get url {
    return baseURL + path;
  }

  @override
  Future<Response> request() async {
    final uri = Uri.parse(url);
    Response response;
    switch (provider) {
      case ProductProvider.getProduct:
        response = await http.get(uri);
        break;
    }
    return response;
  }

  @override
  Future<dynamic> execute() async {
    try {
      var response = await request();
      if (response.statusCode == success) {
        return Success<String>(
          code: success,
          response: response.body,
        );
      }
      return Failure<String>(
        code: invalidResponse,
        errorResponse: invalidResponseMsg,
      );
    } on HttpException {
      return Failure<String>(
        code: noInternet,
        errorResponse: noInternetMsg,
      );
    } on FormatException {
      return Failure<String>(
        code: invalidFormat,
        errorResponse: invalidFormatMsg,
      );
    } catch (e) {
      return Failure<String>(
        code: unknownError,
        errorResponse: unknownErrorMsg,
      );
    }
  }
}
