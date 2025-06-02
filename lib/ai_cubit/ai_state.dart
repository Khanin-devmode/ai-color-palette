import 'package:equatable/equatable.dart';

abstract class AiState extends Equatable {}

class AiInitial extends AiState {
  @override
  List<Object?> get props => [];
}

class AiLoading extends AiState {
  @override
  List<Object?> get props => [];
}

class AiLoaded extends AiState {
  AiLoaded({required this.message, this.colors});

  final String message;
  final List<int>? colors;

  @override
  List<Object?> get props => [message, colors];
}

class AiError extends AiState {
  AiError({required this.errorMessage});

  final String errorMessage;

  @override
  List<Object?> get props => [errorMessage];
}
