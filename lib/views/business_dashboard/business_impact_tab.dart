import '../../export_all.dart';

/// Placeholder Impact tab for business dashboard.
class BusinessImpactTab extends StatelessWidget {
  const BusinessImpactTab({super.key});

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
            sectionTitle: 'Impact',
            onLogout: () {},
            showNotificationIcon: true,
            onNotificationTap: () {},
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Text(
                'Impact overview for your business',
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
