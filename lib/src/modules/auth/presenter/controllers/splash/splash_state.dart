import 'package:equatable/equatable.dart';

enum SplashStatus {
  initial,
  loading,
  userAlreadySignedIn,
  userNotSignedIn,
  failed,
}

class SplashState extends Equatable {
  final SplashStatus status;
  final String errorMessage;

  const SplashState({
    required this.status,
    this.errorMessage = '',
  });

  SplashState copyWith({SplashStatus? status, String? errorMessage}) {
    return SplashState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, errorMessage];
}
