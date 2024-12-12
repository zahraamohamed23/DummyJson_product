import 'package:products_dummyjson/features/products/domain/entities/prouct.dart';
import 'package:products_dummyjson/features/products/domain/repositories/products_repository.dart';

class GetProductsUsecase {
  final ProductsRepository repository;

  GetProductsUsecase(this.repository);

  Future<List<Product>>call() async {
    return await repository.getAllProducts();
  }
}