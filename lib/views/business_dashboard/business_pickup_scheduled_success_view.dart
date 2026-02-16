import '../../export_all.dart';

/// Success screen for business pickup flow. "Back to Home" returns to [BusinessDashboardView].
class BusinessPickupScheduledSuccessView extends StatelessWidget {
  const BusinessPickupScheduledSuccessView({
    super.key,
    required this.date,
    required this.timeRange,
    this.location = 'Urban Bites Pickup Point',
  });

  final DateTime date;
  final String timeRange;
  final String location;

  static String _formatDate(DateTime d) {
    const days = [
      'Monday', 'Tuesday', 'Wednesday', 'Thursday',
      'Friday', 'Saturday', 'Sunday',
    ];
    const months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December',
    ];
    return '${days[d.weekday - 1]}, ${months[d.month - 1]} ${d.day}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF9FAFC),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 2),
              // Card with green check overlay and pickup details
              CardWithOverlayWidget(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Pickup Confirmed!',
                      textAlign: TextAlign.center,
                      style: context.robotoFlexBold(
                        fontSize: 24,
                        color: Colors.black,
                      ),
                    ),
                    8.ph,
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                      ),
                      child: Text(
                        'Your pickup has been scheduled successfully',
                        textAlign: TextAlign.center,
                        style: context.robotoFlexRegular(
                          fontSize: 15,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ),
                    24.ph,
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          _detailRow(
                            context: context,
                            icon: Assets.dateIcon,
                            title: location,
                            subtitle: '${_formatDate(date)}\n$timeRange',
                          ),
                          Divider(height: 24, color: Colors.grey.shade300),
                          _detailRow(
                            context: context,
                            icon: Assets.communityMemberIcon,
                            title: 'Driver Not Yet Assigned',
                            subtitle: "You'll be notified once a driver is assigned",
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(flex: 2),
              CustomButtonWidget(
                label: 'Back to Home',
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (_) =>
                          const BusinessDashboardView(initialIndex: 0),
                    ),
                    (route) => false,
                  );
                },
              ),
              32.ph,
            ],
          ),
        ),
      ),
    );
  }

  Widget _detailRow({
    required BuildContext context,
    required String icon,
    required String title,
    String? subtitle,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          icon,
          width: 28,
          height: 28,
          color: Colors.black.withValues(alpha: 0.80),
        ),
        16.pw,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: context.robotoFlexSemiBold(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              if (subtitle != null) ...[
                4.ph,
                Text(
                  subtitle,
                  style: context.robotoFlexRegular(
                    fontSize: 14,
                    // color: Colors.grey.shade600,
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
