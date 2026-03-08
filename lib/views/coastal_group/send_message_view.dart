import '../../export_all.dart';

/// Send message to cleanup participants. Shows event context and team leader message.
class SendMessageView extends ConsumerStatefulWidget {
  const SendMessageView({
    super.key,
    required this.event,
  });

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
              sectionTitle: 'Send Message',
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
                    _buildTeamLeaderMessage(),
                    24.ph,
                    CustomTextFieldWidget(
                      controller: _messageController,
                      hint: 'Write a Message',
                      maxLines: 4,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                    ),
                    16.ph,
                    CustomButtonWidget(
                      label: 'Send',
                      onPressed: () {},
                      backgroundColor: const Color(0xff414141),
                      height: 50,
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
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.event.title,
            style: context.robotoFlexBold(fontSize: 16, color: Colors.black),
          ),
          6.ph,
          Text(
            'Sending to: All Cleanup Participants',
            style: context.robotoFlexRegular(
              fontSize: 13,
              color: Colors.grey.shade700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTeamLeaderMessage() {
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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 24,
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
                10.ph,
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    "Let's gather at the meeting point by the lifeguard station when you're ready!",
                    style: context.robotoFlexRegular(
                      fontSize: 14,
                      color: Colors.black87,
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
}
