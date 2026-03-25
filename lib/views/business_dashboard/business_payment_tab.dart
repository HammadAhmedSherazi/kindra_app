import '../../export_all.dart';

/// Payment / Earning tab for business dashboard.
/// Shows Total Eco-Point, Pending Point, Earn this Month, info text, and Point History table.
/// Layout follows the same flow as Business Home tab and household (community) home tab.
class BusinessPaymentTab extends StatelessWidget {
  const BusinessPaymentTab({super.key});

  static const double _contentTopRatio = 0.25;

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = context.screenWidth * 0.05;
    final contentTop = communityDashboardStackContentTop(
      context,
      screenHeightFraction: _contentTopRatio,
    );

    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          CommunityDashboardHeader(
            subtitle: 'Business Dashboard',
            sectionTitle: 'Payment / Earning',
            height: 300,
            onLogout: () {},
            showNotificationIcon: true,
            onNotificationTap: () => AppRouter.push(const NotificationView()),
            showZoneLabel: false,
          ),
          Positioned(
            top: contentTop,
            left: 0,
            right: 0,
            bottom: 0,
            child: Column(
              children: [
                _buildEcoPointsSummaryCard(context),
                16.ph,
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.fromLTRB(
                      horizontalPadding,
                      0,
                      horizontalPadding,
                      24,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _buildInfoSection(context),
                        20.ph,
                        Text(
                          'Point History',
                          style: context.robotoFlexSemiBold(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                        12.ph,
                        _buildPointHistoryTable(context),
                        24.ph,
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEcoPointsSummaryCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: const Color(0xFF2D2D2D),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final cardWidth = constraints.maxWidth;
          final iconSize = (cardWidth * 0.42).clamp(120.0, 200.0);
          final offset = (cardWidth * 0.05).clamp(12.0, 24.0);
          return Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                right: -offset,
                top: -offset,
                child: Image.asset(
                  Assets.kindraCardIcon,
                  width: iconSize,
                ),
              ),
              Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Total Eco-Point row
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    Assets.environmentImpactIcon,
                    width: 44,
                    height: 44,
                    color: Colors.white,
                  ),
                  12.pw,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Total Eco-Point',
                          style: context.robotoFlexMedium(
                            fontSize: 14,
                            color: Colors.white70,
                          ),
                        ),
                        4.ph,
                        Text(
                          '7820',
                          style: context.robotoFlexBold(
                            fontSize: 28,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              16.ph,
              // Pending Point & Earn this Month row
              Row(
                children: [
                  Expanded(child: _buildPendingPointCard(context)),
                  12.pw,
                  Expanded(child: _buildEarnThisMonthCard(context)),
                ],
              ),
            ],
          ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildPendingPointCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Pending Point',
            style: context.robotoFlexSemiBold(
              fontSize: 13,
              color: Colors.white,
            ),
          ),
          4.ph,
          
          
        RichText(
          text: TextSpan(
            children: [
              TextSpan(text: '480', style: context.robotoFlexBold(fontSize: 22, color: Colors.white)),
              TextSpan(text: '  (under Verification)', style: context.robotoFlexRegular(fontSize: 11, color: Colors.white)),
            ],
          ),
        ),

          // 2.ph,
        ],
      ),
    );
  }

  Widget _buildEarnThisMonthCard(BuildContext context) {
    return Container(
      
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Color(0xff4A4A4A),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Earn this Month',
            style: context.robotoFlexSemiBold(
              fontSize: 13,
              color: Colors.white70,
            ),
          ),
          4.ph,
          Text(
            '760',
            style: context.robotoFlexBold(fontSize: 22, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Eco-point will be Credit after Verification.',
            style: context.robotoFlexRegular(fontSize: 16, color: Colors.black),
          ),
          8.ph,
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Text(
                'To request a payout, Please go to ',
                style: context.robotoFlexRegular(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              GestureDetector(
                onTap: () {
                  // TODO: Navigate to bank/payment processor
                },
                child: Text(
                  '(Insert bank or payment processor)',
                  style: context.robotoFlexRegular(
                    fontSize: 16,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPointHistoryTable(BuildContext context) {
    const rows = [
      _PointHistoryRow(
        id: '#512382',
        date: 'April 22, 2026',
        oilVolume: '420 Lt',
        pointsEarned: '210',
      ),
      _PointHistoryRow(
        id: '#512381',
        date: 'April 20, 2026',
        oilVolume: '380 Lt',
        pointsEarned: '190',
      ),
      _PointHistoryRow(
        id: '#512380',
        date: 'April 18, 2026',
        oilVolume: '410 Lt',
        pointsEarned: '205',
      ),
    ];

    return Container(
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
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          // Table header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 14),
            color: Color(0xffF3F4F6),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    'ID',
                    textAlign: TextAlign.center,
                    style: context.robotoFlexSemiBold(
                      fontSize: 13,
                      color: Colors.black87,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,

                  child: Text(
                    'Date',
                    textAlign: TextAlign.center,
                    style: context.robotoFlexSemiBold(
                      fontSize: 13,
                      color: Colors.black87,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'Oil Volume',
                    textAlign: TextAlign.center,
                    style: context.robotoFlexSemiBold(
                      fontSize: 13,
                      color: Colors.black87,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Points Earned',
                    textAlign: TextAlign.center,
                    style: context.robotoFlexSemiBold(
                      fontSize: 13,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
          ),
          ...rows.asMap().entries.map((entry) {
            final index = entry.key;
            final row = entry.value;
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
              decoration: BoxDecoration(
                border: index < rows.length - 1
                    ? Border(
                        bottom: BorderSide(
                          color: Color(0xffF3F4F6),
                          width: 1,
                        ),
                      )
                    : null,
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      row.id,
                      textAlign: TextAlign.center,
                      style: context.robotoFlexMedium(
                        fontSize: 13,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      row.date,
                      textAlign: TextAlign.center,
                      style: context.robotoFlexRegular(
                        fontSize: 13,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      row.oilVolume,
                      textAlign: TextAlign.center,
                      style: context.robotoFlexRegular(
                        fontSize: 13,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      row.pointsEarned,
                      textAlign: TextAlign.center,
                      style: context.robotoFlexRegular(
                        fontSize: 13,
                       
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _PointHistoryRow {
  const _PointHistoryRow({
    required this.id,
    required this.date,
    required this.oilVolume,
    required this.pointsEarned,
  });

  final String id;
  final String date;
  final String oilVolume;
  final String pointsEarned;
}
