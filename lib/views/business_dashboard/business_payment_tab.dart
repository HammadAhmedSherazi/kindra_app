import '../../export_all.dart';

/// Payment tab for business dashboard.
class BusinessPaymentTab extends StatelessWidget {
  const BusinessPaymentTab({super.key});

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
            sectionTitle: 'Payment',
            onLogout: () {},
            showNotificationIcon: true,
            onNotificationTap: () {},
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Text(
                'Payment history and methods',
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
