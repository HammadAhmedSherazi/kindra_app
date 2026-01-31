import '../../data/network/api_response.dart';

class AuthState {
  AuthState({ApiResponse<dynamic>? loginApiResponse})
      : loginApiResponse = loginApiResponse ?? ApiResponse<dynamic>.undertermined();

  final ApiResponse<dynamic> loginApiResponse;

  AuthState copyWith({ApiResponse<dynamic>? loginApiResponse}) {
    return AuthState(
      loginApiResponse: loginApiResponse ?? this.loginApiResponse,
    );
  }
}
