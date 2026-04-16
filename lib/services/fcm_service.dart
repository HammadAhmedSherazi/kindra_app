import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';

/// Lightweight FCM helper: fetches current token + keeps it updated.
class FcmService {
  FcmService._();

  static final FcmService instance = FcmService._();

  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  StreamSubscription<String>? _tokenSub;

  /// Requests notification permission on iOS (safe no-op on Android).
  Future<void> ensurePermission() async {
    await _messaging.requestPermission();
  }

  Future<String?> getToken() => _messaging.getToken();

  /// Starts listening to token refresh and invokes [onToken] for each new token.
  /// Call [stopTokenListener] when no longer needed (e.g., on logout).
  void startTokenListener(void Function(String token) onToken) {
    _tokenSub?.cancel();
    _tokenSub = _messaging.onTokenRefresh.listen(onToken);
  }

  Future<void> stopTokenListener() async {
    await _tokenSub?.cancel();
    _tokenSub = null;
  }
}

