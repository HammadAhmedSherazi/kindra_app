import '../../export_all.dart';
import 'driver_pickup_flow/driver_pickup_flow_shared_widgets.dart';

/// Edit driver profile: name, phone, vehicle; same header + avatar overlap as profile tab.
class DriverEditProfileView extends StatefulWidget {
  const DriverEditProfileView({super.key});

  @override
  State<DriverEditProfileView> createState() => _DriverEditProfileViewState();
}

class _DriverEditProfileViewState extends State<DriverEditProfileView> {
  final _nameController = TextEditingController(text: 'Thomas Charlie');
  final _phoneController = TextEditingController(text: '+91 98765 43210');
  final _vehicleController = TextEditingController(text: 'MH04 AB 1234');

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _vehicleController.dispose();
    super.dispose();
  }

  void _onSave() {
    showProfileUpdateSuccessDialog(
      context,
      onContinue: () => AppRouter.back(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = context.screenWidth * 0.05;
    final formTop =
        kDriverProfileHeaderHeight + kDriverProfileAvatarSize / 2 + 20;

    return Scaffold(
      backgroundColor: const Color(0xffF9FAFC),
      bottomNavigationBar: const DriverFlowBottomNavBar(currentIndex: 4),
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: CommunityDashboardHeader(
              subtitle: '',
              sectionTitle: 'Edit Profile',
              height: kDriverProfileHeaderHeight,
              showZoneLabel: false,
              onLogout: () {},
              showNotificationIcon: true,
              showSideActionLabel: false,
              onNotificationTap: () => AppRouter.push(const NotificationView()),
            ),
          ),
          DriverProfileOverlappingAvatar(
            onBadgeTap: () {},
          ),
          Positioned.fill(
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(
                horizontalPadding,
                formTop,
                horizontalPadding,
                24,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.06),
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        CustomTextFieldWidget(
                          controller: _nameController,
                          label: 'Name',
                          hint: 'Thomas Charlie',
                        ),
                        20.ph,
                        CustomTextFieldWidget(
                          controller: _phoneController,
                          label: 'Phone',
                          hint: '+91 98765 43210',
                          keyboardType: TextInputType.phone,
                        ),
                        20.ph,
                        CustomTextFieldWidget(
                          controller: _vehicleController,
                          label: 'Vehicle',
                          hint: 'MH04 AB 1234',
                        ),
                      ],
                    ),
                  ),
                  28.ph,
                  CustomButtonWidget(
                    label: 'Save Changes',
                    onPressed: _onSave,
                    height: 56,
                    backgroundColor: AppColors.primaryColor,
                    textColor: Colors.white,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
