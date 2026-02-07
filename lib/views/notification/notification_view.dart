import '../../export_all.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  List<NotificationDataModel> _list = [];

  @override
  void initState() {
    super.initState();
    _list = List.from(demoNotificationList);
  }

  void _markAllAsRead() {
    setState(() {
      _list = _list.map((n) => n.copyWith(isRead: true)).toList();
    });
  }

  void _onTapNotification(NotificationDataModel notification) {
    setState(() {
      final i = _list.indexWhere((e) => e.id == notification.id);
      if (i >= 0) {
        _list = List.from(_list);
        _list[i] = _list[i].copyWith(isRead: true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final grouped = NotificationHelper.groupByTodayAndLastWeek(_list);

    return CustomInnerScreenTemplate(
      title: 'Notifications',
      actionButton: IconButton(
        onPressed: _markAllAsRead,
        icon: Container(
          width: 40,
          height: 40,
          padding: EdgeInsets.all(10),
          decoration: const ShapeDecoration(
            color: Colors.white,
            shape: OvalBorder(
              side: BorderSide(width: 1, color: Color(0xFFC9C9C9)),
            ),
          ),
          child: Image.asset(Assets.checkBlackIcon, width: 20, height: 20),
        ),
      ),
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        children: [
          _buildSection(
            context,
            NotificationHelper.sectionToday,
            grouped[NotificationHelper.sectionToday] ?? [],
          ),
          _buildSection(
            context,
            NotificationHelper.sectionLastWeek,
            grouped[NotificationHelper.sectionLastWeek] ?? [],
          ),
        ],
      ),
    );
  }

  Widget _buildSection(
    BuildContext context,
    String sectionTitle,
    List<NotificationDataModel> items,
  ) {
    if (items.isEmpty) return SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          sectionTitle,
          style: context.robotoFlexSemiBold(fontSize: 17, color: Colors.black),
        ),
        12.ph,
        ...items.map(
          (n) => _NotificationTile(
            notification: n,
            onTap: () => _onTapNotification(n),
          ),
        ),
        24.ph,
      ],
    );
  }
}

class _NotificationTile extends StatelessWidget {
  const _NotificationTile({required this.notification, required this.onTap});

  final NotificationDataModel notification;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final iconAsset = notification.iconType == NotificationIconType.reward
        ? Assets.bookMarkIcon
        : Assets.checkBlackIcon;

    return Container(
      decoration: ShapeDecoration(
        color: notification.isRead ? const Color(0xFFECEFF4) : Colors.transparent,
        shape:  RoundedRectangleBorder(
          side: !notification.isRead ? BorderSide(width: 1, color: const Color(0xFFE0E1E4)) : BorderSide.none,
          borderRadius: BorderRadius.circular(13),
        ) ,
      ),
      margin: EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(13),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: ShapeDecoration(
                  shape: OvalBorder(
                    side: BorderSide(width: 1, color: const Color(0xFF7B7B7B)),
                  ),
                ),
                child: Center(
                  child: Image.asset(iconAsset, width: 22, height: 22),
                ),
              ),
              14.pw,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      notification.title,
                      style: context.robotoFlexSemiBold(
                        fontSize: 15,
                        color: Colors.black,
                      ),
                    ),
                    10.ph,
                    Text(
                      NotificationHelper.formatTime(notification.timestamp),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 11,
                        fontFamily: 'Roboto Flex',
                        fontWeight: FontWeight.w300,
                        height: 1,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 15,
                height: 15,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: !notification.isRead
                      ? const Color(0xFFC9C9C9)
                      : AppColors.primaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
