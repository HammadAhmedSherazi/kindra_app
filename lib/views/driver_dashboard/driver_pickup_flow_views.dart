import 'dart:math';

import '../../export_all.dart';

/// Driver pickup flow screens based on the provided UI images.
///
/// Flow:
/// 1) Start Navigation (map placeholder) -> Mark as Arrived
/// 2) Arrival Confirmed -> Start Collection
/// 3) Enter Collected Quantity -> Upload Photos
/// 4) Upload Photos -> Pickup Completed
/// 5) Pickup Completed -> Calculating payment -> Processing payment -> Earnings Updated

class DriverStartNavigationView extends StatelessWidget {
  const DriverStartNavigationView({super.key, required this.data});

  final DriverPickupRequestData data;

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = context.screenWidth * 0.05;
    final contentTop = context.screenHeight * 0.22;

    return Scaffold(
      backgroundColor: const Color(0xffF9FAFC),
      bottomNavigationBar: _DriverFlowBottomNavBar(currentIndex: 1),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            CommunityDashboardHeader(
              subtitle: 'Driver',
              sectionTitle: '',
              showZoneLabel: false,
              onLogout: () {},
              showNotificationIcon: true,
              onNotificationTap: () => AppRouter.push(const NotificationView()),
              height: 230,
            ),
            Positioned(
              top: contentTop,
              left: 0,
              right: 0,
              bottom: 0,
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(horizontalPadding, 16, horizontalPadding, 120),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _PickupRequestSummaryCard(data: data),
                    16.ph,
                    _RouteMapPlaceholder(data: data),
                    24.ph,
                    CustomButtonWidget(
                      label: 'Mark as Arrived',
                      onPressed: () {
                        AppRouter.push(
                          DriverArrivalConfirmedView(
                            data: data,
                            arrivalTime: '9:52 AM',
                          ),
                        );
                      },
                      height: 58,
                      backgroundColor: AppColors.primaryColor,
                      textColor: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.paddingOf(context).top + 8,
              left: 12,
              child: GestureDetector(
                onTap: () => AppRouter.back(),
                child: const Padding(
                  padding: EdgeInsets.all(8),
                  child: Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 22),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DriverArrivalConfirmedView extends StatelessWidget {
  const DriverArrivalConfirmedView({
    super.key,
    required this.data,
    required this.arrivalTime,
  });

  final DriverPickupRequestData data;
  final String arrivalTime;

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = context.screenWidth * 0.05;
    final contentTop = context.screenHeight * 0.20;

    return Scaffold(
      backgroundColor: const Color(0xffF9FAFC),
      bottomNavigationBar: _DriverFlowBottomNavBar(currentIndex: 1),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            CommunityDashboardHeader(
              subtitle: 'Driver',
              sectionTitle: '',
              showZoneLabel: false,
              onLogout: () {},
              showNotificationIcon: true,
              onNotificationTap: () => AppRouter.push(const NotificationView()),
              height: 230,
            ),
            Positioned(
              top: contentTop,
              left: 0,
              right: 0,
              bottom: 0,
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(horizontalPadding, 8, horizontalPadding, 120),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _ArrivalGraphic(),
                    14.ph,
                    Text(
                      'Arrival Confirmed',
                      style: context.robotoFlexBold(fontSize: 26, color: Colors.black),
                      textAlign: TextAlign.center,
                    ),
                    8.ph,
                    Text(
                      'You have arrived at the pickup location',
                      style: context.robotoFlexRegular(fontSize: 14, color: Colors.black.withValues(alpha: 0.7)),
                      textAlign: TextAlign.center,
                    ),
                    20.ph,
                    Text(
                      'Arrived at $arrivalTime',
                      style: context.robotoFlexMedium(fontSize: 16, color: AppColors.primaryColor),
                      textAlign: TextAlign.center,
                    ),
                    18.ph,
                    _PickupLocationCard(data: data),
                    20.ph,
                    CustomButtonWidget(
                      label: 'Start Collection',
                      onPressed: () {
                        AppRouter.push(
                          DriverEnterCollectedQuantityView(
                            data: data,
                            arrivalTime: arrivalTime,
                          ),
                        );
                      },
                      height: 58,
                      backgroundColor: AppColors.primaryColor,
                      textColor: Colors.white,
                    ),
                    12.ph,
                    CustomButtonWidget(
                      label: 'Report Issue',
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Issue reported. We will get back to you shortly.')),
                        );
                      },
                      height: 58,
                      backgroundColor: const Color(0xff2F2F2F),
                      textColor: Colors.white,
                      variant: CustomButtonVariant.secondary,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.paddingOf(context).top + 8,
              left: 12,
              child: GestureDetector(
                onTap: () => AppRouter.back(),
                child: const Padding(
                  padding: EdgeInsets.all(8),
                  child: Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 22),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DriverEnterCollectedQuantityView extends StatefulWidget {
  const DriverEnterCollectedQuantityView({
    super.key,
    required this.data,
    required this.arrivalTime,
  });

  final DriverPickupRequestData data;
  final String arrivalTime;

  @override
  State<DriverEnterCollectedQuantityView> createState() =>
      _DriverEnterCollectedQuantityViewState();
}

class _DriverEnterCollectedQuantityViewState
    extends State<DriverEnterCollectedQuantityView> {
  double _liters = 0;
  bool _confirmed = false;

  void _addLiters(double add) {
    setState(() {
      _liters += add;
      _confirmed = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = context.screenWidth * 0.05;
    final contentTop = context.screenHeight * 0.20;

    final litersLabel = _liters == _liters.roundToDouble()
        ? _liters.round().toString()
        : _liters.toStringAsFixed(1);

    return Scaffold(
      backgroundColor: const Color(0xffF9FAFC),
      bottomNavigationBar: _DriverFlowBottomNavBar(currentIndex: 1),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            CommunityDashboardHeader(
              subtitle: 'Driver',
              sectionTitle: '',
              showZoneLabel: false,
              onLogout: () {},
              showNotificationIcon: true,
              onNotificationTap: () => AppRouter.push(const NotificationView()),
              height: 230,
            ),
            Positioned(
              top: contentTop,
              left: 0,
              right: 0,
              bottom: 0,
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(horizontalPadding, 8, horizontalPadding, 120),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Enter Collected Quantity',
                      style: context.robotoFlexBold(fontSize: 26, color: Colors.black),
                      textAlign: TextAlign.left,
                    ),
                    18.ph,
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
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
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            '${litersLabel} Liters',
                            style: context.robotoFlexBold(fontSize: 52, color: Colors.black.withValues(alpha: 0.35)),
                            textAlign: TextAlign.center,
                          ),
                          6.ph,
                          Text(
                            'Enter Collected use cooking oil amount',
                            style: context.robotoFlexRegular(fontSize: 14, color: Colors.black.withValues(alpha: 0.6)),
                            textAlign: TextAlign.center,
                          ),
                          20.ph,
                          Wrap(
                            spacing: 12,
                            runSpacing: 12,
                            alignment: WrapAlignment.center,
                            children: [
                              _QuickAddButton(label: '+10L', onTap: () => _addLiters(10)),
                              _QuickAddButton(label: '+25L', onTap: () => _addLiters(25)),
                              _QuickAddButton(label: '+50L', onTap: () => _addLiters(50)),
                              _QuickAddButton(label: '+100L', onTap: () => _addLiters(100)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    20.ph,
                    CustomButtonWidget(
                      label: 'Confirm',
                      onPressed: () {
                        if (_liters <= 0) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Please enter collected quantity first.')),
                          );
                          return;
                        }
                        setState(() => _confirmed = true);
                      },
                      height: 58,
                      backgroundColor: AppColors.primaryColor,
                      textColor: Colors.white,
                    ),
                    12.ph,
                    CustomButtonWidget(
                      label: 'Upload Photo',
                      onPressed: () {
                        if (_liters <= 0) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Please enter collected quantity first.')),
                          );
                          return;
                        }
                        if (!_confirmed) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Please confirm quantity before uploading photos.')),
                          );
                          return;
                        }
                        AppRouter.push(
                          DriverUploadPhotosView(
                            data: widget.data,
                            arrivalTime: widget.arrivalTime,
                            collectedLiters: _liters,
                          ),
                        );
                      },
                      height: 58,
                      backgroundColor: const Color(0xff2F2F2F),
                      textColor: Colors.white,
                      variant: CustomButtonVariant.secondary,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.paddingOf(context).top + 8,
              left: 12,
              child: GestureDetector(
                onTap: () => AppRouter.back(),
                child: const Padding(
                  padding: EdgeInsets.all(8),
                  child: Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 22),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _QuickAddButton extends StatelessWidget {
  const _QuickAddButton({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          side: BorderSide(color: Colors.grey.shade300),
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        onPressed: onTap,
        child: Text(
          label,
          style: context.robotoFlexSemiBold(fontSize: 14, color: Colors.black),
        ),
      ),
    );
  }
}

class DriverUploadPhotosView extends StatefulWidget {
  const DriverUploadPhotosView({
    super.key,
    required this.data,
    required this.arrivalTime,
    required this.collectedLiters,
  });

  final DriverPickupRequestData data;
  final String arrivalTime;
  final double collectedLiters;

  @override
  State<DriverUploadPhotosView> createState() =>
      _DriverUploadPhotosViewState();
}

class _DriverUploadPhotosViewState extends State<DriverUploadPhotosView> {
  @override
  Widget build(BuildContext context) {
    final horizontalPadding = context.screenWidth * 0.05;
    final contentTop = context.screenHeight * 0.20;

    return Scaffold(
      backgroundColor: const Color(0xffF9FAFC),
      bottomNavigationBar: _DriverFlowBottomNavBar(currentIndex: 1),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            CommunityDashboardHeader(
              subtitle: 'Driver',
              sectionTitle: '',
              showZoneLabel: false,
              onLogout: () {},
              showNotificationIcon: true,
              onNotificationTap: () => AppRouter.push(const NotificationView()),
              height: 230,
            ),
            Positioned(
              top: contentTop,
              left: 0,
              right: 0,
              bottom: 0,
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(horizontalPadding, 8, horizontalPadding, 120),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Upload Photos',
                      style: context.robotoFlexBold(fontSize: 26, color: Colors.black),
                    ),
                    8.ph,
                    Text(
                      'Please upload proof of collected quantity',
                      style: context.robotoFlexRegular(fontSize: 14, color: Colors.black.withValues(alpha: 0.7)),
                    ),
                    18.ph,
                    _PhotosGrid(
                      onAdd: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Add photo placeholder (integration pending).')),
                        );
                      },
                    ),
                    24.ph,
                    CustomButtonWidget(
                      label: 'Continue',
                      onPressed: () {
                        AppRouter.push(
                          DriverPickupCompletedView(
                            data: widget.data,
                            arrivalTime: widget.arrivalTime,
                            collectedLiters: widget.collectedLiters,
                          ),
                        );
                      },
                      height: 58,
                      backgroundColor: AppColors.primaryColor,
                      textColor: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.paddingOf(context).top + 8,
              left: 12,
              child: GestureDetector(
                onTap: () => AppRouter.back(),
                child: const Padding(
                  padding: EdgeInsets.all(8),
                  child: Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 22),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PhotosGrid extends StatelessWidget {
  const _PhotosGrid({required this.onAdd});

  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    const crossAxisCount = 3;

    final items = [
      Assets.usedOilHandover,
      Assets.usedCookingOilCard,
      null, // add tile
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        mainAxisSpacing: 14,
        crossAxisSpacing: 14,
        childAspectRatio: 1,
      ),
      itemBuilder: (context, index) {
        final asset = items[index];
        final isAddTile = asset == null;

        return InkWell(
          onTap: isAddTile ? onAdd : () {},
          borderRadius: BorderRadius.circular(14),
          child: Container(
            decoration: BoxDecoration(
              color: isAddTile ? AppColors.primaryColor : Colors.transparent,
              borderRadius: BorderRadius.circular(14),
              boxShadow: isAddTile
                  ? null
                  : [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.06),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
            ),
            child: isAddTile
                ? const Center(
                    child: Icon(Icons.add, size: 30, color: Colors.white),
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: Image.asset(
                      asset,
                      fit: BoxFit.cover,
                    ),
                  ),
          ),
        );
      },
    );
  }
}

class DriverPickupCompletedView extends StatelessWidget {
  const DriverPickupCompletedView({
    super.key,
    required this.data,
    required this.arrivalTime,
    required this.collectedLiters,
  });

  final DriverPickupRequestData data;
  final String arrivalTime;
  final double collectedLiters;

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = context.screenWidth * 0.05;
    final contentTop = context.screenHeight * 0.20;

    final litersLabel = collectedLiters == collectedLiters.roundToDouble()
        ? collectedLiters.round().toString()
        : collectedLiters.toStringAsFixed(1);

    final earnings = _calculateEarnings(collectedLiters);

    return Scaffold(
      backgroundColor: const Color(0xffF9FAFC),
      bottomNavigationBar: _DriverFlowBottomNavBar(currentIndex: 1),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            CommunityDashboardHeader(
              subtitle: 'Driver',
              sectionTitle: '',
              showZoneLabel: false,
              onLogout: () {},
              showNotificationIcon: true,
              onNotificationTap: () => AppRouter.push(const NotificationView()),
              height: 230,
            ),
            Positioned(
              top: contentTop,
              left: 0,
              right: 0,
              bottom: 0,
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(horizontalPadding, 8, horizontalPadding, 120),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _SuccessBubblesCheckGraphic(),
                    16.ph,
                    Text(
                      'Pickup Completed!',
                      style: context.robotoFlexBold(fontSize: 26, color: Colors.black),
                      textAlign: TextAlign.center,
                    ),
                    16.ph,
                    Container(
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
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _LabelValueRow(
                            label: 'Arrival Time',
                            value: arrivalTime,
                          ),
                          12.ph,
                          Text(
                            'Collected',
                            style: context.robotoFlexSemiBold(fontSize: 14, color: Colors.grey.shade700),
                          ),
                          10.ph,
                          Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.asset(
                                  data.imageAsset,
                                  width: 56,
                                  height: 56,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              12.pw,
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${litersLabel} Liters',
                                      style: context.robotoFlexBold(fontSize: 18, color: Colors.black),
                                    ),
                                    2.ph,
                                    Text(
                                      'Used Cooking Oil',
                                      style: context.robotoFlexRegular(fontSize: 13, color: Colors.grey.shade600),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          18.ph,
                          Text(
                            'Business',
                            style: context.robotoFlexSemiBold(fontSize: 14, color: Colors.grey.shade700),
                          ),
                          10.ph,
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade50,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.asset(
                                    data.imageAsset,
                                    width: 56,
                                    height: 56,
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
                                        style: context.robotoFlexBold(fontSize: 16, color: Colors.black),
                                      ),
                                      4.ph,
                                      Row(
                                        children: [
                                          const Icon(Icons.location_on_outlined, size: 14, color: Colors.grey),
                                          4.pw,
                                          Expanded(
                                            child: Text(
                                              data.areaName,
                                              style: context.robotoFlexRegular(fontSize: 13, color: Colors.grey.shade600),
                                            ),
                                          ),
                                        ],
                                      ),
                                      4.ph,
                                      Text(
                                        data.fullAddress,
                                        style: context.robotoFlexRegular(fontSize: 12, color: Colors.grey.shade600),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          18.ph,
                          CustomButtonWidget(
                            label: 'Done',
                            onPressed: () {
                              AppRouter.push(const DriverCalculatingPaymentView());
                            },
                            height: 54,
                            backgroundColor: AppColors.primaryColor,
                            textColor: Colors.white,
                          ),
                        ],
                      ),
                    ),
                    6.ph,
                    // Keep for debugging / future integration:
                    // Text('Earnings: \$${earnings.toStringAsFixed(2)}', style: context.robotoFlexRegular(fontSize: 12, color: Colors.red)),
                  ],
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.paddingOf(context).top + 8,
              left: 12,
              child: GestureDetector(
                onTap: () => AppRouter.back(),
                child: const Padding(
                  padding: EdgeInsets.all(8),
                  child: Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 22),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  double _calculateEarnings(double liters) {
    // Matches screenshot example: 325 L -> $185.75
    const baseLiters = 325.0;
    const baseEarnings = 185.75;
    if (baseLiters <= 0) return 0;
    return (liters / baseLiters) * baseEarnings;
  }
}

class DriverCalculatingPaymentView extends StatefulWidget {
  const DriverCalculatingPaymentView({super.key});

  @override
  State<DriverCalculatingPaymentView> createState() => _DriverCalculatingPaymentViewState();
}

class _DriverCalculatingPaymentViewState extends State<DriverCalculatingPaymentView> {
  @override
  void initState() {
    super.initState();
    Future<void>.delayed(const Duration(seconds: 2)).then((_) {
      if (!mounted) return;
      AppRouter.push(const DriverProcessingPaymentView());
    });
  }

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = context.screenWidth * 0.05;
    final contentTop = context.screenHeight * 0.20;

    return Scaffold(
      backgroundColor: const Color(0xffF9FAFC),
      bottomNavigationBar: _DriverFlowBottomNavBar(currentIndex: 1),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            CommunityDashboardHeader(
              subtitle: 'Driver',
              sectionTitle: '',
              showZoneLabel: false,
              onLogout: () {},
              showNotificationIcon: true,
              onNotificationTap: () => AppRouter.push(const NotificationView()),
              height: 230,
            ),
            Positioned(
              top: contentTop,
              left: 0,
              right: 0,
              bottom: 0,
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(horizontalPadding, 8, horizontalPadding, 120),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Calculating payment...',
                      style: context.robotoFlexBold(fontSize: 26, color: Colors.black),
                    ),
                    18.ph,
                    _PaymentProcessingCard(
                      title: 'Processing payment...',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DriverProcessingPaymentView extends StatefulWidget {
  const DriverProcessingPaymentView({super.key});

  @override
  State<DriverProcessingPaymentView> createState() => _DriverProcessingPaymentViewState();
}

class _DriverProcessingPaymentViewState extends State<DriverProcessingPaymentView> {
  @override
  void initState() {
    super.initState();
    Future<void>.delayed(const Duration(seconds: 2)).then((_) {
      if (!mounted) return;
      AppRouter.push(const DriverEarningsUpdatedView());
    });
  }

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = context.screenWidth * 0.05;
    final contentTop = context.screenHeight * 0.20;

    return Scaffold(
      backgroundColor: const Color(0xffF9FAFC),
      bottomNavigationBar: _DriverFlowBottomNavBar(currentIndex: 1),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            CommunityDashboardHeader(
              subtitle: 'Driver',
              sectionTitle: '',
              showZoneLabel: false,
              onLogout: () {},
              showNotificationIcon: true,
              onNotificationTap: () => AppRouter.push(const NotificationView()),
              height: 230,
            ),
            Positioned(
              top: contentTop,
              left: 0,
              right: 0,
              bottom: 0,
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(horizontalPadding, 8, horizontalPadding, 120),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Processing payment...',
                      style: context.robotoFlexBold(fontSize: 26, color: Colors.black),
                    ),
                    18.ph,
                    _PaymentProcessingCard(
                      title: 'Processing payment...',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DriverEarningsUpdatedView extends StatelessWidget {
  const DriverEarningsUpdatedView({super.key});

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = context.screenWidth * 0.05;
    final contentTop = context.screenHeight * 0.18;

    return Scaffold(
      backgroundColor: const Color(0xffF9FAFC),
      bottomNavigationBar: _DriverFlowBottomNavBar(currentIndex: 1),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            CommunityDashboardHeader(
              subtitle: 'Driver',
              sectionTitle: '',
              showZoneLabel: false,
              onLogout: () {},
              showNotificationIcon: true,
              onNotificationTap: () => AppRouter.push(const NotificationView()),
              height: 230,
            ),
            Positioned(
              top: contentTop,
              left: 0,
              right: 0,
              bottom: 0,
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(horizontalPadding, 8, horizontalPadding, 120),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Pickup Completed!',
                      style: context.robotoFlexBold(fontSize: 26, color: Colors.black),
                    ),
                    14.ph,
                    _EarningsCard(
                      amountEarnedText: '\$185.75',
                      locationTitle: 'Mapco Gas station',
                      locationSubtitle: 'Arcata East',
                      timeText: 'Today - 9:52 AM',
                    ),
                    18.ph,
                    CustomButtonWidget(
                      label: 'View Wallet',
                      onPressed: () {
                        AppRouter.pushAndRemoveUntil(const DriverDashboardView(initialIndex: 2));
                      },
                      height: 58,
                      backgroundColor: AppColors.primaryColor,
                      textColor: Colors.white,
                    ),
                    12.ph,
                    CustomButtonWidget(
                      label: 'Back to Dashboard',
                      onPressed: () {
                        AppRouter.pushAndRemoveUntil(const DriverDashboardView(initialIndex: 1));
                      },
                      height: 58,
                      backgroundColor: const Color(0xff2F2F2F),
                      textColor: Colors.white,
                      variant: CustomButtonVariant.secondary,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EarningsCard extends StatelessWidget {
  const _EarningsCard({
    required this.amountEarnedText,
    required this.locationTitle,
    required this.locationSubtitle,
    required this.timeText,
  });

  final String amountEarnedText;
  final String locationTitle;
  final String locationSubtitle;
  final String timeText;

  @override
  Widget build(BuildContext context) {
    return Container(
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
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _SuccessBubblesCheckGraphic(small: true),
          12.ph,
          Text(
            'Earnings Updated!',
            style: context.robotoFlexBold(fontSize: 22, color: Colors.black),
            textAlign: TextAlign.center,
          ),
          16.ph,
          Text(
            'Amount Earned: $amountEarnedText',
            style: context.robotoFlexBold(fontSize: 24, color: AppColors.primaryColor),
            textAlign: TextAlign.center,
          ),
          16.ph,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.location_on_outlined, color: AppColors.primaryColor, size: 22),
              10.pw,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      locationTitle,
                      style: context.robotoFlexSemiBold(fontSize: 14, color: Colors.black),
                    ),
                    4.ph,
                    Text(
                      locationSubtitle,
                      style: context.robotoFlexRegular(fontSize: 13, color: Colors.grey.shade600),
                    ),
                    6.ph,
                    Text(
                      timeText,
                      style: context.robotoFlexRegular(fontSize: 13, color: Colors.grey.shade600),
                    ),
                  ],
                ),
              ),
            ],
          ),
          20.ph,
          Text(
            'Added to wallet Successfully!',
            style: context.robotoFlexMedium(fontSize: 16, color: AppColors.primaryColor),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _PaymentProcessingCard extends StatelessWidget {
  const _PaymentProcessingCard({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
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
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: const BoxDecoration(
              color: AppColors.primaryColor,
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: SizedBox(
                width: 60,
                height: 60,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  strokeWidth: 6,
                ),
              ),
            ),
          ),
          18.ph,
          Text(
            title,
            style: context.robotoFlexBold(fontSize: 22, color: Colors.black),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}

class _SuccessBubblesCheckGraphic extends StatelessWidget {
  const _SuccessBubblesCheckGraphic({this.small = false});

  final bool small;

  @override
  Widget build(BuildContext context) {
    final outerSize = small ? 96.0 : 140.0;

    return SizedBox(
      height: outerSize,
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          // Decorative translucent circles
          Positioned(
            top: 8,
            left: 6,
            child: _decoCircle(AppColors.primaryColor.withValues(alpha: 0.18), 10),
          ),
          Positioned(
            top: 22,
            right: 28,
            child: _decoCircle(Colors.grey.shade300, 14),
          ),
          Positioned(
            bottom: 30,
            left: 22,
            child: _decoCircle(Colors.grey.shade200, 18),
          ),
          Positioned(
            top: -8,
            right: -6,
            child: _decoCircle(AppColors.primaryColor.withValues(alpha: 0.18), 10),
          ),

          Container(
            width: outerSize,
            height: outerSize,
            decoration: const BoxDecoration(
              color: AppColors.primaryColor,
              shape: BoxShape.circle,
            ),
            padding: const EdgeInsets.all(32),
            child: FittedBox(
              fit: BoxFit.contain,
              child: Image.asset(
                Assets.checkedIcon,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _decoCircle(Color color, double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}

class _ArrivalGraphic extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final sw = context.screenWidth;
    final size = (sw * 0.32).clamp(120, 170).toDouble();

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: 12,
            left: 14,
            child: _decoCircle(AppColors.primaryColor.withValues(alpha: 0.18), 12),
          ),
          Positioned(
            top: 30,
            right: 24,
            child: _decoCircle(Colors.grey.shade200, 18),
          ),
          Positioned(
            bottom: 22,
            left: 38,
            child: _decoCircle(Colors.grey.shade200, 14),
          ),
          Positioned(
            bottom: 46,
            right: 18,
            child: _decoCircle(AppColors.primaryColor.withValues(alpha: 0.18), 10),
          ),
          Container(
            width: size,
            height: size,
            decoration: const BoxDecoration(
              color: AppColors.primaryColor,
              shape: BoxShape.circle,
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Location pin
                Icon(
                  Icons.location_on,
                  color: Colors.white,
                  size: size * 0.46,
                ),
                // Check in smaller circle
                Positioned(
                  bottom: size * 0.20,
                  child: Container(
                    width: size * 0.32,
                    height: size * 0.32,
                    decoration: const BoxDecoration(
                      color: AppColors.primaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: FittedBox(
                        child: Image.asset(
                          Assets.checkedIcon,
                          width: size * 0.17,
                          height: size * 0.17,
                          color: Colors.white,
                        ),
                      ),
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

  Widget _decoCircle(Color color, double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}

class _PickupRequestSummaryCard extends StatelessWidget {
  const _PickupRequestSummaryCard({required this.data});

  final DriverPickupRequestData data;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shadowColor: Colors.black.withValues(alpha: 0.06),
      color: Colors.transparent,
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
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              data.locationName,
              style: context.robotoFlexBold(fontSize: 18, color: Colors.black),
            ),
            6.ph,
            Row(
              children: [
                const Icon(Icons.location_on_outlined, size: 14, color: Colors.grey),
                4.pw,
                Expanded(
                  child: Text(
                    data.areaName,
                    style: context.robotoFlexRegular(fontSize: 13, color: Colors.grey.shade600),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            6.ph,
            Text(
              data.fullAddress,
              style: context.robotoFlexRegular(fontSize: 12, color: Colors.grey.shade600),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

class _RouteMapPlaceholder extends StatelessWidget {
  const _RouteMapPlaceholder({required this.data});

  final DriverPickupRequestData data;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SizedBox(
            height: 270,
            width: constraints.maxWidth,
            child: Stack(
              children: [
                Container(
                  color: Colors.grey.shade300,
                ),
                Positioned.fill(
                  child: CustomPaint(
                    painter: _RoutePainter(),
                  ),
                ),
                Positioned(
                  left: 12,
                  top: 14,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xff2F2F2F),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '${data.distanceKm}km away',
                      style: context.robotoFlexMedium(fontSize: 13, color: Colors.white),
                    ),
                  ),
                ),
                // Bottom overlay card (as in screenshot)
                Positioned(
                  left: 14,
                  right: 14,
                  bottom: 14,
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.08),
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            data.imageAsset,
                            width: 52,
                            height: 52,
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
                                style: context.robotoFlexBold(fontSize: 14, color: Colors.black),
                              ),
                              4.ph,
                              Row(
                                children: [
                                  const Icon(Icons.location_on_outlined, size: 14, color: Colors.grey),
                                  4.pw,
                                  Expanded(
                                    child: Text(
                                      data.areaName,
                                      style: context.robotoFlexRegular(fontSize: 12, color: Colors.grey.shade600),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '4 min',
                              style: context.robotoFlexBold(fontSize: 14, color: Colors.black),
                            ),
                            4.ph,
                            Text(
                              '1 miles',
                              style: context.robotoFlexRegular(fontSize: 12, color: Colors.grey.shade600),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _RoutePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final roadPaint = Paint()
      ..color = AppColors.primaryColor.withValues(alpha: 0.95)
      ..strokeWidth = max(10, size.width * 0.035)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    // Route line (roughly matches screenshot orientation)
    final route = Path()
      ..moveTo(size.width * 0.2, size.height * 0.78)
      ..cubicTo(
        size.width * 0.3,
        size.height * 0.56,
        size.width * 0.45,
        size.height * 0.52,
        size.width * 0.62,
        size.height * 0.58,
      )
      ..cubicTo(
        size.width * 0.72,
        size.height * 0.62,
        size.width * 0.78,
        size.height * 0.75,
        size.width * 0.84,
        size.height * 0.82,
      );

    canvas.drawPath(route, roadPaint);

    // Start/end markers
    final start = Offset(size.width * 0.2, size.height * 0.78);
    final end = Offset(size.width * 0.84, size.height * 0.82);

    final startPaint = Paint()..color = Colors.black;
    final startInner = Paint()..color = Colors.redAccent;
    canvas.drawCircle(start, max(10, size.width * 0.03), startPaint);
    canvas.drawCircle(start, max(7, size.width * 0.02), startInner);

    final endPaint = Paint()..color = Colors.black;
    final endInner = Paint()..color = AppColors.primaryColor;
    canvas.drawCircle(end, max(10, size.width * 0.03), endPaint);
    canvas.drawCircle(end, max(7, size.width * 0.02), endInner);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _PickupLocationCard extends StatelessWidget {
  const _PickupLocationCard({required this.data});

  final DriverPickupRequestData data;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
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
                  style: context.robotoFlexBold(fontSize: 16, color: Colors.black),
                ),
                6.ph,
                Row(
                  children: [
                    const Icon(Icons.location_on_outlined, size: 14, color: Colors.grey),
                    4.pw,
                    Expanded(
                      child: Text(
                        data.areaName,
                        style: context.robotoFlexRegular(fontSize: 12, color: Colors.grey.shade600),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                4.ph,
                Text(
                  data.fullAddress,
                  style: context.robotoFlexRegular(fontSize: 12, color: Colors.grey.shade600),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LabelValueRow extends StatelessWidget {
  const _LabelValueRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: context.robotoFlexRegular(fontSize: 14, color: Colors.grey.shade600),
        ),
        Text(
          value,
          style: context.robotoFlexSemiBold(fontSize: 14, color: Colors.black),
        ),
      ],
    );
  }
}

class _DriverFlowBottomNavBar extends StatelessWidget {
  const _DriverFlowBottomNavBar({required this.currentIndex});

  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 72,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _NavItem(
                icon: Assets.navHomeIcon,
                label: 'Home',
                isSelected: currentIndex == 0,
                onTap: () => AppRouter.pushAndRemoveUntil(const DriverDashboardView(initialIndex: 0)),
              ),
              _NavItem(
                icon: Assets.requestsIcon,
                label: 'Requests',
                isSelected: currentIndex == 1,
                onTap: () => AppRouter.pushAndRemoveUntil(const DriverDashboardView(initialIndex: 1)),
              ),
              _NavItem(
                icon: Assets.earningIcon,
                label: 'Earning',
                isSelected: currentIndex == 2,
                onTap: () => AppRouter.pushAndRemoveUntil(const DriverDashboardView(initialIndex: 2)),
              ),
              _NavItem(
                icon: Assets.impactIcon,
                label: 'Impact',
                isSelected: currentIndex == 3,
                onTap: () => AppRouter.pushAndRemoveUntil(const DriverDashboardView(initialIndex: 3)),
              ),
              _NavItem(
                icon: Assets.navUserIcon,
                label: 'Profile',
                isSelected: currentIndex == 4,
                onTap: () => AppRouter.pushAndRemoveUntil(const DriverDashboardView(initialIndex: 4)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = isSelected ? AppColors.primaryColor : Colors.black.withValues(alpha: 0.5);

    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(icon, width: 28, height: 28, color: color),
            6.ph,
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 12,
                fontFamily: 'Roboto Flex',
                fontWeight: FontWeight.w600,
              ),
            ),
            6.ph,
            Container(
              height: 4,
              width: 40,
              decoration: BoxDecoration(
                color: isSelected ? Colors.black : Colors.transparent,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

