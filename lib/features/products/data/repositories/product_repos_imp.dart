import 'package:dartz/dartz.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:products_dummyjson/core/utils/error.dart';
import 'package:products_dummyjson/features/products/data/data_sources/product_loc_data_source.dart';
import 'package:products_dummyjson/features/products/data/data_sources/product_remote_data_source.dart';
import 'package:products_dummyjson/features/products/data/models/product_model.dart';
import 'package:products_dummyjson/features/products/domain/entities/prouct.dart';
import 'package:products_dummyjson/features/products/domain/repositories/products_repository.dart';


  abstract class ProductsRepositoryImpl implements ProductsRepository {
  final ProductRemoteDataSource remoteDataSource;
  final ProductLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  ProductsRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  Future<Either<Failure, List<Product>>> getallProducts() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteProducts = await remoteDataSource.getAllProducts();
        localDataSource.cacheProducts(remoteProducts);
        return Right(remoteProducts); // return Right if successful
      } on ServerException {
        return Left(ServerFailure()); // return Left if error
      }
    } else {
      try {
        final localProducts = await localDataSource.getCachedProducts();
        return Right(localProducts); // return cached products if no connection
      } on EmptyCacheException {
        return Left(EmptyCacheFailure()); // return Left if no cached products
      }
    }
  }
}

extension on NetworkInfo {
  get isConnected => null;
}


  Future<Either<Failure, Unit>> addProduct(Product product, dynamic networkInfo, dynamic remoteDataSource) async {
    final productModel = ProductModel(
      title: product.title,
      body: product.body,
      id: product.id,
      price: product.price,
    );

    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.addProduct(productModel);
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  Future<Either<Failure, Unit>> deleteProduct(int productId, dynamic networkInfo, dynamic remoteDataSource) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.deleteProduct(productId);
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  Future<Either<Failure, Unit>> updateProduct(Product product, dynamic networkInfo, dynamic remoteDataSource) async {
    final productModel = ProductModel(
      id: product.id,
      title: product.title,
      body: product.body,
      price: product.price,
    );

    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.updateProduct(productModel);
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

