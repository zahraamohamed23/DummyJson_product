import 'package:flutter/material.dart';
import 'package:products_dummyjson/features/products/domain/entities/prouct.dart';
import 'package:products_dummyjson/features/products/presentation/widgets/pro_det_page/delete_product_btn.dart';
import 'package:products_dummyjson/features/products/presentation/widgets/pro_det_page/update_product_btn_wi.dart';

class ProductDetailWidget extends StatelessWidget {
  final Product product;
  const ProductDetailWidget({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Text(
            product.title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Divider(
            height: 50,
          ),
          Text(
            product.body,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          const Divider(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              UpdateProductBtnWidget(product: product),
              DeleteProductBtnWidget(productId: product.id)
            ],
          )
        ],
      ),
    );
  }
}