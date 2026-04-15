import '../../export_all.dart';

/// Display profile detail screen – separate from [ProfileView].
/// Shows avatar, name, email, personal info (phone, DOB, address) and Edit Profile action.
class ProfileDetailView extends StatelessWidget {
  const ProfileDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomInnerScreenTemplate(
      title: 'Profile Details',
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Consumer(
                builder: (context, ref, _) {
                  final phoneDial = ref.watch(
                    currentUserProfileProvider.select(
                      (async) => async.maybeWhen(
                        data: (p) => p?.phoneDialCode ?? '',
                        orElse: () => '',
                      ),
                    ),
                  );
                  final phone = ref.watch(
                    currentUserProfileProvider.select(
                      (async) => async.maybeWhen(
                        data: (p) => p?.phone ?? '',
                        orElse: () => '',
                      ),
                    ),
                  );
                  final address = ref.watch(
                    currentUserProfileProvider.select(
                      (async) => async.maybeWhen(
                        data: (p) => p?.address ?? '',
                        orElse: () => '',
                      ),
                    ),
                  );
                  final dob = ref.watch(
                    currentUserProfileProvider.select(
                      (async) => async.maybeWhen(
                        data: (p) => p?.dateOfBirth,
                        orElse: () => null,
                      ),
                    ),
                  );
                  return _buildProfileCard(
                    context,
                    phoneDial: phoneDial,
                    phone: phone,
                    address: address,
                    dateOfBirth: dob,
                  );
                },
              ),
              Positioned(
                top: -(context.screenHeight * 0.075).clamp(50.0, 80.0),
                left: 0,
                right: 0,
                child: Consumer(
                  builder: (context, ref, _) {
                    final displayName = ref.watch(
                      currentUserProfileProvider.select((async) {
                        final fromFirestore = async.maybeWhen(
                          data: (p) => (p?.displayName.isNotEmpty == true)
                              ? p!.displayName
                              : null,
                          orElse: () => null,
                        );
                        if (fromFirestore != null &&
                            fromFirestore.trim().isNotEmpty) {
                          return fromFirestore;
                        }
                        final authName = FirebaseAuthService
                            .instance.currentUserDisplayName;
                        return (authName != null && authName.trim().isNotEmpty)
                            ? authName
                            : 'User';
                      }),
                    );
                    final email = ref.watch(
                      currentUserProfileProvider.select((async) {
                        final fromFirestore = async.maybeWhen(
                          data: (p) =>
                              (p?.email.isNotEmpty == true) ? p!.email : null,
                          orElse: () => null,
                        );
                        if (fromFirestore != null &&
                            fromFirestore.trim().isNotEmpty) {
                          return fromFirestore;
                        }
                        final authEmail =
                            FirebaseAuthService.instance.currentUserEmail;
                        return (authEmail != null && authEmail.trim().isNotEmpty)
                            ? authEmail
                            : '';
                      }),
                    );
                    final photoUrl = ref.watch(
                      currentUserProfileProvider.select(
                        (async) => async.maybeWhen(
                          data: (p) => p?.photoUrl ?? '',
                          orElse: () => '',
                        ),
                      ),
                    );
                    return _buildAvatarAndName(
                      context,
                      displayName: displayName,
                      email: email,
                      photoUrl: photoUrl,
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProfileCard(
    BuildContext context,
    {
    required String phoneDial,
    required String phone,
    required String address,
    required DateTime? dateOfBirth,
  }
  ) {
    final topPadding = (context.screenHeight * 0.06).clamp(44.0, 56.0);
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: EdgeInsets.fromLTRB(20, topPadding, 20, 24),
      decoration: ShapeDecoration(
        color: const Color(0xFFF9FAFC),
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1, color: const Color(0xFFD9D9D9)),
          borderRadius: BorderRadius.circular(23),
        ),
      ),
      child: Column(
        children: [
          (context.screenHeight * 0.14).clamp(100.0, 140.0).ph,
          _buildPersonalInfoSection(
            context,
            phoneDial: phoneDial,
            phone: phone,
            address: address,
            dateOfBirth: dateOfBirth,
          ),
          28.ph,
          _buildEditProfileButton(context),
        ],
      ),
    );
  }

  Widget _buildAvatarAndName(
    BuildContext context,
    {
    required String displayName,
    required String email,
    required String photoUrl,
  }
  ) {
    return Column(
      
      children: [
        Container(
          width: 122, height: 122,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: ClipOval(
            child: photoUrl.isNotEmpty
                ? Image.network(photoUrl, fit: BoxFit.cover)
                : Image.asset(Assets.userAvatar, fit: BoxFit.cover),
          ),
        ),
        5.ph,
        Text(
          displayName,
          style: context.robotoFlexSemiBold(fontSize: 20, color: Colors.black),
          textAlign: TextAlign.center,
        ),
        6.ph,
        Text(
          email,
          style: context.robotoFlexRegular(
            fontSize: 14,
            color: AppColors.primaryTextColor.withValues(alpha: 0.85),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildPersonalInfoSection(
    BuildContext context,
    {
    required String phoneDial,
    required String phone,
    required String address,
    required DateTime? dateOfBirth,
  }
  ) {
    final phoneDisplay =
        [phoneDial, phone].where((e) => e.trim().isNotEmpty).join(' ').trim();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Personal Info',
          style: context.robotoFlexSemiBold(fontSize: 16, color: Colors.black),
        ),
        16.ph,
        _buildInfoRow(
          context,
          icon: Assets.telephoneIcon,
          label: 'Phone No.',
          value: phoneDisplay.isNotEmpty ? phoneDisplay : '-',
        ),
        14.ph,
        _buildInfoRow(
          context,
          icon: Assets.calenderIcon,
          label: 'Date of Birth',
          value: dateOfBirth == null
              ? '-'
              : '${dateOfBirth.day.toString().padLeft(2, '0')}/${dateOfBirth.month.toString().padLeft(2, '0')}/${dateOfBirth.year}',
        ),
        14.ph,
        _buildInfoRow(
          context,
          icon: Assets.locationIcon,
          label: 'Address',
          value: address.trim().isNotEmpty ? address : '-',
          valueMaxLines: 2,
        ),
      ],
    );
  }

  Widget _buildInfoRow(
    BuildContext context, {
    required String icon,
    required String label,
    required String value,
    int valueMaxLines = 1,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: const Color(0xff3A3A3A).withValues(alpha: 0.25),
            ),
          ),
          alignment: Alignment.center,
          child: Image.asset(
            icon,
            width: 22,
            height: 22,
            color: const Color(0xff3A3A3A),
            colorBlendMode: BlendMode.srcIn,
          ),
        ),
        14.pw,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: context.robotoFlexRegular(
                  fontSize: 14,
                  color: AppColors.primaryTextColor,
                ),
              ),
              4.ph,
              Text(
                value,
                maxLines: valueMaxLines,
                overflow: TextOverflow.ellipsis,
                style: context.robotoFlexSemiBold(
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildEditProfileButton(BuildContext context) {
    return CustomButtonWidget(
      label: 'Edit Profile',
      onPressed: () => AppRouter.push(const EditProfileView()),
      backgroundColor: AppColors.primaryColor,
      textColor: Colors.white,
      textSize: 16,
    );
  }
}
