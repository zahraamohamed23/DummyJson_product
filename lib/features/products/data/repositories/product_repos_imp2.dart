import 'package:dartz/dartz.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:products_dummyjson/core/utils/error.dart';
import 'package:products_dummyjson/features/products/data/data_sources/product_loc_data_source.dart';
import 'package:products_dummyjson/features/products/data/data_sources/product_remote_data_source.dart';
import 'package:products_dummyjson/features/products/data/models/product_model.dart';
import 'package:products_dummyjson/features/products/domain/entities/prouct.dart';
import 'package:products_dummyjson/features/products/domain/repositories/products_repository.dart';

typedef DeleteOrUpdateOrAddProduct = Future<Unit> Function();

abstract class ProductsRepositoryImpl implements ProductsRepository {
  final ProductRemoteDataSource remoteDataSource;
  final ProductLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  ProductsRepositoryImpl(
      {required this.remoteDataSource,
      required this.localDataSource,
      required this.networkInfo});
  
  Future<Either<Failure, List<Product>>> getallProducts() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteProducts = await remoteDataSource.getAllProducts();
        localDataSource.cacheProducts(remoteProducts);
        return Right(remoteProducts);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localProducts = await localDataSource.getCachedProducts();
        return Right(localProducts);
      } on EmptyCacheException {
        return Left(EmptyCacheFailure());
      }
    }
  }

    Future<Either<Failure, Unit>> addProduct(Product product) async {
    final ProductModel productModel = ProductModel(title: product.title, body: product.body, id: product.id, price: product.price);

    return await _getMessage(() {
      return remoteDataSource.addProduct(productModel);
    });
  }

  Future<Either<Failure, Unit>> deleteProduct(int productId) async {
    return await _getMessage(() {
      return remoteDataSource.deleteProduct(productId);
    });
  }

  Future<Either<Failure, Unit>> updateProduct(Product product) async {
    final ProductModel productModel =
        ProductModel(id: product.id, title: product.title, body: product.body, price: product.price);

    return await _getMessage(() {
      return remoteDataSource.updateProduct(productModel);
    });
  }


  Future<Either<Failure, Unit>> _getMessage(
      DeleteOrUpdateOrAddProduct deleteOrUpdateOrAddProduct) async {
    if (await networkInfo.isConnected) {
      try {
        await deleteOrUpdateOrAddProduct();
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
  
}

extension on NetworkInfo {
  get isConnected => null;
}