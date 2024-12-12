import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:products_dummyjson/features/products/domain/entities/prouct.dart';
import 'package:products_dummyjson/features/products/presentation/bloc/pro_add_del_up_bloc/product_add_del_up_events.dart';
import 'package:products_dummyjson/features/products/presentation/bloc/pro_add_del_up_bloc/product_add_dele_up_bloc.dart';
import 'package:products_dummyjson/features/products/presentation/widgets/prod_add_up_page/form_sumbit_wi.dart';
import 'package:products_dummyjson/features/products/presentation/widgets/prod_add_up_page/txt_form_wi.dart';

class FormWidget extends StatefulWidget {
  final bool isUpdateProduct;
  final Product? product;

  const FormWidget({
    super.key,
    required this.isUpdateProduct,
    this.product,
  });

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.isUpdateProduct && widget.product != null) {
      _titleController.text = widget.product!.title;
      _bodyController.text = widget.product!.body;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextFormFieldWidget(
            name: "Title",
            multiLines: false,
            controller: _titleController,
          ),
          TextFormFieldWidget(
            name: "Body",
            multiLines: true,
            controller: _bodyController,
          ),
          FormSubmitBtn(
            isUpdateProduct: widget.isUpdateProduct,
            onPressed: validateFormThenUpdateOrAddProduct,
          ),
        ],
      ),
    );
  }

  void validateFormThenUpdateOrAddProduct() {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      final product = Product(
        id: widget.isUpdateProduct ? widget.product!.id : 123, 
        title: _titleController.text,
        body: _bodyController.text, 
        price: 20,
        
      );

      if (widget.isUpdateProduct) {
        BlocProvider.of<AddDeleteUpdateProductBloc>(context)
            .add(UpdateProductEvent(product: product)); 
      } else {
        BlocProvider.of<AddDeleteUpdateProductBloc>(context)
            .add(AddProductEvent(product: product));
      }
    }
  }
}