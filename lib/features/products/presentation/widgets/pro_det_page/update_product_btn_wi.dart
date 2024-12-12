import 'package:flutter/material.dart';
import 'package:products_dummyjson/core/routes/routes_name.dart';
import 'package:products_dummyjson/features/products/domain/entities/prouct.dart';

class UpdateProductBtnWidget extends StatelessWidget {
  final Product product;
  const UpdateProductBtnWidget({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        Navigator.pushNamed(
            context,
            AppCharRoute.addOrUpdate,
            arguments: {
              'isUpdatePost': true,
              'product': product
            });
      },
      icon: const Icon(Icons.edit),
      label: const Text("Edit"),
    );
  }
}