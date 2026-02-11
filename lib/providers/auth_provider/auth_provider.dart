import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/network/api_response.dart';
import '../../data/network/api_endpoints.dart';
import '../../data/network/http_client.dart';
import 'auth_state.dart';

class AuthProvider extends Notifier<AuthState> {
  @override
  AuthState build() {
    return AuthState();
  }

  Future<void> login({
    required String email,
    required String password,
    String? userRole,
  }) async {
    state = state.copyWith(
        loginApiResponse: ApiResponse<dynamic>.loading());
    try {
      final body = <String, dynamic>{
        'email': email,
        'password': password,
      };
      if (userRole != null && userRole.isNotEmpty) {
        body['user_type'] = userRole;
      }
      final response = await MyHttpClient.instance.post(
        ApiEndpoints.login,
        body,
        isToken: false,
      );
      state = state.copyWith(
          loginApiResponse: ApiResponse<dynamic>.completed(response));
    } catch (e) {
      state = state.copyWith(
        loginApiResponse: ApiResponse<dynamic>.error()
          ..message = e.toString(),
      );
    }
  }

  void resetLoginState() {
    state = state.copyWith(
        loginApiResponse: ApiResponse<dynamic>.undertermined());
  }
}

final authProvider = NotifierProvider<AuthProvider, AuthState>(AuthProvider.new);
