import '../../../export_all.dart';

import 'driver_pickup_flow_shared_widgets.dart';
import 'driver_upload_photos_view.dart';

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
    final litersLabel =
        _liters == _liters.roundToDouble()
            ? _liters.round().toString()
            : _liters.toStringAsFixed(1);

    return Scaffold(
      backgroundColor: const Color(0xffF9FAFC),
      bottomNavigationBar: const DriverFlowBottomNavBar(currentIndex: 1),
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
              height: 180,
            ),
            Positioned(
              top: contentTop,
              left: 0,
              right: 0,
              bottom: 0,
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(
                  horizontalPadding,
                  8,
                  horizontalPadding,
                  120,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Enter Collected Quantity',
                      style: context.robotoFlexBold(
                        fontSize: 26,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    18.ph,
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 24,
                      ),
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
                            '$litersLabel Liters',
                            style: context.robotoFlexBold(
                              fontSize: 52,
                              color: Colors.black.withValues(alpha: 0.35),
                            ),
                            textAlign: TextAlign.center,
                          ),
                          6.ph,
                          Text(
                            'Enter Collected use cooking oil amount',
                            style: context.robotoFlexRegular(
                              fontSize: 14,
                              color: Colors.black.withValues(alpha: 0.6),
                            ),
                            textAlign: TextAlign.center,
                          ),
                          20.ph,
                          Wrap(
                            spacing: 12,
                            runSpacing: 12,
                            alignment: WrapAlignment.center,
                            children: [
                              _QuickAddButton(
                                label: '+10L',
                                onTap: () => _addLiters(10),
                              ),
                              _QuickAddButton(
                                label: '+25L',
                                onTap: () => _addLiters(25),
                              ),
                              _QuickAddButton(
                                label: '+50L',
                                onTap: () => _addLiters(50),
                              ),
                              _QuickAddButton(
                                label: '+100L',
                                onTap: () => _addLiters(100),
                              ),
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
                            const SnackBar(
                              content: Text(
                                'Please enter collected quantity first.',
                              ),
                            ),
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
                            const SnackBar(
                              content: Text(
                                'Please enter collected quantity first.',
                              ),
                            ),
                          );
                          return;
                        }
                        if (!_confirmed) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Please confirm quantity before uploading photos.',
                              ),
                            ),
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
            // Positioned(
            //   top: MediaQuery.paddingOf(context).top + 8,
            //   left: 12,
            //   child: GestureDetector(
            //     onTap: () => AppRouter.back(),
            //     child: const Padding(
            //       padding: EdgeInsets.all(8),
            //       child: Icon(
            //         Icons.arrow_back_ios_new,
            //         color: Colors.white,
            //         size: 22,
            //       ),
            //     ),
            //   ),
            // ),
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
