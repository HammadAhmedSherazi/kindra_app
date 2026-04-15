import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../services/firebase_auth_service.dart';
import '../../utils/helper.dart';
import '../../utils/router.dart';
import '../../utils/enums.dart';
import 'auth_state.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthProvider extends AutoDisposeNotifier<AuthState> {
  @override
  AuthState build() {
    return const AuthState();
  }

  Future<LoginUserRole?> login({
    required String email,
    required String password,
    required LoginUserRole selectedRole,
  }) async {
    state = state.copyWith(
      isLoggingIn: true,
      errorMessage: null,
      needsEmailVerification: false,
    );
    try {
      await FirebaseAuthService.instance.signIn(
        email: email.trim().toLowerCase(),
        password: password,
      );
      await FirebaseAuthService.instance.reloadCurrentUser();

      // First ensure Firestore user doc exists for this account.
      // If not, treat as "user not exist" for this app and do not route to verification.
      final role = await FirebaseAuthService.instance.fetchRoleForCurrentUser();
      if (role == null) {
        await FirebaseAuthService.instance.signOut();
        state = state.copyWith(errorMessage: 'User not exist');
        return null;
      }

      if (!FirebaseAuthService.instance.isEmailVerified) {
        state = state.copyWith(needsEmailVerification: true);
        return null;
      }

      if (role != selectedRole) {
        // Ensure we don't keep an authenticated session on mismatch.
        await FirebaseAuthService.instance.signOut();
        state = state.copyWith(errorMessage: 'Invalid credentials');
        return null;
      }

      await FirebaseAuthService.instance.recordSuccessfulLogin(selectedRole);
      return role;
    } catch (e) {
      // Ensure stale sessions don't cause wrong routing.
      await FirebaseAuthService.instance.signOut();
      final msg = FirebaseAuthService.messageForAuthException(e);
      state = state.copyWith(errorMessage: msg);
      final ctx = AppRouter.navKey.currentContext;
      if (ctx != null) {
        // ignore: use_build_context_synchronously
        Helper.showMessage(ctx, message: msg, backgroundColor: Colors.red);
      }
      return null;
    } finally {
      state = state.copyWith(isLoggingIn: false);
    }
  }

  Future<bool> signUp({
    required String email,
    required String password,
    required String displayName,
    required String phone,
    required String phoneDialCode,
    required LoginUserRole role,
    String? profileImagePath,
  }) async {
    state = state.copyWith(isSigningUp: true, errorMessage: null);
    try {
      await FirebaseAuthService.instance.signUp(
        email: email.trim().toLowerCase(),
        password: password,
        displayName: displayName,
        phone: phone,
        phoneDialCode: phoneDialCode,
        role: role,
        profileImagePath: profileImagePath,
      );
      return true;
    } catch (e) {
      // If Auth user already exists but Firestore profile was deleted,
      // allow "signup" as a recovery by signing in and recreating Firestore docs.
      if (e is FirebaseAuthException && e.code == 'email-already-in-use') {
        try {
          await FirebaseAuthService.instance.signIn(
            email: email.trim().toLowerCase(),
            password: password,
          );
          await FirebaseAuthService.instance.reloadCurrentUser();

          // If Firestore user doc is missing, recreate it.
          final existingRole =
              await FirebaseAuthService.instance.fetchRoleForCurrentUser();
          if (existingRole == null) {
            await FirebaseAuthService.instance.recreateFirestoreProfileForCurrentUser(
              displayName: displayName,
              phone: phone,
              phoneDialCode: phoneDialCode,
              role: role,
              profileImagePath: profileImagePath,
            );
            return true;
          }

          // If Firestore profile exists, treat as normal "already registered".
          await FirebaseAuthService.instance.signOut();
        } catch (_) {
          // fall through to show generic message below
        }
      }

      final msg = FirebaseAuthService.messageForAuthException(e);
      state = state.copyWith(errorMessage: msg);
      final ctx = AppRouter.navKey.currentContext;
      if (ctx != null) {
        // ignore: use_build_context_synchronously
        Helper.showMessage(ctx, message: msg, backgroundColor: Colors.red);
      }
      return false;
    } finally {
      state = state.copyWith(isSigningUp: false);
    }
  }

  Future<bool> sendPasswordReset(String email) async {
    state = state.copyWith(isResettingPassword: true, errorMessage: null);
    try {
      await FirebaseAuthService.instance
          .sendPasswordResetEmail(email.trim().toLowerCase());
      return true;
    } catch (e) {
      final msg = FirebaseAuthService.messageForAuthException(e);
      state = state.copyWith(errorMessage: msg);
      final ctx = AppRouter.navKey.currentContext;
      if (ctx != null) {
        // ignore: use_build_context_synchronously
        Helper.showMessage(ctx, message: msg, backgroundColor: Colors.red);
      }
      return false;
    } finally {
      state = state.copyWith(isResettingPassword: false);
    }
  }

  void clearError() {
    state = state.copyWith(errorMessage: null);
  }
}

final authProvider =
    NotifierProvider.autoDispose<AuthProvider, AuthState>(AuthProvider.new);
