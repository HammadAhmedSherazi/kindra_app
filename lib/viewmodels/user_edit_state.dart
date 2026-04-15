import '../models/user/user_base.dart';

class UserEditState {
  const UserEditState({
    this.isSaving = false,
    this.errorMessage,
    this.userBase,
  });

  final bool isSaving;
  final String? errorMessage;
  final UserBase? userBase;

  UserEditState copyWith({
    bool? isSaving,
    String? errorMessage,
    UserBase? userBase,
  }) {
    return UserEditState(
      isSaving: isSaving ?? this.isSaving,
      errorMessage: errorMessage,
      userBase: userBase ?? this.userBase,
    );
  }
}

