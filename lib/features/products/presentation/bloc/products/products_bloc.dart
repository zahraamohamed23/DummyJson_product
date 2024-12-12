import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; 
import 'package:products_dummyjson/core/utils/error.dart';
import 'package:products_dummyjson/features/products/domain/entities/prouct.dart';
import 'package:products_dummyjson/features/products/domain/usecases/get_all_product.dart';
import 'package:products_dummyjson/features/products/presentation/bloc/products/products_event.dart';
import 'package:products_dummyjson/features/products/presentation/bloc/products/products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> { 
  final GetProductsUsecase getAllProducts;

  ProductsBloc({
    required this.getAllProducts,
  }) : super(ProductsInitial()) {
    on<ProductsEvent>((event, emit) async {
      if (event is GetAllProductsEvent || event is RefreshProductsEvent) {
        emit(LoadingProductsState());

        final failureOrProducts = await getAllProducts();

        emit(_mapFailureOrProductsToState(failureOrProducts as Either<Failure, List<Product>>));
      }
    });
  }

  ProductsState _mapFailureOrProductsToState(Either<Failure, List<Product>> either) {
    return either.fold(
      (failure) => ErrorProductsState(message: _mapFailureToMessage(failure)),
      (products) => LoadedProductsState(products: products),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure _:
        return sERVERFAILUREMESSAGE; 
      case EmptyCacheFailure _:
        return eMPTYCACHEFAILUREMESSAGE; 
      case OfflineFailure _:
        return oFFLINEFAILUREMESSAGE; 
      default:
        return "Unexpected Error, Please try again later.";
    }
  }

  void addEvent(ProductsEvent event) {
    add(event);
  }
}