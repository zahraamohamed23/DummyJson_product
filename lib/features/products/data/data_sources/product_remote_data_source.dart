import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:products_dummyjson/core/utils/cons.dart';
import 'package:products_dummyjson/core/utils/error.dart';
import 'package:products_dummyjson/features/products/data/models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getAllProducts();
  Future<Unit> deleteProduct(int productId);
  Future<Unit> updateProduct(ProductModel productModel);
  Future<Unit> addProduct(ProductModel productModel);
}

abstract class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  late Dio dio;

  ProductRemoteDataSourceImpl() {
    BaseOptions options = BaseOptions(
      baseUrl: pRODUCTSAPIBASEURL,
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30)
    );
    dio = Dio(options);
  }
  
  @override
  Future<List<ProductModel>> getAllProducts () async {
    Response response = await dio.get("/products/");
    if(response.statusCode == 200) {
      // [{}, {}] => [ProductModel, ProductModel]
      final List data = response.data as List;
      return data.map<ProductModel>((jsonProductModel) => ProductModel.fromJson(jsonProductModel))
          .toList();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> addProduct (ProductModel productModel) async {
    final body = {
      "title": productModel.title,
      "body": productModel.body,
    };
    Response response = await dio.product("/products/", data: body);
    if(response.statusCode == 201) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> deleteProduct (int productId) async {
    Response response = await dio.delete("/products/${productId.toString()}");
    if(response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> updateProduct (ProductModel productModel) async {
    final productId = productModel.id.toString();
    final body = {
      "title": productModel.title,
      "body": productModel.body,
    };
    Response response = await dio.patch("/products/$productId", data: body);
    if(response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }
}

extension on Dio {
  product(String s, {required Map<String, String> data}) {}
}