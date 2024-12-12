import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:products_dummyjson/core/utils/error.dart';
import 'package:products_dummyjson/core/utils/massage.dart';
import 'package:products_dummyjson/features/products/domain/usecases/addproduct.dart';
import 'package:products_dummyjson/features/products/domain/usecases/delete_product.dart';
import 'package:products_dummyjson/features/products/domain/usecases/updates_product.dart';
import 'package:products_dummyjson/features/products/presentation/bloc/pro_add_del_up_bloc/product_add_del_up_events.dart';
import 'package:products_dummyjson/features/products/presentation/bloc/pro_add_del_up_bloc/product_add_del_up_state.dart';



class AddDeleteUpdateProductBloc
    extends Bloc<AddDeleteUpdateProductEvent, AddDeleteUpdateProductState> {
  final AddProductUsecase addProduct;
  final DeleteProductUsecase deleteProduct;
  final UpdateProductUsecase updateProduct;
  AddDeleteUpdateProductBloc(
      {required this.addProduct,
      required this.deleteProduct,
      required this.updateProduct})
      : super(AddDeleteUpdateProductInitial()) {
    on<AddDeleteUpdateProductEvent>((event, emit) async {
      if (event is AddProductEvent) {
        emit(LoadingAddDeleteUpdateProductState());

        final failureOrDoneMessage = addProduct;

        emit(
          _eitherDoneMessageOrErrorState(
              failureOrDoneMessage as Either<Failure, Unit>, aDDSUCCESSMESSAGE),
        );
      } else if (event is UpdateProductEvent) {
        emit(LoadingAddDeleteUpdateProductState());

        final failureOrDoneMessage = updateProduct;

        emit(
          _eitherDoneMessageOrErrorState(
              failureOrDoneMessage as Either<Failure, Unit>, uPDATESUCCESSMESSAGE),
        );
      } else if (event is DeleteProductEvent) {
        emit(LoadingAddDeleteUpdateProductState());

        final failureOrDoneMessage = deleteProduct;

        emit(
          _eitherDoneMessageOrErrorState(
              failureOrDoneMessage as Either<Failure, Unit>, dELETESUCCESSMESSAGE),
        );
      }
    });
  }

  AddDeleteUpdateProductState _eitherDoneMessageOrErrorState(
      Either<Failure, Unit> either, String message) {
    return either.fold(
      (failure) => ErrorAddDeleteUpdateProductState(
        message: _mapFailureToMessage(failure),
      ),
      (_) => MessageAddDeleteUpdateProductState(message: message),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure _:
        return sERVERFAILUREMESSAGE;
      case OfflineFailure _:
        return oFFLINEFAILUREMESSAGE;
      default:
        return "Unexpected Error , Please try again later .";
    }
  }
}