import '../../export_all.dart';

/// Success screen shown after pickup is scheduled.
/// Matches eco payment successful design pattern: success icon, title, info card,
/// and primary CTA button.
class PickupScheduledSuccessView extends StatelessWidget {
  const PickupScheduledSuccessView({
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
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ];
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return '${days[d.weekday - 1]}, ${months[d.month - 1]} ${d.day}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CardWithOverlayWidget(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // 24.ph,
                    Text(
                      'Pickup Scheduled',
                      textAlign: TextAlign.center,
                      style: context.robotoFlexBold(
                        fontSize: 22,
                        color: Colors.black,
                      ),
                    ),
                    12.ph,
                    Text(
                      'Your used cooking oil pickup has been scheduled.',
                      textAlign: TextAlign.center,
                      style: context.robotoFlexRegular(
                        fontSize: 15,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    32.ph,
                    // Info card - white bg with light grey border (eco success style)
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Column(
                        children: [
                          _detailRow(
                            context: context,
                            icon: Assets.nextPickupIcon,
                            title: _formatDate(date),
                            subtitle: timeRange,
                          ),
                          Divider(height: 24, color: Colors.grey.shade300),
                          _detailRow(
                            context: context,
                            icon: Assets.locationIcon,
                            title: location,
                            subtitle: null,
                          ),
                          Divider(height: 24, color: Colors.grey.shade300),
                          _detailRow(
                            context: context,
                            icon: Assets.checkedIcon,
                            title: 'Status: Scheduled',
                            subtitle: "We'll notify you before the pickup time",
                          ),
                        ],
                      ),
                    ),
              
                    
                  ],
                ),
              ),
              30.ph,
              // const Spacer(),
                    CustomButtonWidget(
                      label: 'Back to Home',
                      onPressed: () {
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (_) =>
                                const CommunityDashboardView(initialIndex: 0),
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
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(icon, width: 28, height: 28, color: Colors.black,),
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
