import '../export_all.dart';

/// Pickup request row card (Driver home preview + Requests tab list).
/// [onTap] runs for card tap and for Accept / Reject (same as detail entry).
class DriverPickupRequestCard extends StatelessWidget {
  const DriverPickupRequestCard({
    super.key,
    required this.data,
    required this.onTap,
  });

  final DriverPickupRequestData data;
  final VoidCallback onTap;

  static const Color _acceptBg = Color(0xff2F2F2F);
  static const Color _rejectBg = Color(0xffE85D3A);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    data.imageAsset,
                    width: 72,
                    height: 72,
                    fit: BoxFit.cover,
                  ),
                ),
                12.pw,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.locationName,
                        style: context.robotoFlexBold(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      6.ph,
                      Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            size: 14,
                            color: Colors.grey.shade600,
                          ),
                          4.pw,
                          Text(
                            data.areaName,
                            style: context.robotoFlexRegular(
                              fontSize: 12,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                      4.ph,
                      Row(
                        children: [
                          Icon(
                            Icons.access_time,
                            size: 14,
                            color: Colors.grey.shade600,
                          ),
                          4.pw,
                          Text(
                            data.timeSlot,
                            style: context.robotoFlexRegular(
                              fontSize: 12,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Text(
                  data.quantity,
                  style: context.robotoFlexSemiBold(
                    fontSize: 13,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
            12.ph,
            Row(
              children: [
                Expanded(
                  child: CustomButtonWidget(
                    label: 'Accept',
                    onPressed: onTap,
                    variant: CustomButtonVariant.secondary,
                    backgroundColor: _acceptBg,
                    height: 40,
                    expandWidth: false,
                  ),
                ),
                12.pw,
                Expanded(
                  child: CustomButtonWidget(
                    label: 'Reject',
                    onPressed: onTap,
                    variant: CustomButtonVariant.secondary,
                    backgroundColor: _rejectBg,
                    height: 40,
                    expandWidth: false,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
