import 'package:equatable/equatable.dart';
import 'package:products_dummyjson/features/products/domain/entities/prouct.dart';


abstract class AddDeleteUpdateProductEvent extends Equatable {
  const AddDeleteUpdateProductEvent();

  @override
  List<Object> get props => [];
}

class AddProductEvent extends AddDeleteUpdateProductEvent {
  final Product product;

  const AddProductEvent({required this.product});

  @override
  List<Object> get props => [product];
}

class UpdateProductEvent extends AddDeleteUpdateProductEvent {
   final Product product;

  const UpdateProductEvent({required this.product});

  @override
  List<Object> get props => [product];
}

class DeleteProductEvent extends AddDeleteUpdateProductEvent {
  final int productId;

  const DeleteProductEvent({required this.productId});

  @override
  List<Object> get props => [productId];
}