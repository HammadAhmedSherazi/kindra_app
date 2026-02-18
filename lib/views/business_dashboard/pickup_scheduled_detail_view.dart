import '../../export_all.dart';

/// New "Pickup Scheduled" success screen matching the design:
/// Green check, title, subtitle, card with Date/Time, Location, Status, green Back to Home.
class PickupScheduledDetailView extends StatelessWidget {
  const PickupScheduledDetailView({
    super.key,
    required this.date,
    required this.timeRange,
    this.location = 'Community Pickup Location',
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
            children: [
              const Spacer(flex: 2),
              CardWithOverlayWidget(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Pickup Scheduled',
                      textAlign: TextAlign.center,
                      style: context.robotoFlexBold(
                        fontSize: 24,
                        color: Colors.black,
                      ),
                    ),
                    8.ph,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Text(
                        'Your used cooking oil pickup has been scheduled.',
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
                            title: _formatDate(date),
                            subtitle: timeRange,
                          ),
                          Divider(height: 24, color: Colors.grey.shade300),
                          _detailRow(
                            context: context,
                            icon: Assets.locationIcon,
                            title: location,
                          ),
                          Divider(height: 24, color: Colors.grey.shade300),
                          _detailRow(
                            context: context,
                            icon: Assets.checkedIcon,
                            title: 'Status: Scheduled',
                            subtitle: "We'll notify you before the pickup time",
                            // iconColor: AppColors.primaryColor,
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
    Color? iconColor,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          icon,
          width: 28,
          height: 28,
          color: iconColor ?? Colors.black.withValues(alpha: 0.80),
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
                    color: Colors.grey.shade600,
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
