import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/user_role_profile_provider.dart';
import '../services/firebase_auth_service.dart';
import '../viewmodels/user_edit_state.dart';
import '../models/user/user_base.dart';
import '../models/user/role_profiles.dart';

// NOTE: provider lives in `providers/user_role_profile_provider.dart`
// to avoid duplication across modules.

final userEditViewModelProvider =
    NotifierProvider.autoDispose<UserEditViewModel, UserEditState>(
        UserEditViewModel.new);

class UserEditViewModel extends AutoDisposeNotifier<UserEditState> {
  @override
  UserEditState build() => const UserEditState();

  Future<void> saveCommonProfile({
    required String displayName,
    required String phone,
    required String phoneDialCode,
    String? address,
    DateTime? dateOfBirth,
  }) async {
    state = state.copyWith(isSaving: true, errorMessage: null);
    try {
      await FirebaseAuthService.instance.updateCurrentUserProfile(
        displayName: displayName,
        phone: phone,
        phoneDialCode: phoneDialCode,
        address: address,
        dateOfBirth: dateOfBirth,
      );

      final base = state.userBase;
      if (base != null) {
        state = state.copyWith(
          userBase: base.copyWith(
            displayName: displayName.trim(),
            phone: phone.trim(),
            phoneDialCode: phoneDialCode,
            address: address?.trim(),
            dateOfBirth: dateOfBirth,
          ),
        );
      }
    } catch (e) {
      state = state.copyWith(
        errorMessage: FirebaseAuthService.messageForAuthException(e),
      );
    } finally {
      state = state.copyWith(isSaving: false);
    }
  }

  Future<void> saveRoleProfile(RoleProfile profile) async {
    state = state.copyWith(isSaving: true, errorMessage: null);
    try {
      final repo = ref.read(userRepositoryProvider);
      await repo.updateCurrentUserRoleProfile(profile);
    } catch (e) {
      state = state.copyWith(
        errorMessage: FirebaseAuthService.messageForAuthException(e),
      );
    } finally {
      state = state.copyWith(isSaving: false);
    }
  }

  void setUserBase(UserBase? base) {
    state = state.copyWith(userBase: base);
  }
}

