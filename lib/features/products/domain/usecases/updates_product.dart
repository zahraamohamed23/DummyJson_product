import 'package:products_dummyjson/features/products/domain/entities/prouct.dart';
import 'package:products_dummyjson/features/products/domain/repositories/products_repository.dart';

class UpdateProductUsecase {
  final ProductsRepository repository;

  UpdateProductUsecase(this.repository);

  future<Failure, Unit>(Product product) async {
    return await repository.updateProducts(product);
  }
}