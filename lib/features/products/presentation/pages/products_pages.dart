import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:products_dummyjson/core/config/widget/load.dart';
import 'package:products_dummyjson/core/routes/routes_name.dart';
import 'package:products_dummyjson/features/products/presentation/bloc/products/products_bloc.dart';
import 'package:products_dummyjson/features/products/presentation/bloc/products/products_event.dart';
import 'package:products_dummyjson/features/products/presentation/bloc/products/products_state.dart';
import 'package:products_dummyjson/features/products/presentation/widgets/pro_page/msg_dis.dart';
import 'package:products_dummyjson/features/products/presentation/widgets/pro_page/products_list.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(),
      body: _buildBody(),
      floatingActionButton: _buildFloatingBtn(context),
    );
  }

  AppBar _buildAppbar() => AppBar(title: const Text('Products'));

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: BlocBuilder<ProductsBloc, ProductsState>(
        builder: (context, state) {
          if (state is LoadingProductsState) {
            return const LoadingWidget();
          } else if (state is LoadedProductsState) {
            return RefreshIndicator(
                onRefresh: () => _onRefresh(context),
                child: ProductListWidget(products: state.products));
          } else if (state is ErrorProductsState) {
            return MessageDisplayWidget(message: state.message);
          }
          return const LoadingWidget();
        },
      ),
    );
  }

  Future<void> _onRefresh(BuildContext context) async {
    BlocProvider.of<ProductsBloc>(context).add(RefreshProductsEvent());
  }

  Widget _buildFloatingBtn(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.pushNamed(
            context,
            AppCharRoute.addOrUpdate,
            arguments: {
              'isUpdateProduct': false
            });
      },
      child: const Icon(Icons.add),
    );
  }
}