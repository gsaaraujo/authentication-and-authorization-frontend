enum SplashStatus {
  initial,
  loading,
  userAlreadySignedIn,
  userNotSignedIn,
  failed,
}

class SplashState {
  final SplashStatus status;
  final String errorMessage;

  SplashState({
    required this.status,
    this.errorMessage = '',
  });

  SplashState copyWith({SplashStatus? status, String? errorMessage}) {
    return SplashState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
