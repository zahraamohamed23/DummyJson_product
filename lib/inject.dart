import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:products_dummyjson/core/utils/net_info.dart';
import 'package:products_dummyjson/features/products/data/data_sources/product_loc_data_source.dart';
import 'package:products_dummyjson/features/products/data/data_sources/product_remote_data_source.dart';
import 'package:products_dummyjson/features/products/data/repositories/product_repos_imp.dart';
import 'package:products_dummyjson/features/products/domain/repositories/products_repository.dart';
import 'package:products_dummyjson/features/products/domain/usecases/addproduct.dart';
import 'package:products_dummyjson/features/products/domain/usecases/get_all_product.dart';
import 'package:products_dummyjson/features/products/domain/usecases/updates_product.dart';
import 'package:products_dummyjson/features/products/presentation/bloc/pro_add_del_up_bloc/product_add_dele_up_bloc.dart';
import 'package:products_dummyjson/features/products/presentation/bloc/products/products_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:products_dummyjson/features/products/domain/usecases/delete_product.dart';
import 'package:products_dummyjson/features/products/data/repositories/product_repos_imp2.dart';



final sl = GetIt.instance;


Future<void> init() async {
  //! Features - Products
  sl.registerFactory(() => ProductsBloc(getAllProducts: sl()));
  sl.registerFactory(() => AddDeleteUpdateProductBloc(
      addProduct: sl(), updateProduct: sl(), deleteProduct: sl()));

  sl.registerLazySingleton(() => GetProductsUsecase(sl()));
  sl.registerLazySingleton(() => AddProductUsecase(sl()));
  sl.registerLazySingleton(() => DeleteProductUsecase(sl()));
  sl.registerLazySingleton(() => UpdateProductUsecase(sl()));

  sl.registerLazySingleton<ProductsRepository>(() => ProductsRepositoryImpl(
      remoteDataSource: sl(), localDataSource: sl(), networkInfo: sl()));

  sl.registerLazySingleton<ProductRemoteDataSource>(
      () => ProductRemoteDataSourceImpl());
  sl.registerLazySingleton<ProductLocalDataSource>(
      () => ProductLocalDataSourceImpl(sharedPreferences: sl()));

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

  sl.registerLazySingleton<InternetConnectionChecker>(
      () => InternetConnectionChecker());
}


