import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/user/role_profiles.dart';
import '../repositories/user_repository.dart';
import '../utils/enums.dart';

final userRepositoryProvider = Provider<UserRepository>((ref) {
  return UserRepository();
});

/// Streams role-specific profile doc at `users/{uid}/profiles/{role.name}`.
final currentUserRoleProfileProvider =
    StreamProvider.autoDispose.family<RoleProfile?, LoginUserRole>((ref, role) {
  final repo = ref.watch(userRepositoryProvider);
  return repo.watchCurrentUserRoleProfile(role);
});

