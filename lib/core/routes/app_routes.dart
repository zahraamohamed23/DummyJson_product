import 'package:flutter/material.dart';
import 'package:products_dummyjson/core/routes/routes_name.dart';
import 'package:products_dummyjson/features/products/presentation/pages/product_add_up_page.dart';
import 'package:products_dummyjson/features/products/presentation/pages/products_pages.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppCharRoute.products:
        return MaterialPageRoute(builder: (_) => const ProductsPage());
      case AppCharRoute.addOrUpdate:
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
            builder: (_) => ProductAddUpdatePage(
                  isUpdateProduct: args?['isUpdateProduct'] ?? false,
                  product: args?['product'],
                ));
    }
    return null;
  }
}
