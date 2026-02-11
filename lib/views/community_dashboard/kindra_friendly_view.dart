import '../../export_all.dart';

class KindraFriendlyView extends StatelessWidget {
  const KindraFriendlyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _buildHeader(context),
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: 20,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Image.asset(
                      Assets.logo,
                      width: 80,
                      height: 80,
                      fit: BoxFit.contain,
                    ),
                    16.ph,
                    Text(
                      'Kindra Friendly',
                      style: context.robotoFlexSemiBold(
                        fontSize: 22,
                        color: Colors.black,
                      ),
                    ),
                    12.ph,
                    Text(
                      'Certified for eco-friendly used cooking oil collection and recycling in your community.',
                      textAlign: TextAlign.center,
                      style: context.robotoFlexRegular(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),
                    24.ph,
                    Container(
                      width: 160,
                      height: 160,
                      color: Colors.grey.shade200,
                      child: const Center(
                        child: Icon(Icons.qr_code_2, size: 120, color: Colors.black54),
                      ),
                    ),
                    16.ph,
                    Text(
                      'Scan QR code to verify and share your Kindra certification.',
                      textAlign: TextAlign.center,
                      style: context.robotoFlexRegular(
                        fontSize: 13,
                        color: Colors.black54,
                      ),
                    ),
                    24.ph,
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.share_outlined, size: 20),
                            label: const Text('Share'),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.black87,
                              side: BorderSide(color: Colors.grey.shade400),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                            ),
                          ),
                        ),
                        16.pw,
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () {},
                            icon: SvgPicture.asset(
                              Assets.downloadIcon,
                              width: 20,
                              height: 20,
                              colorFilter: const ColorFilter.mode(
                                Colors.black87,
                                BlendMode.srcIn,
                              ),
                            ),
                            label: const Text('Download'),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.black87,
                              side: BorderSide(color: Colors.grey.shade400),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                            ),
                          ),
                        ),
                      ],
                    ),
                    24.ph,
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
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        top: MediaQuery.paddingOf(context).top + 8,
        left: 20,
        right: 20,
        bottom: 16,
      ),
      decoration: const BoxDecoration(color: AppColors.primaryColor),
      child: SafeArea(
        bottom: false,
        child: Row(
          children: [
            GestureDetector(
              onTap: () => AppRouter.back(),
              child: Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.arrow_back, color: AppColors.primaryColor),
              ),
            ),
            16.pw,
            Text(
              'Kindra Friendly',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontFamily: 'Roboto Flex',
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
