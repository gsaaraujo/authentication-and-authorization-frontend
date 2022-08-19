// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

enum HomeStatus {
  initial,
  loading,
  succeed,
  failed,
}

class HomeState extends Equatable {
  final HomeStatus status;
  final String errorMessage;

  const HomeState({
    required this.status,
    this.errorMessage = '',
  });

  HomeState copyWith({HomeStatus? status, String? errorMessage}) {
    return HomeState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, errorMessage];
}
