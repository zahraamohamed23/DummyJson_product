import 'package:products_dummyjson/features/products/domain/entities/prouct.dart';
import 'package:products_dummyjson/features/products/domain/repositories/products_repository.dart';

class AddProductUsecase {
  final ProductsRepository repository;

  AddProductUsecase(this.repository);

  future<Failure, Unit>(Product product) async {
    return await repository.addProducts(product);
  }
}