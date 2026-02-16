import '../../export_all.dart';

/// Placeholder Profile tab for business dashboard.
class BusinessProfileTab extends StatelessWidget {
  const BusinessProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          CommunityDashboardHeader(
            subtitle: 'Business Dashboard',
            sectionTitle: 'Profile',
            onLogout: () {},
            showNotificationIcon: true,
            onNotificationTap: () {},
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Text(
                'Business profile settings',
                style: context.robotoFlexRegular(
                  fontSize: 16,
                  color: Colors.grey.shade600,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
