import '../export_all.dart';

/// Reusable Kindra Friendly QR card. Used in community and business impact tabs.
/// Tapping navigates to [KindraFriendlyView].
class KindraFriendlyCard extends StatelessWidget {
  const KindraFriendlyCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => AppRouter.push(const KindraFriendlyView()),
      child: Container(
        padding: const EdgeInsets.all(20),
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
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        Assets.kindraTextLogo,
                        height: 60,
                        fit: BoxFit.contain,
                      ),
                      16.pw,
                      Text(
                        'Kindra Friendly',
                        style: context.robotoFlexSemiBold(
                          fontSize: 25,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.qr_code_2, size: 130, color: Colors.black),
              ],
            ),
            Text(
              'View, Share, and download your certified badge.',
              style: context.robotoFlexMedium(fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }
}
