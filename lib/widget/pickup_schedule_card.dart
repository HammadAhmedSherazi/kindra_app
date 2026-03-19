
import '../export_all.dart';

/// Reusable card for a single pickup schedule item in the business pickup list.
/// [Upcoming]: pass [timeRange] and statusText (e.g. "Scheduled. No Driver Assigned Yet").
/// [Past Pickup]: pass [quantity] and [points] for Completed/Rejected cards with colored icon.
class PickupScheduleCard extends StatelessWidget {
  const PickupScheduleCard({
    super.key,
    required this.date,
    required this.statusText,
    this.timeRange,
    this.quantity,
    this.points,
    this.onTap,
  });

  final String date;
  final String statusText;
  final String? timeRange;
  final String? quantity;
  final String? points;
  final VoidCallback? onTap;

  bool get _isPastPickup => quantity != null || points != null;

  @override
  Widget build(BuildContext context) {
    final isRejected = statusText == 'Rejected';
    final statusColor = isRejected ? Colors.red : AppColors.primaryColor;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
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
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              _isPastPickup ? Assets.trashCanIcon : Assets.dateIcon,
              width: 40,
              height: 40,
              color: _isPastPickup ? statusColor : AppColors.primaryColor,
            ),
            16.pw,
            Expanded(
              child: _isPastPickup ? _buildPastPickupContent(context, statusColor) : _buildUpcomingContent(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPastPickupContent(BuildContext context, Color statusColor) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Text(
            date,
            style: context.robotoFlexSemiBold(
              fontSize: 18,
              color: Colors.black,
            ),
          ),
          6.ph,
          Text(
            statusText,
            style: context.robotoFlexSemiBold(
              fontSize: 14,
              color: statusColor,
            ),
          ),
            ],
          ),
        ),
        Column(
          children: [
            if (quantity != null) ...[
          8.ph,
          Text(
            quantity!,
            style: context.robotoFlexRegular(
              fontSize: 16,
              color: Colors.black.withValues(alpha: 0.75),
            ),
          ),
        ],
        if (points != null) ...[
          4.ph,
          Text(
            points!,
            style: context.robotoFlexRegular(
              fontSize: 16,
              color: Colors.black.withValues(alpha: 0.75),
            ),
          ),
        ],
          ],
        )
       
        
      ],
    );
  }

  Widget _buildUpcomingContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          date,
          style: context.robotoFlexSemiBold(
            fontSize: 18,
            color: Colors.black,
          ),
        ),
        6.ph,
        if (timeRange != null)
          Text(
            timeRange!,
            style: context.robotoFlexRegular(
              fontSize: 16,
              color: Colors.black.withValues(alpha: 0.60),
            ),
          ),
        8.ph,
        Row(
          children: [
            Icon(
              Icons.schedule_outlined,
              size: 14,
              color: Colors.grey.shade600,
            ),
            6.pw,
            Expanded(
              child: Text(
                statusText,
                style: context.robotoFlexRegular(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
