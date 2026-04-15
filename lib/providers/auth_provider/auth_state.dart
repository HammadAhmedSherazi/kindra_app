class AuthState {
  const AuthState({
    this.isLoggingIn = false,
    this.isSigningUp = false,
    this.isResettingPassword = false,
    this.needsEmailVerification = false,
    this.errorMessage,
  });

  final bool isLoggingIn;
  final bool isSigningUp;
  final bool isResettingPassword;
  final bool needsEmailVerification;
  final String? errorMessage;

  AuthState copyWith({
    bool? isLoggingIn,
    bool? isSigningUp,
    bool? isResettingPassword,
    bool? needsEmailVerification,
    String? errorMessage,
  }) {
    return AuthState(
      isLoggingIn: isLoggingIn ?? this.isLoggingIn,
      isSigningUp: isSigningUp ?? this.isSigningUp,
      isResettingPassword: isResettingPassword ?? this.isResettingPassword,
      needsEmailVerification:
          needsEmailVerification ?? this.needsEmailVerification,
      errorMessage: errorMessage,
    );
  }
}
