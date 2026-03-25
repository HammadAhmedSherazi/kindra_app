import '../../export_all.dart';

/// Home tab for business dashboard (third flow).
/// Matches design: Next Pickup, Active/Past/Payment tabs, Liters & Points cards,
/// Impact graph, Kindra Friendly QR, Eco-Tips & Education.
class BusinessHomeTab extends StatefulWidget {
  const BusinessHomeTab({super.key});

  @override
  State<BusinessHomeTab> createState() => _BusinessHomeTabState();
}

class _BusinessHomeTabState extends State<BusinessHomeTab>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = context.screenWidth * 0.05;
    final contentTop = communityDashboardStackContentTop(context);

    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          CommunityDashboardHeader(
            subtitle: 'Business Dashboard',
            onLogout: () {},
            showNotificationIcon: true,
            onNotificationTap: () => AppRouter.push(const NotificationView()),
          ),
          Positioned(
            top: contentTop,
            left: 0,
            right: 0,
            bottom: 0,
            child: Column(
              children: [
                _buildNextPickupCard(context),
                        16.ph,
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.fromLTRB(horizontalPadding, 0, horizontalPadding, 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        
                        _buildActivePastPaymentTabs(context),
                        16.ph,
                        _buildLitersAndPointsRow(context),
                        16.ph,
                        _buildImpactCard(context),
                        16.ph,
                        _buildNewPickupAndEcoTipsButtons(context),
                        16.ph,
                        _buildKindraFriendlyCard(context),
                        16.ph,
                        _buildEcoTipsEducationSection(context),
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

  Widget _buildNextPickupCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.symmetric(horizontal: 16),
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
            spacing: 10 ,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()..scaleByDouble(-1.0, 1.0, 1.0, 1.0),
                child: Image.asset(
                  Assets.deliverIcon,
                  height: 38,
                ),
              ),
              Expanded(child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                     Text(
            'Next Pickup',
            style: context.robotoFlexBold(fontSize: 22, color: Colors.black),
          ),
          8.ph,
          Text(
            'Thursday, April 18',
            style: context.robotoFlexSemiBold(fontSize: 14, color: Colors.black),
          ),
          4.ph,
          Text(
            '09:00 AM to 02:00 PM',
            style: context.robotoFlexRegular(fontSize: 12, color: Colors.black87),
          ),
          4.ph,
          Text(
            'Urban Store Pickup Point',
            style: context.robotoFlexRegular(fontSize: 12, color: Colors.black87),
          ),
          
                ],
              ),),
              GestureDetector(
                onTap: () {
                  AppRouter.push(
                    PickupScheduledDetailView(
                      date: DateTime(2025, 4, 18),
                      timeRange: '9:00 AM - 12:00 PM',
                      location: 'Urban Store Pickup Point',
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.horizontal(left: Radius.circular(20), right: Radius.circular(20)),
                  ),
                  child: Text(
                    'View Pickup Detail',
                    style: context.robotoFlexSemiBold(
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        
         16.ph,
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(
              height: 160,
              width: double.infinity,
              color: Colors.grey.shade200,
              child: Center(
                child: Icon(Icons.map_outlined, size: 48, color: Colors.grey.shade500),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivePastPaymentTabs(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          TabBar(
            controller: _tabController,
            labelColor: AppColors.primaryColor,
            unselectedLabelColor: Colors.grey.shade600,
            indicatorColor: AppColors.primaryColor,
            indicatorWeight: 3,
            labelStyle: context.robotoFlexSemiBold(fontSize: 14),
            unselectedLabelStyle: context.robotoFlexRegular(fontSize: 14),
            tabs: const [
              Tab(text: 'Active'),
              Tab(text: 'Past'),
              Tab(text: 'Payment'),
            ],
          ),
          SizedBox(
            height: 120,
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildTabPlaceholder('Active pickups list'),
                _buildTabPlaceholder('Past pickups list'),
                _buildTabPlaceholder('Payment history'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabPlaceholder(String text) {
    return Center(
      child: Text(
        text,
        style: TextStyle(
          fontSize: 14,
          color: Colors.grey.shade600,
          fontFamily: 'Roboto Flex',
        ),
      ),
    );
  }

  Widget _buildLitersAndPointsRow(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildMetricCard(
            context,
            icon: Assets.environmentImpactIcon,
            value: '528 Liters',
            subtitle: 'Last 90 Days',
          ),
        ),
        12.pw,
        Expanded(
          child: _buildMetricCard(
            context,
            icon: Assets.environmentImpactIcon,
            value: '5,200 Points',
            subtitle: 'Earned Eco-Points',
          ),
        ),
      ],
    );
  }

  Widget _buildMetricCard(
    BuildContext context, {
    required String icon,
    required String value,
    required String subtitle,
  }) {
    return Container(
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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 10,
        children: [
          Image.asset(
            icon,
            width: 40,
            height: 40,
            color: AppColors.primaryColor,
          ),
          
         Expanded(child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            Text(
            value,
            maxLines: 1,
            style: context.robotoFlexBold(fontSize: 20, color: Colors.black),
          ),
          
          Text(
            subtitle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: context.robotoFlexRegular(
              fontSize: 12,
              color: Colors.black87,
            ),
          ),
          ],
         ),),
        ],
      ),
    );
  }

  Widget _buildImpactCard(BuildContext context) {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'];
    const values1 = [350000.0, 400000.0, 380000.0, 450000.0, 420000.0, 500000.0];
    const values2 = [80000.0, 95000.0, 90000.0, 100000.0, 110000.0, 120000.0];
    return Container(
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Impact',
            style: context.robotoFlexSemiBold(fontSize: 18, color: Colors.black),
          ),
          20.ph,
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: BarChartWidget(
              labels: months,
              series: [
                BarChartSeries(
                  values: values1,
                  color: const Color(0xFFE5A842),
                ),
                BarChartSeries(
                  values: values2,
                  color: const Color(0xFF0A4D59),
                ),
              ],
              maxY: 500000,
              yTickCount: 5,
              barRadius: 6,
              barGap: 6,
              darkTheme: false,
              chartHeight: 220,
              yLabelFormat: (v) =>
                  v >= 1000 ? '${(v / 1000).toStringAsFixed(0)}K' : v.toStringAsFixed(0),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNewPickupAndEcoTipsButtons(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CustomButtonWidget(
          label: 'New Pickup',
          onPressed: () => AppRouter.push(const BusinessPickupScheduleView()),
        ),
        12.ph,
        CustomButtonWidget(
          label: 'View Eco-tips',
          onPressed: () => AppRouter.push(const EcoTipsEducationView()),
          backgroundColor: Colors.grey.shade300,
          textColor: Colors.black87,
          textSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ],
    );
  }

  Widget _buildKindraFriendlyCard(BuildContext context) {
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
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    Assets.kindraTextLogo,
                    height: 56,
                    fit: BoxFit.contain,
                  ),
                  12.ph,
                  Text(
                    'Kindra Friendly',
                    style: context.robotoFlexSemiBold(fontSize: 22, color: Colors.black),
                  ),
                  4.ph,
                  Text(
                    'Verified Partner',
                    style: context.robotoFlexSemiBold(fontSize: 16, color: Colors.black),
                  ),
                ],
              ),
            ),
            Icon(Icons.qr_code_2, size: 115, color: Colors.black),
          ],
        ),
      ),
    );
  }

  Widget _buildEcoTipsEducationSection(BuildContext context) {
    final tips = demoNewsList.take(3).toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                'Eco-Tips & Education',
                style: context.robotoFlexSemiBold(fontSize: 20, color: Colors.black),
              ),
            ),
            TextButton(
              onPressed: () => AppRouter.push(const AllNewsView()),
              child: Text(
                'See All',
                style: context.robotoFlexMedium(
                  fontSize: 16,
                  color: Colors.black.withValues(alpha: 0.60),
                ),
              ),
            ),
          ],
        ),
        8.ph,
        Text(
          'Explore Tips, videos & Challenges to make your business more eco-friendly.',
          style: context.robotoFlexRegular(
            fontSize: 16,
            color: Colors.black87,
          ),
        ),
        16.ph,
        ...tips.map(
          (news) => Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: NewsItemWidget(
              news: news,
              onTap: () => AppRouter.push(NewsDetailView(news: news)),
              showWatchVideo: true,
            ),
          ),
        ),
      ],
    );
  }
}
