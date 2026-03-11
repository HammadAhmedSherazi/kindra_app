import '../../export_all.dart';

/// Send message to cleanup participants. Shows event context and team leader message.
class SendMessageView extends ConsumerStatefulWidget {
  const SendMessageView({super.key, required this.event});

  final CleanupEventItem event;

  @override
  ConsumerState<SendMessageView> createState() => _SendMessageViewState();
}

class _SendMessageViewState extends ConsumerState<SendMessageView> {
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
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
              sectionTitle: '',
              height: context.screenHeight * 0.30,
              onNotificationTap: () => AppRouter.push(const NotificationView()),
              // leading: GestureDetector(
              //   onTap: () => AppRouter.back(),
              //   child: const Padding(
              //     padding: EdgeInsets.only(top: 4),
              //     child: Icon(
              //       Icons.arrow_back_ios,
              //       color: Colors.white,
              //       size: 22,
              //     ),
              //   ),
              // ),
            ),
            Positioned(
              top: contentTop,
              left: 20,
              right: 20,
              bottom: 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(child: _buildMainCard(context)),
                  100.ph,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMainCard(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => AppRouter.back(),
                  child: Container(
                    width: 40,
                    height: 40,
                    padding: const EdgeInsets.only(left: 8),
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: OvalBorder(
                        side: BorderSide(
                          width: 1,
                          color: const Color(0xFFC9C9C9),
                        ),
                      ),
                    ),
                    child: const Icon(Icons.arrow_back_ios, size: 18),
                  ),
                ),

                Text(
                  'Send Message',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontFamily: 'Roboto Flex',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(width: 40),
              ],
            ),
            20.ph,
            _buildEventCard(),
            20.ph,
            _buildTeamLeaderMessage(),
            Spacer(),
            CustomTextFieldWidget(
              controller: _messageController,
              hint: 'Write a Message',
              maxLines: 1,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              suffixIcon: Padding(
                padding: const EdgeInsets.only(right: 8),
                child: CustomButtonWidget(
                  label: 'Send',
                  onPressed: () {},
                  backgroundColor: const Color(0xff414141),
                  height: 40,
                  expandWidth: false,
                  textSize: 14,
                ),
              ),
              suffixIconConstraints: const BoxConstraints(
                minWidth: 80,
                minHeight: 40,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEventCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xffFAFAFA),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            widget.event.title,
            style: context.robotoFlexBold(fontSize: 14, color: Colors.black),
          ),
          6.ph,
          Text(
            'Sending to: All Cleanup Participants',
            style: context.robotoFlexRegular(
              fontSize: 10,
              color: Colors.grey.shade700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTeamLeaderMessage() {
    return Container(
      padding: const EdgeInsets.all(10),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 22,
                backgroundColor: AppColors.primaryColor.withValues(alpha: 0.3),
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
            ],
          ),
          // 10.ph,
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),

            child: Text(
              "Let's gather at the meeting point by the lifeguard station when you're ready!",
              style: context.robotoFlexRegular(
                fontSize: 12,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
