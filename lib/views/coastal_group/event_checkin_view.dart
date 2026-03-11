import '../../export_all.dart';

/// Event check-in screen: map, Check-in button, checked-in members, Message Team, View Instructions.
class EventCheckinView extends ConsumerStatefulWidget {
  const EventCheckinView({
    super.key,
    required this.event,
  });

  final CleanupEventItem event;

  @override
  ConsumerState<EventCheckinView> createState() => _EventCheckinViewState();
}

class _EventCheckinViewState extends ConsumerState<EventCheckinView> {
  bool _isCheckedIn = false;

  void _showCheckedInDialog() {
    showDialog<void>(
      context: context,
      barrierColor: Colors.black54,
      builder: (ctx) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.symmetric(
          horizontal: context.screenWidth * 0.1,
        ),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.15),
                blurRadius: 20,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Builder(
                builder: (context) {
                  final sw = context.screenWidth;
                  final sh = context.screenHeight;
                  final scale = (sw + sh) * 0.0004;
                  final r = (70 * scale).clamp(50.0, 90.0);
                  final decoSize = (13 * scale).clamp(10.0, 18.0);

                  return Stack(
                    alignment: Alignment.center,
                    clipBehavior: Clip.none,
                    children: [
                      Positioned(
                        top: -8,
                        right: -r,
                        child: _decoCircle((43 * scale).clamp(35.0, 50.0)),
                      ),
                      Positioned(
                        top: 55,
                        right: -(r * 0.65),
                        child: _decoCircle(decoSize),
                      ),
                      Positioned(
                        top: 85,
                        right: -(r * 0.9),
                        child: _decoCircle(decoSize),
                      ),
                      Positioned(
                        top: 120,
                        right: -(r * 0.6),
                        child: _decoCircle(decoSize),
                      ),
                      Positioned(
                        top: 25,
                        left: -(r * 0.7),
                        child: _decoCircle(decoSize),
                      ),
                      Positioned(
                        top: 100,
                        left: -(r * 0.5),
                        child: _decoCircle(decoSize),
                      ),
                      Container(
                        width: 135,
                        height: 135,
                        padding: const EdgeInsets.all(35),
                        decoration: const BoxDecoration(
                          color: AppColors.primaryColor,
                          shape: BoxShape.circle,
                        ),
                        alignment: Alignment.center,
                        child: Image.asset(Assets.checkedIcon),
                      ),
                    ],
                  );
                },
              ),
              20.ph,
              Text(
                "You're Checked In!",
                style: context.robotoFlexBold(
                  fontSize: 22,
                  color: Colors.black,
                ),
              ),
              8.ph,
              Text(
                'Thank you for contributing!',
                style: context.robotoFlexRegular(
                  fontSize: 15,
                  color: Colors.grey.shade700,
                ),
              ),
              16.ph,
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Column(
                  children: [
                    Text(
                      "You're checked in successfully at:",
                      style: context.robotoFlexRegular(
                        fontSize: 13,
                        color: Colors.grey.shade700,
                      ),
                    ),
                    4.ph,
                    Text(
                      '10:05 AM',
                      style: context.robotoFlexBold(
                        fontSize: 20,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              24.ph,
              CustomButtonWidget(
                label: 'Done',
                onPressed: () {
                  Navigator.of(ctx).pop();
                  setState(() => _isCheckedIn = true);
                },
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = context.screenWidth * 0.05;
    final contentTop = context.screenHeight * 0.24;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            CoastalGroupHeader(
              sectionTitle: 'Upcoming Cleanups',
              height: context.screenHeight * 0.30,
              onNotificationTap: () => AppRouter.push(const NotificationView()),
              leading: GestureDetector(
                onTap: () => AppRouter.back(),
                child: const Padding(
                  padding: EdgeInsets.only(top: 4),
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                    size: 22,
                  ),
                ),
              ),
            ),
            Positioned(
              top: contentTop,
              left: 0,
              right: 0,
              bottom: 0,
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(
                  horizontalPadding,
                  16,
                  horizontalPadding,
                  24,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildEventCard(),
                    20.ph,
                    _buildMarkAttendanceSection(),
                    20.ph,
                    _buildCheckedInMembersCard(context),
                    24.ph,
                    CustomButtonWidget(
                      label: 'Message Team',
                      onPressed: () => AppRouter.push(
                        SendMessageView(event: widget.event),
                      ),
                      height: 52,
                    ),
                    12.ph,
                    CustomButtonWidget(
                      label: 'View Instructions',
                      onPressed: () => AppRouter.push(
                        CleanupInstructionsView(event: widget.event),
                      ),
                      backgroundColor: const Color(0xff414141),
                      height: 52,
                    ),
                    100.ph,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildEventCard() {
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
            widget.event.title,
            style: context.robotoFlexBold(fontSize: 18, color: Colors.black),
          ),
          8.ph,
          Row(
            children: [
              Image.asset(
                Assets.locationIcon,
                width: 18,
                height: 18,
                color: Colors.grey.shade600,
              ),
              8.pw,
              Text(
                '${widget.event.location}, CA 95521',
                style: context.robotoFlexRegular(
                  fontSize: 14,
                  color: Colors.grey.shade700,
                ),
              ),
            ],
          ),
          16.ph,
          Container(
            height: 160,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Icon(
                  Icons.map_rounded,
                  size: 48,
                  color: AppColors.primaryColor.withValues(alpha: 0.5),
                ),
                Positioned(
                  bottom: 24,
                  child: Icon(
                    Icons.location_on,
                    size: 40,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMarkAttendanceSection() {
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
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Mark Attendance',
            style: context.robotoFlexBold(fontSize: 18, color: Colors.black),
          ),
          8.ph,
          Text(
            'Tap the button below to check-in',
            style: context.robotoFlexRegular(
              fontSize: 14,
              color: Colors.grey.shade700,
            ),
          ),
          16.ph,
          CustomButtonWidget(
            label: 'Check-in',
            onPressed: _isCheckedIn ? null : _showCheckedInDialog,
            height: 50,
          ),
          12.ph,
          Text(
            _isCheckedIn ? 'Checked-in' : 'Not Checked-in',
            style: context.robotoFlexRegular(
              fontSize: 13,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCheckedInMembersCard(BuildContext context) {
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
            'Checked-in Members',
            style: context.robotoFlexBold(fontSize: 18, color: Colors.black),
          ),
          16.ph,
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {},
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 22,
                          backgroundColor:
                              AppColors.primaryColor.withValues(alpha: 0.3),
                          child: Text(
                            'S',
                            style: context.robotoFlexBold(
                              fontSize: 18,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ),
                        12.pw,
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Sam',
                                style: context.robotoFlexSemiBold(
                                  fontSize: 15,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                'Team leader',
                                style: context.robotoFlexRegular(
                                  fontSize: 12,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 14,
                          color: Colors.grey.shade600,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              12.pw,
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _smallAvatar('A'),
                  _smallAvatar('B'),
                  _smallAvatar('C'),
                  const SizedBox(width: 4),
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        '+22',
                        style: context.robotoFlexSemiBold(
                          fontSize: 11,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          12.ph,
          Text(
            '4 of 17 Participants Checked-in',
            style: context.robotoFlexRegular(
              fontSize: 13,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _smallAvatar(String letter) {
    return Transform.translate(
      offset: const Offset(-8, 0),
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 1.5),
        ),
        child: Center(
          child: Text(
            letter,
            style: context.robotoFlexSemiBold(
              fontSize: 12,
              color: Colors.black87,
            ),
          ),
        ),
      ),
    );
  }

  Widget _decoCircle(double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.primaryColor.withValues(alpha: 0.22),
      ),
    );
  }
}
