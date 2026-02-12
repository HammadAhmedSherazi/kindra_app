import '../../export_all.dart';

class KindraFriendlyView extends StatelessWidget {
  const KindraFriendlyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF9FAFC),
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Column(
            children: [
              // Green header (points_view style)
              Container(
                height: context.screenHeight * 0.27,
                width: double.infinity,
                padding: EdgeInsets.only(
                  top: MediaQuery.paddingOf(context).top + 16,
                  left: 20,
                  right: 20,
                  bottom: 24,
                ),
                decoration: const BoxDecoration(color: AppColors.primaryColor),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () => AppRouter.back(),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: ShapeDecoration(
                          shape: OvalBorder(
                            side: BorderSide(width: 1, color: Colors.white),
                          ),
                        ),
                        child: Icon(
                          Icons.arrow_back_ios_new,
                          size: 18,
                          color: const Color(0xffC2DDB9),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'Kindra Friendly',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontFamily: 'Roboto Flex',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(width: 40),
                  ],
                ),
              ),
              Expanded(child: SizedBox.shrink()),
            ],
          ),
          // Overlapping white card (points_view card style)
          Positioned(
            top: context.screenHeight * 0.14,
            left: 20,
            right: 20,
            bottom: 20,
            child: SingleChildScrollView(
              child: _KindraFriendlyCard(),
            ),
          ),
        ],
      ),
    );
  }
}

class _KindraFriendlyCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          20.ph,
          Image.asset(
            Assets.kindraLeaveIcon,
            width: 201,
            // height: 80,
            fit: BoxFit.contain,
          ),
          16.ph,
          Text(
            'Kindra Friendly',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 28,
              fontFamily: 'Roboto Flex',
              fontWeight: FontWeight.w700,
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
          // 24.ph,
          const Center(
            child: Icon(
              Icons.qr_code_2,
              size: 250,
              color: Colors.black87,
            ),
          ),
          // 16.ph,
          Text(
            'Scan QR code to verify and share your Kindra certification.',
            textAlign: TextAlign.center,
            style: context.robotoFlexRegular(
              fontSize: 13,
              color: Colors.black87,
            ),
          ),
          24.ph,
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.share_outlined, size: 24),
                  label:  Text('Share', style: context.robotoFlexSemiBold(fontSize: 18),),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.black87,
                    side: BorderSide(color: Colors.grey.shade400),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),
              16.pw,
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: SvgPicture.asset(
                    Assets.downloadIcon,
                    width: 24,
                    height: 24,
                    colorFilter: const ColorFilter.mode(
                      Colors.black87,
                      BlendMode.srcIn,
                    ),
                  ),
                  label: Text('Download', style: context.robotoFlexSemiBold(fontSize: 18),),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.black87,
                    side: BorderSide(color: Colors.grey.shade400),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),
            ],
          ),
          24.ph,
          SizedBox(
            width: double.infinity,
            child: CustomButtonWidget(
              label: 'Back to Home',
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (_) => const CommunityDashboardView(initialIndex: 0),
                  ),
                  (route) => false,
                );
              },
              textSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
