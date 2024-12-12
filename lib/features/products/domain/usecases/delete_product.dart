import 'package:products_dummyjson/features/products/domain/repositories/products_repository.dart';

class DeleteProductUsecase {
  final ProductsRepository repository;

  DeleteProductUsecase(this.repository);

future<Failure, Unit> (int productId) async {
    return await repository.deleteProducts(productId);
  }
}