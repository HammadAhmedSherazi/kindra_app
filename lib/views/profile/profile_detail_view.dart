import '../../export_all.dart';

/// Display profile detail screen – separate from [ProfileView].
/// Shows avatar, name, email, personal info (phone, DOB, address) and Edit Profile action.
class ProfileDetailView extends StatelessWidget {
  const ProfileDetailView({super.key});

  static const String _demoName = 'Fajar Firmansyah';
  static const String _demoEmail = 'Fajar0123@gmail.com';
  static const String _demoPhone = '0123 456789';
  static const String _demoDob = '1, Dec, 2025';
  static const String _demoAddress = 'Abc Road, 123 Street, 12 City';

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
              _buildProfileCard(context),
              Positioned(
                top: -(context.screenHeight * 0.075).clamp(50.0, 80.0),
                left: 0,
                right: 0,
                child: _buildAvatarAndName(context),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProfileCard(BuildContext context) {
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
          _buildPersonalInfoSection(context),
          28.ph,
          _buildEditProfileButton(context),
        ],
      ),
    );
  }

  Widget _buildAvatarAndName(BuildContext context) {
    return Column(
      
      children: [
        Container(
          width: 122, height: 122,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: Image.asset(Assets.userAvatar, )),
        5.ph,
        Text(
          _demoName,
          style: context.robotoFlexSemiBold(fontSize: 20, color: Colors.black),
          textAlign: TextAlign.center,
        ),
        6.ph,
        Text(
          _demoEmail,
          style: context.robotoFlexRegular(
            fontSize: 14,
            color: AppColors.primaryTextColor.withValues(alpha: 0.85),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildPersonalInfoSection(BuildContext context) {
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
          value: _demoPhone,
        ),
        14.ph,
        _buildInfoRow(
          context,
          icon: Assets.calenderIcon,
          label: 'Date of Birth',
          value: _demoDob,
        ),
        14.ph,
        _buildInfoRow(
          context,
          icon: Assets.locationIcon,
          label: 'Address',
          value: _demoAddress,
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
