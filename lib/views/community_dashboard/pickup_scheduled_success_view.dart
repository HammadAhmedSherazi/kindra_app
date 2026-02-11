import '../../export_all.dart';

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
    const days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
    const months = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
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
            children: [
              48.ph,
              Container(
                width: 100,
                height: 100,
                decoration: const BoxDecoration(
                  color: AppColors.primaryColor,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check, color: Colors.white, size: 56),
              ),
              24.ph,
              Text(
                'Pickup Scheduled',
                style: context.robotoFlexSemiBold(fontSize: 24, color: Colors.black),
              ),
              12.ph,
              Text(
                'Your used cooking oil pickup has been scheduled.',
                textAlign: TextAlign.center,
                style: context.robotoFlexRegular(
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
              32.ph,
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    _detailRow(
                      icon: Icons.calendar_today_outlined,
                      title: _formatDate(date),
                      subtitle: timeRange,
                    ),
                    Divider(height: 24, color: Colors.grey.shade300),
                    _detailRow(
                      icon: Icons.location_on_outlined,
                      title: location,
                      subtitle: null,
                    ),
                    Divider(height: 24, color: Colors.grey.shade300),
                    _detailRow(
                      icon: Icons.check_circle_outline,
                      title: 'Status: Scheduled',
                      subtitle: "We'll notify you before the pickup time",
                    ),
                  ],
                ),
              ),
              const Spacer(),
              CustomButtonWidget(
                label: 'Back to Home',
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (_) => const CommunityDashboardView(initialIndex: 0),
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
    required IconData icon,
    required String title,
    String? subtitle,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 24, color: AppColors.primaryColor),
        16.pw,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Roboto Flex',
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              if (subtitle != null) ...[
                4.ph,
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Roboto Flex',
                    fontWeight: FontWeight.w400,
                    color: Colors.black54,
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
