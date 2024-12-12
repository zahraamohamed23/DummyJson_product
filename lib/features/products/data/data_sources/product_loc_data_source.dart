import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:products_dummyjson/core/utils/cons.dart';
import 'package:products_dummyjson/core/utils/error.dart';
import 'package:products_dummyjson/features/products/data/models/product_model.dart';
import 'package:shared_preferences/shared_preferences.dart';


abstract class ProductLocalDataSource {
  Future<List<ProductModel>> getCachedProducts();
  Future<Unit> cacheProducts(List<ProductModel> productModels);
}

class ProductLocalDataSourceImpl implements ProductLocalDataSource {
  final SharedPreferences sharedPreferences;

  ProductLocalDataSourceImpl({required this.sharedPreferences});
  @override
  Future<Unit> cacheProducts(List<ProductModel> productModels) {
    List productModelsToJson = productModels
        .map<Map<String, dynamic>>((productModel) => productModel.toJson())
        .toList();
    sharedPreferences.setString(cacheProducts as String, json.encode(productModelsToJson));
    return Future.value(unit);
  }

  @override
  Future<List<ProductModel>> getCachedProducts() {
    final jsonString = sharedPreferences.getString(cACHEDPRODUCTS);
    if (jsonString != null) {
      List decodeJsonData = json.decode(jsonString);
      List<ProductModel> jsonToProductModels = decodeJsonData
          .map<ProductModel>((jsonProductModel) => ProductModel.fromJson(jsonProductModel))
          .toList();
      return Future.value(jsonToProductModels);
    } else {
      throw EmptyCacheException();
    }
  }
}