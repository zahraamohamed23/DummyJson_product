import 'package:products_dummyjson/features/products/domain/entities/prouct.dart';

class ProductModel extends Product {
  const ProductModel({
    required super.id, 
    required super.title, 
    required super.body, 
    required super.price, 
    });
  
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(id: json['id'], title: json['title'], body: json['body'], price: 20 );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'title': title, 'body': body};
  }
}