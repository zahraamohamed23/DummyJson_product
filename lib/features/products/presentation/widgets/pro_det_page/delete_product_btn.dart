import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:products_dummyjson/core/config/widget/load.dart';
import 'package:products_dummyjson/core/utils/snake_msg.dart';
import 'package:products_dummyjson/features/products/presentation/bloc/pro_add_del_up_bloc/product_add_del_up_state.dart';
import 'package:products_dummyjson/features/products/presentation/bloc/pro_add_del_up_bloc/product_add_dele_up_bloc.dart';
import 'package:products_dummyjson/features/products/presentation/pages/products_pages.dart';
import 'package:products_dummyjson/features/products/presentation/widgets/pro_det_page/delete_pro.dart';

class DeleteProductBtnWidget extends StatelessWidget {
  final int productId;
  const DeleteProductBtnWidget({
    super.key,
    required this.productId,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(
          Colors.redAccent,
        ),
      ),
      onPressed: () => deleteDialog(context, productId),
      icon: const Icon(Icons.delete_outline),
      label: const Text("Delete"),
    );
  }

  void deleteDialog(BuildContext context, int productId) {
    showDialog(
        context: context,
        builder: (context) {
          return BlocConsumer<AddDeleteUpdateProductBloc,
              AddDeleteUpdateProductState>(
            listener: (context, state) {
              if (state is MessageAddDeleteUpdateProductState) {
                SnackBarMessage().showSuccessSnackBar(
                    message: state.message, context: context);

                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (_) => const ProductsPage(),
                    ),
                    (route) => false);
              } else if (state is ErrorAddDeleteUpdateProductState) {
                Navigator.of(context).pop();
                SnackBarMessage().showErrorSnackBar(
                    message: state.message, context: context);
              }
            },
            builder: (context, state) {
              if (state is LoadingAddDeleteUpdateProductState) {
                return const AlertDialog(
                  title: LoadingWidget(),
                );
              }
              return DeleteDialogWidget(productId: productId);
            },
          );
        });
  }
}