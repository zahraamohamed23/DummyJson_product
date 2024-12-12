import 'package:flutter/material.dart';

class FormSubmitBtn extends StatelessWidget {
  final void Function() onPressed;
  final bool isUpdateProduct;

  const FormSubmitBtn({
    super.key,
    required this.onPressed,
    required this.isUpdateProduct,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
        onPressed: onPressed,
        icon: isUpdateProduct ? const Icon(Icons.edit) : const Icon(Icons.add),
        label: Text(isUpdateProduct ? "Update" : "Add"));
  }
}