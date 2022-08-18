// ignore_for_file: public_member_api_docs, sort_constructors_first
enum HomeStatus {
  initial,
  loading,
  succeed,
  failed,
}

class HomeState {
  final HomeStatus status;
  final String errorMessage;

  HomeState({
    required this.status,
    this.errorMessage = '',
  });

  HomeState copyWith({HomeStatus? status, String? errorMessage}) {
    return HomeState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
