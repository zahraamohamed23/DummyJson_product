import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:products_dummyjson/features/products/presentation/bloc/pro_add_del_up_bloc/product_add_del_up_events.dart';
import 'package:products_dummyjson/features/products/presentation/bloc/pro_add_del_up_bloc/product_add_dele_up_bloc.dart';

class DeleteDialogWidget extends StatelessWidget {
  final int productId;
  const DeleteDialogWidget({
    super.key,
    required this.productId,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Are you Sure ?"),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text(
            "No",
          ),
        ),
        TextButton(
          onPressed: () {
            BlocProvider.of<AddDeleteUpdateProductBloc>(context).add(
              DeleteProductEvent(productId: productId),
            );
          },
          child: const Text("Yes"),
        ),
      ],
    );
  }
}