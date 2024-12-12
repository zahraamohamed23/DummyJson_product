import 'package:products_dummyjson/features/products/domain/entities/prouct.dart';

abstract class ProductsRepository {
  Future<List<Product>> getAllProducts();
  Future<List<Product>> searchProducts(String query);
  Future<bool> deleteProducts(int id);
  Future<bool> updateProducts(Product product);
  Future<bool> addProducts(Product product);
}
