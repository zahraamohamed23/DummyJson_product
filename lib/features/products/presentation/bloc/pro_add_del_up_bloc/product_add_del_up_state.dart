
import 'package:equatable/equatable.dart';

abstract class AddDeleteUpdateProductState extends Equatable {
  const AddDeleteUpdateProductState();

  @override
  List<Object> get props => [];
}

class AddDeleteUpdateProductInitial extends AddDeleteUpdateProductState {}

class LoadingAddDeleteUpdateProductState extends AddDeleteUpdateProductState {}

class ErrorAddDeleteUpdateProductState extends AddDeleteUpdateProductState {
  final String message;

  const ErrorAddDeleteUpdateProductState({required this.message});

  @override
  List<Object> get props => [message];
}

class MessageAddDeleteUpdateProductState extends AddDeleteUpdateProductState {
  final String message;

  const MessageAddDeleteUpdateProductState({required this.message});

  @override
  List<Object> get props => [message];
}