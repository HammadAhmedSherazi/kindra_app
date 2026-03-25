import '../../export_all.dart';
import 'driver_pickup_flow/driver_pickup_flow_shared_widgets.dart';

/// Bank account summary and actions (add / edit / remove).
class DriverBankAccountView extends StatelessWidget {
  const DriverBankAccountView({super.key});

  static const double _bankCardBlockHeight = 148;
  static const double _belowBankCardGap = 14;

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = context.screenWidth * 0.05;
    final bankCardTop = communityDashboardStackContentTop(
      context,
      hasSubtitle: false,
    );
    final scrollBodyTop =
        bankCardTop + _bankCardBlockHeight + _belowBankCardGap;

    return Scaffold(
      backgroundColor: Colors.white,
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
              sectionTitle: 'Bank Account',
              height: kDriverProfileHeaderHeight,
              showZoneLabel: false,
              onLogout: () {},
              showNotificationIcon: true,
              showSideActionLabel: false,
              onNotificationTap: () => AppRouter.push(const NotificationView()),
            ),
          ),
          Positioned.fill(
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(
                horizontalPadding,
                scrollBodyTop,
                horizontalPadding,
                24,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _linkRow(
                    context,
                    leading: Icon(Icons.add, color: AppColors.primaryColor),
                    label: 'Add New Bank',
                    onTap: () {},
                  ),
                  12.ph,
                  _chevronRow(context, label: 'Edit Account', onTap: () {}),
                  12.ph,
                  _chevronRow(context, label: 'Remove Account', onTap: () {}),
                  32.ph,
                  CustomButtonWidget(
                    label: 'Save Changes',
                    onPressed: () => AppRouter.back(),
                    height: 56,
                    backgroundColor: AppColors.primaryColor,
                    textColor: Colors.white,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: bankCardTop,
            left: horizontalPadding,
            right: horizontalPadding,
            child: _iciciBankCard(context),
          ),
        ],
      ),
    );
  }

  Widget _iciciBankCard(BuildContext context) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'ICII Bank',
              style: context.robotoFlexBold(
                fontSize: 17,
                color: Colors.black,
              ),
            ),
            Divider(height: 20, color: Colors.grey.shade200),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '***********12345',
                        style: context.robotoFlexSemiBold(
                          fontSize: 15,
                          color: Colors.black87,
                        ),
                      ),
                      6.ph,
                      Text(
                        'Thomas Charlie',
                        style: context.robotoFlexRegular(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.chevron_right, color: Colors.grey.shade500),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _linkRow(
    BuildContext context, {
    required Widget leading,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            leading,
            12.pw,
            Text(
              label,
              style: context.robotoFlexSemiBold(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _chevronRow(
    BuildContext context, {
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
       
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        decoration: BoxDecoration(
           color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: context.robotoFlexSemiBold(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ),
            Icon(Icons.chevron_right, color: Colors.grey.shade500),
          ],
        ),
      ),
    );
  }
}
