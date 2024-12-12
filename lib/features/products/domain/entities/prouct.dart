import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final int id;
  final String title;
  final String body;
  final double price;
 

  const Product({
    required this.body, 
    required this.id, 
    required this.title, 
    required this.price, 
         });

  @override
  List get props => [id, title, body,price];
}
