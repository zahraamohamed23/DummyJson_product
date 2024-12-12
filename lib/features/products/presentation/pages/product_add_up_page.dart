import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:products_dummyjson/core/config/widget/load.dart';
import 'package:products_dummyjson/core/utils/snake_msg.dart';
import 'package:products_dummyjson/features/products/domain/entities/prouct.dart';
import 'package:products_dummyjson/features/products/presentation/bloc/pro_add_del_up_bloc/product_add_del_up_state.dart';
import 'package:products_dummyjson/features/products/presentation/bloc/pro_add_del_up_bloc/product_add_dele_up_bloc.dart';
import 'package:products_dummyjson/features/products/presentation/pages/products_pages.dart';
import 'package:products_dummyjson/features/products/presentation/widgets/prod_add_up_page/form_w.dart';

class ProductAddUpdatePage extends StatelessWidget {
  final Product? product;
  final bool isUpdateProduct;
  const ProductAddUpdatePage({super.key, this.product, required this.isUpdateProduct});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppbar() {
    return AppBar(title: Text(isUpdateProduct ? "Edit Product" : "Add Product"));
  }

  Widget _buildBody() {
    return Center(
      child: Padding(
          padding: const EdgeInsets.all(10),
          child:
              BlocConsumer<AddDeleteUpdateProductBloc, AddDeleteUpdateProductState>(
            listener: (context, state) {
              if (state is MessageAddDeleteUpdateProductState) {
                SnackBarMessage().showSuccessSnackBar(
                    message: state.message, context: context);
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => const ProductsPage()),
                    (route) => false);
              } else if (state is ErrorAddDeleteUpdateProductState) {
                SnackBarMessage().showErrorSnackBar(
                    message: state.message, context: context);
              }
            },
            builder: (context, state) {
              if (state is LoadingAddDeleteUpdateProductState) {
                return const LoadingWidget();
              }

              return FormWidget(
                  isUpdateProduct: isUpdateProduct, product: isUpdateProduct ? product : null);
            },
          )),
    );
  }
}