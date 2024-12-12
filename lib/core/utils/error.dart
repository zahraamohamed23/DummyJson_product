import 'package:equatable/equatable.dart';

//! Declare Exception types

class ServerException implements Exception {}

class EmptyCacheException implements Exception {}

class OfflineException implements Exception {}

//! Handle Errors

sealed class Failure extends Equatable {}

class OfflineFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class ServerFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class EmptyCacheFailure extends Failure {
  @override
  List<Object?> get props => [];
}


// Strings

const String sERVERFAILUREMESSAGE = 'Please try again later .';
const String eMPTYCACHEFAILUREMESSAGE = 'No Data';
const String oFFLINEFAILUREMESSAGE = 'Please Check your Internet Connection';